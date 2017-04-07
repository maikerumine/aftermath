--Molotov Cocktail_[rev002]
--base code is from throwing enhanced and potions mods

local MOD_NAME = minetest.get_current_modname()
local MOD_PATH = minetest.get_modpath(MOD_NAME)

local function nimbus(pos, radius)
	for dx=-radius,radius do
		for dy=radius,-radius,-1 do
			for dz=-radius,radius do
				local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
				local pa = {x=p.x, y=p.y+1, z=p.z}
				local n = minetest.env:get_node(p).name
				local na = minetest.env:get_node(pa).name
				if n ~= "air" and na == "air" then
					minetest.sound_play('more_fire_ignite', {pos = pos})
					minetest.env:set_node(pa, {name='fire:basic_flame'})
				end
			end
		end
	end
end

local function throw_cocktail(item, player)
	local playerpos = player:getpos()
	local obj = minetest.add_entity({x=playerpos.x,y=playerpos.y+1.625,z=playerpos.z}, 'cityscape:molotov_entity')
	local dir = player:get_look_dir()
	obj:setvelocity({x=dir.x*30, y=dir.y*30, z=dir.z*30})
	obj:setacceleration({x=dir.x*-3, y=-dir.y^8*80-10, z=dir.z*-3})
	if not minetest.setting_getbool('creative_mode') then
		item:take_item()
	end
	return item
end

local function napalm(pos)
	minetest.sound_play('more_fire_ignite', {pos=pos, gain=1})
	minetest.set_node(pos, {name='fire:basic_flame'})
	local radius = 5

	minetest.add_particlespawner({
		amount = 10,
		time = 0.2,
		minpos = vector.subtract(pos, radius / 2),
		maxpos = vector.add(pos, radius / 2),
		minvel = {x=-2, y=-2, z=-2},
		maxvel = {x=2,  y=-4,  z=2},
		minacc = {x=0, y=-4, z=0},
		--~ maxacc = {x=-20, y=-50, z=-50},
		minexptime = 1,
		maxexptime = 1.5,
		minsize = 1,
		maxsize = 2,
		texture = 'more_fire_spark.png',
	})
	minetest.add_particlespawner({
		amount = 10,
		time = 0.2,
		minpos = vector.subtract(pos, radius / 2),
		maxpos = vector.add(pos, radius / 2),
		minvel = {x=-1.25, y=-1.25, z=-1.25},
		maxvel = {x=0.5, y=-4, z=0.5},
		minacc = {x=1.25,  y=-1.25,  z=1.25},
		--~ maxacc = {x=-20, y=-50, z=-50},
		minexptime =1,
		maxexptime = 1.5,
		minsize = 1,
		maxsize = 2,
		texture = 'more_fire_spark.png',
	})
end

local function molotov_entity_on_step(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)
	minetest.add_particlespawner({
		amount = 10,
		time = 0.5,
		minpos = pos,
		maxpos = pos,
		minvel = {x=-0, y=0, z=-0.5},
		maxvel = {x=0,  y=0,  z=-0.75},
		minacc = vector.new(),
		maxacc = vector.new(),
		minexptime = 0.5,
		maxexptime = 1,
		minsize = 0.25,
		maxsize = 0.5,
		texture = 'more_fire_smoke.png',
	})
	minetest.add_particlespawner({
		amount = 100,
		time = 0.25,
		minpos = pos,
		maxpos = pos,
		minvel = {x=-0, y=0, z=-0.5},
		maxvel = {x=0,  y=0,  z=-0.75},
		minacc = {x=0,  y=0,  z=-0.75},
		maxacc = {x=-0, y=0, z=-0.5},
		minexptime = 0.25,
		maxexptime = 0.5,
		minsize = 0.5,
		maxsize = 0.75,
		texture = 'more_fire_spark.png',
	})
	if self.timer>0.2 then
		local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= 'cityscape:molotov_entity' and obj:get_luaentity().name ~= '__builtin:item' then
					if self.node ~= '' then
						minetest.sound_play('more_fire_shatter', {gain = 1.0})
						nimbus(pos, 3)
					end
					self.object:remove()
				end
			else
				if self.node ~= '' then
					minetest.sound_play('more_fire_shatter', {gain = 1.0})
					nimbus(pos, 2)
				end
				self.object:remove()
			end
		end
	end

	if self.lastpos.x~=nil then
		if node.name ~= 'air' then
			if self.node ~= '' then
				minetest.sound_play('more_fire_shatter', {gain = 1.0})
				nimbus(pos, 1)
			end
			self.object:remove()
			napalm(self.lastpos)
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z}
end

minetest.register_entity('cityscape:molotov_entity', {
	timer=0,
	collisionbox = {0,0,0,0,0,0},
	physical = false,
	textures = {'more_fire_molotov_cocktail.png'},
	lastpos={},
	on_step = molotov_entity_on_step,
})

minetest.register_craftitem('cityscape:molotov_cocktail', {
	description = 'Molotov Cocktail',
	inventory_image = 'more_fire_molotov_cocktail.png',
	on_place = throw_cocktail,
	on_use = throw_cocktail,
})

minetest.register_abm({
	nodenames={'fire:basic_flame'},
	neighbors={'air'},
	interval = 1,
	chance = 2,
	action = function(pos, node)
		if minetest.get_node({x=pos.x, y=pos.y+1.0, z=pos.z}).name == 'air' and minetest.get_node({x=pos.x, y=pos.y+2.0, z=pos.z}).name == 'air' then
			minetest.add_particlespawner({
				amount = 30,
				time = 2,
				minpos = pos,
				maxpos = pos,
				minvel = {x=-2, y=2, z=-2},
				maxvel = {x=1, y=3, z=1},
				minacc = {x=0, y=6, z=0},
				maxacc = {x=0, y=2, z=0},
				minexptime = 1,
				maxexptime = 3,
				minsize = 10,
				maxsize = 20,
				collisiondetection = false,
				texture = 'more_fire_smoke.png',
			})
			minetest.add_particlespawner({
				amount = 15,
				time = 4,
				minpos = pos,
				maxpos = pos,
				minvel = {x=0, y= 3, z=0},
				maxvel = {x=0, y=5, z=0},
				minacc = {x=0.1, y=0.5, z=-0.1},
				maxacc = {x=-0.2, y=2, z=0.2},
				minexptime = 1,
				maxexptime = 3,
				minsize = 5,
				maxsize = 10,
				collisiondetection = false,
				texture ='more_fire_smoke.png',
			})
		end
	end
})

minetest.register_craft({
	output = "cityscape:molotov_cocktail 7",
	recipe = {
		{"vessels:glass_bottle", "farming:cotton", "vessels:glass_bottle"},
		{"vessels:glass_bottle", "cityscape:gasoline", "vessels:glass_bottle"},
		{"vessels:glass_bottle", "vessels:glass_bottle", "vessels:glass_bottle"},
	},
})

-- fuel recipes
minetest.register_craft({
	type = 'fuel',
	recipe = 'cityscape:molotov_cocktail',
	burntime = 5,
})
