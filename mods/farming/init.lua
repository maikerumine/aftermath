--[[
	Farming Redo Mod
	by TenPlus1
	NEW growing routine by prestidigitator
	auto-refill by crabman77
]]

farming = {}
farming.mod = "redo"
farming.version = "1.31"
farming.path = minetest.get_modpath("farming")
farming.select = {
	type = "fixed",
	fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
}


local creative_mode_cache = minetest.settings:get_bool("creative_mode")

function farming.is_creative(name)
	return creative_mode_cache or minetest.check_player_privs(name, {creative = true})
end


local statistics = dofile(farming.path.."/statistics.lua")

-- Intllib
local S = dofile(farming.path.."/intllib.lua")
farming.intllib = S


-- Utility Function
local time_speed = tonumber(minetest.settings:get("time_speed")) or 72
local SECS_PER_CYCLE = (time_speed > 0 and 24 * 60 * 60 / time_speed) or 0
local function clamp(x, min, max)
	return (x < min and min) or (x > max and max) or x
end


-- return amount of day or night that has elapsed
-- dt is time elapsed, count_day if true counts day, otherwise night
local function day_or_night_time(dt, count_day)

	local t_day = minetest.get_timeofday()
	local t1_day = t_day - dt / SECS_PER_CYCLE
	local t1_c, t2_c  -- t1_c < t2_c and t2_c always in [0, 1)

	if count_day then

		if t_day < 0.25 then
			t1_c = t1_day + 0.75  -- Relative to sunup, yesterday
			t2_c = t_day  + 0.75
		else
			t1_c = t1_day - 0.25  -- Relative to sunup, today
			t2_c = t_day  - 0.25
		end
	else
		if t_day < 0.75 then
			t1_c = t1_day + 0.25  -- Relative to sundown, yesterday
			t2_c = t_day  + 0.25
		else
			t1_c = t1_day - 0.75  -- Relative to sundown, today
			t2_c = t_day  - 0.75
		end
	end

	local dt_c = clamp(t2_c, 0, 0.5) - clamp(t1_c, 0, 0.5)  -- this cycle

	if t1_c < -0.5 then
		local nc = math.floor(-t1_c)
		t1_c = t1_c + nc
		dt_c = dt_c + 0.5 * nc + clamp(-t1_c - 0.5, 0, 0.5)
	end

	return dt_c * SECS_PER_CYCLE
end


-- Growth Logic
local STAGE_LENGTH_AVG = 160.0
local STAGE_LENGTH_DEV = STAGE_LENGTH_AVG / 6


-- return plant name and stage from node provided
local function plant_name_stage(node)

	local name

	if type(node) == "table" then

		if node.name then
			name = node.name
		elseif node.x and node.y and node.z then
			node = minetest.get_node_or_nil(node)
			name = node and node.name
		end
	else
		name = tostring(node)
	end

	if not name or name == "ignore" then
		return nil
	end

	local sep_pos = name:find("_[^_]+$")

	if sep_pos and sep_pos > 1 then

		local stage = tonumber(name:sub(sep_pos + 1))

		if stage and stage >= 0 then
			return name:sub(1, sep_pos - 1), stage
		end
	end

	return name, 0
end


-- Map from node name to
-- { plant_name = ..., name = ..., stage = n, stages_left = { node_name, ... } }

local plant_stages = {}

farming.plant_stages = plant_stages

--- Registers the stages of growth of a (possible plant) node.
 --
 -- @param node
 --    Node or position table, or node name.
 -- @return
 --    The (possibly zero) number of stages of growth the plant will go through
 --    before being fully grown, or nil if not a plant.

local register_plant_node

-- Recursive helper
local function reg_plant_stages(plant_name, stage, force_last)

	local node_name = plant_name and plant_name .. "_" .. stage
	local node_def = node_name and minetest.registered_nodes[node_name]

	if not node_def then
		return nil
	end

	local stages = plant_stages[node_name]

	if stages then
		return stages
	end

	if minetest.get_item_group(node_name, "growing") > 0 then

		local ns = reg_plant_stages(plant_name, stage + 1, true)
		local stages_left = (ns and { ns.name, unpack(ns.stages_left) }) or {}

		stages = {
			plant_name = plant_name,
			name = node_name,
			stage = stage,
			stages_left = stages_left
		}

		if #stages_left > 0 then

			local old_constr = node_def.on_construct
			local old_destr  = node_def.on_destruct

			minetest.override_item(node_name,
				{
					on_construct = function(pos)

						if old_constr then
							old_constr(pos)
						end

						farming.handle_growth(pos)
					end,

					on_destruct = function(pos)

						minetest.get_node_timer(pos):stop()

						if old_destr then
							old_destr(pos)
						end
					end,

					on_timer = function(pos, elapsed)
						return farming.plant_growth_timer(pos, elapsed, node_name)
					end,
				})
		end

	elseif force_last then

		stages = {
			plant_name = plant_name,
			name = node_name,
			stage = stage,
			stages_left = {}
		}
	else
		return nil
	end

	plant_stages[node_name] = stages

	return stages
end


register_plant_node = function(node)

	local plant_name, stage = plant_name_stage(node)

	if plant_name then

		local stages = reg_plant_stages(plant_name, stage, false)
		return stages and #stages.stages_left
	else
		return nil
	end
end


local function set_growing(pos, stages_left)

	if not stages_left then
		return
	end

	local timer = minetest.get_node_timer(pos)

	if stages_left > 0 then

		if not timer:is_started() then

			local stage_length = statistics.normal(STAGE_LENGTH_AVG, STAGE_LENGTH_DEV)

			stage_length = clamp(stage_length, 0.5 * STAGE_LENGTH_AVG, 3.0 * STAGE_LENGTH_AVG)

			timer:set(stage_length, -0.5 * math.random() * STAGE_LENGTH_AVG)
		end

	elseif timer:is_started() then
		timer:stop()
	end
end


-- detects a crop at given position, starting or stopping growth timer when needed
function farming.handle_growth(pos, node)

	if not pos then
		return
	end

	local stages_left = register_plant_node(node or pos)

	if stages_left then
		set_growing(pos, stages_left)
	end
end


minetest.after(0, function()

	for _, node_def in ipairs(minetest.registered_nodes) do
		register_plant_node(node_def)
	end
end)


local abm_func = farming.handle_growth

-- Just in case a growing type or added node is missed (also catches existing
-- nodes added to map before timers were incorporated).
minetest.register_abm({
	nodenames = { "group:growing" },
	interval = 300,
	chance = 1,
	action = abm_func
})


-- Plant timer function that grows plants under the right conditions.
function farming.plant_growth_timer(pos, elapsed, node_name)

	local stages = plant_stages[node_name]

	if not stages then
		return false
	end

	local max_growth = #stages.stages_left

	if max_growth <= 0 then
		return false
	end

	if stages.plant_name == "farming:cocoa" then

		if not minetest.find_node_near(pos, 1, {"default:jungletree"}) then
			return true
		end
	else
		local under = minetest.get_node({ x = pos.x, y = pos.y - 1, z = pos.z })

		if minetest.get_item_group(under.name, "soil") < 3 then
			return true
		end
	end

	local growth
	local light_pos = {x = pos.x, y = pos.y, z = pos.z} --  was y + 1
	local lambda = elapsed / STAGE_LENGTH_AVG

	if lambda < 0.1 then
		return true
	end

	local MIN_LIGHT = minetest.registered_nodes[node_name].minlight or 13
	local MAX_LIGHT = minetest.registered_nodes[node_name].maxlight or 15
	--print ("---", MIN_LIGHT, MAX_LIGHT)

	if max_growth == 1 or lambda < 2.0 then

		local light = (minetest.get_node_light(light_pos) or 0)
		--print ("light level:", light)

		if light < MIN_LIGHT or light > MAX_LIGHT then
			return true
		end

		growth = 1
	else
		local night_light  = (minetest.get_node_light(light_pos, 0) or 0)
		local day_light    = (minetest.get_node_light(light_pos, 0.5) or 0)
		local night_growth = night_light >= MIN_LIGHT and night_light <= MAX_LIGHT
		local day_growth = day_light >= MIN_LIGHT and day_light <= MAX_LIGHT

		if not night_growth then

			if not day_growth then
				return true
			end

			lambda = day_or_night_time(elapsed, true) / STAGE_LENGTH_AVG

		elseif not day_growth then

			lambda = day_or_night_time(elapsed, false) / STAGE_LENGTH_AVG
		end

		growth = statistics.poisson(lambda, max_growth)

		if growth < 1 then
			return true
		end
	end

	if minetest.registered_nodes[stages.stages_left[growth]] then

		local p2 = minetest.registered_nodes[stages.stages_left[growth] ].place_param2 or 1

		minetest.swap_node(pos, {name = stages.stages_left[growth], param2 = p2})
	else
		return true
	end

	return growth ~= max_growth
end


-- refill placed plant by crabman (26/08/2015) updated by TenPlus1
function farming.refill_plant(player, plantname, index)

	local inv = player:get_inventory()
	local old_stack = inv:get_stack("main", index)

	if old_stack:get_name() ~= "" then
		return
	end

	for i, stack in ipairs(inv:get_list("main")) do

		if stack:get_name() == plantname and i ~= index then

			inv:set_stack("main", index, stack)
			stack:clear()
			inv:set_stack("main", i, stack)

			return
		end
	end
end


-- Place Seeds on Soil
function farming.place_seed(itemstack, placer, pointed_thing, plantname)

	local pt = pointed_thing

	-- check if pointing at a node
	if not pt or pt.type ~= "node" then
		return
	end

	local under = minetest.get_node(pt.under)

	-- am I right-clicking on something that has a custom on_place set?
	-- thanks to Krock for helping with this issue :)
	local def = minetest.registered_nodes[under.name]
	if def and def.on_rightclick then
		return def.on_rightclick(pt.under, under, placer, itemstack)
	end

	local above = minetest.get_node(pt.above)

	-- check if pointing at the top of the node
	if pt.above.y ~= pt.under.y + 1 then
		return
	end

	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name]
	or not minetest.registered_nodes[above.name] then
		return
	end

	-- can I replace above node, and am I pointing at soil
	if not minetest.registered_nodes[above.name].buildable_to
	or minetest.get_item_group(under.name, "soil") < 2
	-- avoid multiple seed placement bug
	or minetest.get_item_group(above.name, "plant") ~= 0 then
		return
	end

	-- if not protected then add node and remove 1 item from the itemstack
	if not minetest.is_protected(pt.above, placer:get_player_name()) then

		local p2 = minetest.registered_nodes[plantname].place_param2 or 1

		minetest.set_node(pt.above, {name = plantname, param2 = p2})

		minetest.sound_play("default_place_node", {pos = pt.above, gain = 1.0})

		if not placer or not farming.is_creative(placer:get_player_name()) then

			local name = itemstack:get_name()

			itemstack:take_item()

			-- check for refill
			if itemstack:get_count() == 0 then

				minetest.after(0.10,
					farming.refill_plant,
					placer,
					name,
					placer:get_wield_index()
				)
			end
		end

		return itemstack
	end
end


-- Function to register plants (default farming compatibility)
farming.register_plant = function(name, def)

	if not def.steps then
		return nil
	end

	local mname = name:split(":")[1]
	local pname = name:split(":")[2]

	-- Check def
	def.description = def.description or S("Seed")
	def.inventory_image = def.inventory_image or "unknown_item.png"
	def.minlight = def.minlight or 13
	def.maxlight = def.maxlight or 15

	-- Register seed
	minetest.register_node(":" .. mname .. ":seed_" .. pname, {

		description = def.description,
		tiles = {def.inventory_image},
		inventory_image = def.inventory_image,
		wield_image = def.inventory_image,
		drawtype = "signlike",
		groups = {seed = 1, snappy = 3, attached_node = 1},
		paramtype = "light",
		paramtype2 = "wallmounted",
		walkable = false,
		sunlight_propagates = true,
		selection_box = farming.select,
		place_param2 = def.place_param2 or nil,
		next_plant = mname .. ":" .. pname .. "_1",

		on_place = function(itemstack, placer, pointed_thing)
			return farming.place_seed(itemstack, placer,
				pointed_thing, mname .. ":" .. pname .. "_1")
		end,
	})

	-- Register harvest
	minetest.register_craftitem(":" .. mname .. ":" .. pname, {
		description = pname:gsub("^%l", string.upper),
		inventory_image = mname .. "_" .. pname .. ".png",
	})

	-- Register growing steps
	for i = 1, def.steps do

		local base_rarity = 1
		if def.steps ~= 1 then
			base_rarity =  8 - (i - 1) * 7 / (def.steps - 1)
		end
		local drop = {
			items = {
				{items = {mname .. ":" .. pname}, rarity = base_rarity},
				{items = {mname .. ":" .. pname}, rarity = base_rarity * 2},
				{items = {mname .. ":seed_" .. pname}, rarity = base_rarity},
				{items = {mname .. ":seed_" .. pname}, rarity = base_rarity * 2},
			}
		}

		local g = {
			snappy = 3, flammable = 2, plant = 1, growing = 1,
			attached_node = 1, not_in_creative_inventory = 1,
		}

		-- Last step doesn't need growing=1 so Abm never has to check these
		if i == def.steps then
			g.growing = 0
		end

		local node_name = mname .. ":" .. pname .. "_" .. i

		local next_plant = nil

		if i < def.steps then
			next_plant = mname .. ":" .. pname .. "_" .. (i + 1)
		end

		minetest.register_node(node_name, {
			drawtype = "plantlike",
			waving = 1,
			tiles = {mname .. "_" .. pname .. "_" .. i .. ".png"},
			paramtype = "light",
			paramtype2 = def.paramtype2 or nil,
			place_param2 = def.place_param2 or nil,
			walkable = false,
			buildable_to = true,
			drop = drop,
			selection_box = farming.select,
			groups = g,
			sounds = default.node_sound_leaves_defaults(),
			minlight = def.minlight,
			maxlight = def.maxlight,
			next_plant = next_plant,
		})

		register_plant_node(node_name)
	end

	-- Return info
	return {seed = mname .. ":seed_" .. pname, harvest = mname .. ":" .. pname}
end


-- default settings
farming.carrot = true
farming.potato = true
farming.tomato = true
farming.cucumber = true
farming.corn = true
farming.coffee = true
farming.melon = true
farming.sugar = true
farming.pumpkin = true
farming.cocoa = true
farming.raspberry = true
farming.blueberry = true
farming.rhubarb = true
farming.beans = true
farming.grapes = true
farming.barley = true
farming.chili = true
farming.hemp = true
farming.garlic = true
farming.onion = true
farming.pepper = true
farming.pineapple = true
farming.donuts = true
farming.rarety = 0.001 -- 0.006


-- Load new global settings if found inside mod folder
local input = io.open(farming.path.."/farming.conf", "r")
if input then
	dofile(farming.path .. "/farming.conf")
	input:close()
	input = nil
end

-- load new world-specific settings if found inside world folder
local worldpath = minetest.get_worldpath()
local input = io.open(worldpath.."/farming.conf", "r")
if input then
	dofile(worldpath .. "/farming.conf")
	input:close()
	input = nil
end


-- important items
dofile(farming.path.."/soil.lua")
dofile(farming.path.."/hoes.lua")
dofile(farming.path.."/grass.lua")

-- default crops
dofile(farming.path.."/wheat.lua")
dofile(farming.path.."/cotton.lua")

-- additional crops and food (if enabled)
if farming.carrot then dofile(farming.path.."/carrot.lua") end
if farming.potato then dofile(farming.path.."/potato.lua") end
if farming.tomato then dofile(farming.path.."/tomato.lua") end
if farming.cucumber then dofile(farming.path.."/cucumber.lua") end
if farming.corn then dofile(farming.path.."/corn.lua") end
if farming.coffee then dofile(farming.path.."/coffee.lua") end
if farming.melon then dofile(farming.path.."/melon.lua") end
if farming.sugar then dofile(farming.path.."/sugar.lua") end
if farming.pumpkin then dofile(farming.path.."/pumpkin.lua") end
if farming.cocoa then dofile(farming.path.."/cocoa.lua") end
if farming.raspberry then dofile(farming.path.."/raspberry.lua") end
if farming.blueberry then dofile(farming.path.."/blueberry.lua") end
if farming.rhubarb then dofile(farming.path.."/rhubarb.lua") end
if farming.beans then dofile(farming.path.."/beanpole.lua") end
if farming.grapes then dofile(farming.path.."/grapes.lua") end
if farming.barley then dofile(farming.path.."/barley.lua") end
if farming.chili then dofile(farming.path.."/chili.lua") end
if farming.hemp then dofile(farming.path.."/hemp.lua") end
if farming.donuts then dofile(farming.path.."/donut.lua") end
if farming.garlic then dofile(farming.path.."/garlic.lua") end
if farming.onion then dofile(farming.path.."/onion.lua") end
if farming.pepper then dofile(farming.path.."/pepper.lua") end
if farming.pineapple then dofile(farming.path.."/pineapple.lua") end

dofile(farming.path.."/mapgen.lua")
dofile(farming.path.."/compatibility.lua") -- Farming Plus compatibility
dofile(farming.path.."/lucky_block.lua")
