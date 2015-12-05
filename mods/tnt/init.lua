tnt = {}


-- loss probabilities array (one in X will be lost)
local loss_prob = {}

loss_prob["default:cobble"] = 3
loss_prob["default:dirt"] = 4
loss_prob["tnt:tnt"] = 1

local radius = tonumber(minetest.setting_get("tnt_radius") or 3)

-- Fill a list with data for content IDs, after all nodes are registered
local cid_data = {}
minetest.after(0, function()
	for name, def in pairs(minetest.registered_nodes) do
		cid_data[minetest.get_content_id(name)] = {
			name = name,
			drops = def.drops,
			flammable = def.groups.flammable,
			groups = def.groups,
		}
	end
end)

function tnt:rand_pos(center, pos, radius)
	pos.x = center.x + math.random(-radius, radius)
	pos.z = center.z + math.random(-radius, radius)
end

function tnt:eject_drops(drops, pos, radius)
	local drop_pos = vector.new(pos)
	for _, item in pairs(drops) do
		local count = item:get_count()
		local max = item:get_stack_max()
		if count > max then
			item:set_count(max)
		end
		while count > 0 do
			if count < max then
				item:set_count(count)
			end
			tnt:rand_pos(pos, drop_pos, radius)
			local obj = minetest.add_item(drop_pos, item)
			if obj then
				obj:get_luaentity().collect = true
				obj:setacceleration({x=0, y=-10, z=0})
				obj:setvelocity({x=math.random(-3, 3), y=10,
						z=math.random(-3, 3)})
			end
			count = count - max
		end
	end
end

function tnt:add_drop(drops, item)
	item = ItemStack(item)
	local name = item:get_name()
	if loss_prob[name] ~= nil and math.random(1, loss_prob[name]) == 1 then
		return
	end

	local drop = drops[name]
	if drop == nil then
		drops[name] = item
	else
		drop:set_count(drop:get_count() + item:get_count())
	end
end

function tnt:destroy(drops, pos, cid)
	if minetest.is_protected(pos, "") then
		return
	end
	local def = cid_data[cid]
	-- bedrock
	if def and def.groups.immortal ~= nil then
		return
	end
	-- obsidian
	if def and def.name == "default:obsidian" then
		return
	end
	minetest.remove_node(pos)
	if def then
		local node_drops = minetest.get_node_drops(def.name, "")
		for _, item in ipairs(node_drops) do
			tnt:add_drop(drops, item)
		end
	end
end


function tnt:calc_velocity(pos1, pos2, old_vel, power)
	local vel = vector.direction(pos1, pos2)
	vel = vector.normalize(vel)
	vel = vector.multiply(vel, power)

	-- Divide by distance
	local dist = vector.distance(pos1, pos2)
	dist = math.max(dist, 3)
	vel = vector.divide(vel, dist)

	-- Add old velocity
	vel = vector.add(vel, old_vel)
	return vel
end

function tnt:entity_physics(pos, radius)
	-- Make the damage radius larger than the destruction radius
	radius = radius * 2
	local objs = minetest.get_objects_inside_radius(pos, radius)
	for _, obj in pairs(objs) do
		local obj_pos = obj:getpos()
		local obj_vel = obj:getvelocity()
		local dist = math.max(1, vector.distance(pos, obj_pos))

		if obj_vel ~= nil then
			local vel = tnt:calc_velocity(pos, obj_pos,
					obj_vel, radius * 10)
			obj:setvelocity({x=vel.x, y=vel.y, z=vel.z})
			obj:setacceleration({x=-vel.x/5, y=-10, z=-vel.z/5})
		end

		local damage = (4 / dist) * radius
		obj:set_hp(obj:get_hp() - damage)
	end
end

function tnt:add_effects(pos, radius)
	minetest.add_particlespawner({
		amount = 128,
		time = 1,
		minpos = vector.subtract(pos, radius / 2),
		maxpos = vector.add(pos, radius / 2),
		minvel = {x=-20, y=-20, z=-20},
		maxvel = {x=20,  y=20,  z=20},
		minacc = vector.new(),
		maxacc = vector.new(),
		minexptime = 1,
		maxexptime = 3,
		minsize = 8,
		maxsize = 16,
		texture = "tnt_smoke.png",
	})
end

function tnt:burn(pos)
	local name = minetest.get_node(pos).name
	if name == "tnt:tnt" then
		minetest.sound_play("tnt_ignite", {pos=pos})
		tnt:lit(pos, name)
	elseif name == "tnt:gunpowder" then
		minetest.sound_play("tnt_gunpowder_burning", {pos=pos, gain=2})
		minetest.set_node(pos, {name="tnt:gunpowder_burning"})
		minetest.get_node_timer(pos):start(1)
	end
end

function tnt:explode(pos, radius)
	local pos = vector.round(pos)
	local vm = VoxelManip()
	local pr = PseudoRandom(os.time())
	local p1 = vector.subtract(pos, radius)
	local p2 = vector.add(pos, radius)
	local minp, maxp = vm:read_from_map(p1, p2)
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()

	local drops = {}
	local p = {}

	local c_air = minetest.get_content_id("air")
	local c_tnt = minetest.get_content_id("tnt:tnt")
	local c_tnt_burning = minetest.get_content_id("tnt:tnt_burning")
	local c_gunpowder = minetest.get_content_id("tnt:gunpowder")
	local c_gunpowder_burning = minetest.get_content_id("tnt:gunpowder_burning")
	local c_boom = minetest.get_content_id("tnt:boom")
	local c_fire = minetest.get_content_id("fire:basic_flame")

	-- don't destroy any blocks when in water
	local p0 = {x=pos.x-1, y=pos.y, z=pos.z-1}
	local p1 = {x=pos.x+1, y=pos.y, z=pos.z+1}
	if #minetest.find_nodes_in_area(p0, p1, {"group:water"}) > 0 then return {} end

	for z = -radius, radius do
	for y = -radius, radius do
	local vi = a:index(pos.x + (-radius), pos.y + y, pos.z + z)
	local ntnt = 1
	for x = -radius, radius do
		if (x * x) + (y * y) + (z * z) <=
				(radius * radius) + pr:next(-radius, radius) then
			local cid = data[vi]
			p.x = pos.x + x
			p.y = pos.y + y
			p.z = pos.z + z
			if cid == c_tnt then
				minetest.after(ntnt+math.random(1,9)/10, function()
					tnt:boom(p)
				end)
				ntnt = ntnt + 1
			end
			if cid == c_gunpowder then
				tnt:burn(p)
			elseif cid ~= c_tnt_burning and
					cid ~= c_gunpowder_burning and
					cid ~= c_air and
					cid ~= c_fire and
					cid ~= c_boom then
				tnt:destroy(drops, p, cid)
			end
		end
		vi = vi + 1
	end
	end
	end

	return drops
end


--integrate with city-block
--[[function tnt:explode(pos, radius)
	local pos = vector.round(pos)
	local vm = VoxelManip()
	local pr = PseudoRandom(os.time())
	local p1 = vector.subtract(pos, radius)
	local p2 = vector.add(pos, radius)
	local minp, maxp = vm:read_from_map(p1, p2)
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()

	local drops = {}
	local p = {}

	local c_air = minetest.get_content_id("air")
	local c_tnt = minetest.get_content_id("tnt:tnt")
	local c_tnt_burning = minetest.get_content_id("tnt:tnt_burning")
	local c_gunpowder = minetest.get_content_id("tnt:gunpowder")
	local c_gunpowder_burning = minetest.get_content_id("tnt:gunpowder_burning")
	local c_boom = minetest.get_content_id("tnt:boom")
	local c_fire = minetest.get_content_id("fire:basic_flame")

	-- don't destroy any blocks when protected
	local p0 = {x=pos.x-33, y=pos.y-33, z=pos.z-33}
	local p1 = {x=pos.x+33, y=pos.y+33, z=pos.z+33}
	if #minetest.find_nodes_in_area(p0, p1, {"city_block:cityblock"}) > 0 then return {} end

	for z = -radius, radius do
	for y = -radius, radius do
	local vi = a:index(pos.x + (-radius), pos.y + y, pos.z + z)
	local ntnt = 1
	for x = -radius, radius do
		if (x * x) + (y * y) + (z * z) <=
				(radius * radius) + pr:next(-radius, radius) then
			local cid = data[vi]
			p.x = pos.x + x
			p.y = pos.y + y
			p.z = pos.z + z
			if cid == c_tnt then
				minetest.after(ntnt+math.random(1,9)/10, function()
					tnt:boom(p)
				end)
				ntnt = ntnt + 1
			end
			if cid == c_gunpowder then
				tnt:burn(p)
			elseif cid ~= c_tnt_burning and
					cid ~= c_gunpowder_burning and
					cid ~= c_air and
					cid ~= c_fire and
					cid ~= c_boom then
				tnt:destroy(drops, p, cid)




	if city_block:in_city(pos) then
        minetest.chat_send_player(placer:get_player_name(), "Don't do that in town!")
	end

			end
		end
		vi = vi + 1
	end
	end
	end

	return drops
end]]


function tnt:lit( p, n )
	minetest.remove_node( p )
	minetest.add_entity( p, 'tnt:tnt_ent' )
end

function tnt:boom(pos)
	minetest.sound_play("tnt_explode", {pos=pos, gain=1.5, max_hear_distance=2*64})

	local drops = tnt:explode(pos, radius)
	tnt:entity_physics(pos, radius)
	tnt:eject_drops(drops, pos, radius)
	tnt:add_effects(pos, radius)
end

local function meseboom(pos)
	minetest.remove_node(pos)
	tnt:boom(pos)
end

local function lavaboom(pos)
	local name = minetest.get_node(pos).name
	tnt:lit(pos, name)
end

minetest.register_node("tnt:tnt", {
	description = "TNT",
	tiles = {"tnt_top.png", "tnt_bottom.png", "tnt_side.png"},
	groups = {dig_immediate=2, mesecon=2},
	sounds = default.node_sound_wood_defaults(),
	on_punch = function(pos, node, puncher)
		if puncher:get_wielded_item():get_name() == "default:torch" then
			minetest.sound_play("tnt_ignite", {pos=pos})
			tnt:lit(pos, node)
		end
	end,
	mesecons = {effector = {action_on = meseboom}},
})

minetest.register_node("tnt:gunpowder", {
	description = "Gun Powder",
	drawtype = "raillike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	tiles = {"tnt_gunpowder.png",},
	inventory_image = "tnt_gunpowder_inventory.png",
	wield_image = "tnt_gunpowder_inventory.png",
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {dig_immediate=2,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),

	on_punch = function(pos, node, puncher)
		if puncher:get_wielded_item():get_name() == "default:torch" then
			tnt:burn(pos)
		end
	end,
})

minetest.register_node("tnt:gunpowder_burning", {
	drawtype = "raillike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	light_source = 5,
	tiles = {{
		name = "tnt_gunpowder_burning_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1,
		}
	}},
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	drop = "",
	groups = {dig_immediate=2,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	on_timer = function(pos, elapsed)
		for dx = -1, 1 do
		for dz = -1, 1 do
		for dy = -1, 1 do
			if not (dx == 0 and dz == 0) then
				tnt:burn({
					x = pos.x + dx,
					y = pos.y + dy,
					z = pos.z + dz,
				})
			end
		end
		end
		end
		minetest.remove_node(pos)
	end
})

minetest.register_abm({
	nodenames = {"tnt:tnt", "tnt:gunpowder"},
	neighbors = {"fire:basic_flame", "default:lava_source", "default:lava_flowing"},
	interval = 1,
	chance = 1,
	action = lavaboom,
})

minetest.register_craft({
	output = "tnt:gunpowder",
	type = "shapeless",
	recipe = {"default:coal_lump", "default:gravel"}
})
minetest.register_craft({
	output = "tnt:tnt",
	recipe = {
		{"",           "group:wood",    ""},
		{"group:wood", "tnt:gunpowder", "group:wood"},
		{"",           "group:wood",    ""}
	}
})
--------------------------------------------------------------------------------
--	TNT
--------------------------------------------------------------------------------
--	A simple TNT mod which damages both terrain and entities.
--	Barely based on bcmpinc's pull request.
--
--	(c)2012 Fernando Zapata (ZLovesPancakes, Franz.ZPT)
--	Code licensed under GNU GPLv2
--		http://www.gnu.org/licenses/gpl-2.0.html
--	Content licensed under CC BY-SA 3.0
--		http://creativecommons.org/licenses/by-sa/3.0/
--------------------------------------------------------------------------------

-------------------------------------------------------------- Entities --------

tnt.ent_proto = {
	hp_max		= 1000,
	physical	= true,
	collisionbox	= { -1/2, -1/2, -1/2, 1/2, 1/2, 1/2 },
	visual		= 'cube',
	textures = {	'tnt_top.png', 'tnt_bottom.png', 'tnt_side.png',
			'tnt_side.png', 'tnt_side.png', 'tnt_side.png' },

	timer		= 0,
	btimer		= 0,
	bstatus		= true,
	physical_state	= true,

	on_activate = function( sf, sd )
		sf.object:set_armor_groups( { immortal=1 } )
		sf.object:setvelocity({x=math.random(-40,40)/40, y=4, z=math.random(-40,40)/40})
		sf.object:setacceleration({x=0, y=-10, z=0})
		sf.object:settexturemod('^[brighten')
	end,

	on_step = function( sf, dt )
		sf.timer = sf.timer + dt
		sf.btimer = sf.btimer + dt
		if sf.btimer > 0.5 then
			sf.btimer = sf.btimer - 0.5
			if sf.bstatus then
				sf.object:settexturemod('')
			else
				sf.object:settexturemod('^[brighten')
			end
			sf.bstatus = not sf.bstatus
		end
		if sf.timer > 0.5 then
			local p = sf.object:getpos()
			p.y = p.y - 0.501
			local nn = minetest.get_node(p).name
			if not minetest.registered_nodes[nn] or
				minetest.registered_nodes[nn].walkable then
				sf.object:setvelocity({x=0,y=0,z=0})
				sf.object:setacceleration({x=0, y=0, z=0})
			end
		end
		if sf.timer > 4 then
			local pos = sf.object:getpos()
			local pos2 = {x=math.floor(pos.x+0.5), y=math.floor(pos.y+0.5),
				z=math.floor(pos.z+0.5)}
			tnt:boom(pos2)
			sf.object:remove()
		end
	end,
}

minetest.register_entity( 'tnt:tnt_ent', tnt.ent_proto )


if minetest.setting_get("log_mods") then
	minetest.debug("[TNT] Loaded!")
end

