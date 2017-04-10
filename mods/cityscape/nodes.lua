minetest.register_alias("cityscape:manhole_cover", "doors:trapdoor_steel")
minetest.register_alias("cityscape:sewer_water", "default:water_source")

minetest.register_node("cityscape:plate_glass", {
	description = "Plate Glass",
	drawtype = "glasslike",
	paramtype = "light",
	sunlight_propagates = true,
	tiles = {"cityscape_plate_glass.png"},
	light_source = 1,
	use_texture_alpha = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})
newnode = cityscape.clone_node("cityscape:plate_glass")
newnode.tiles = {"cityscape_plate_glass_broken.png"}
newnode.walkable = false
minetest.register_node("cityscape:plate_glass_broken", newnode)
minetest.register_alias("cityscape:glass_broken", "cityscape:plate_glass_broken")

minetest.register_node("cityscape:road", {
	description = "Road",
	tiles = {"cityscape_tarmac.png"},
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 2, level = 1},
})
newnode = cityscape.clone_node("cityscape:road")
newnode.tiles = {"cityscape_tarmac.png^[brighten"}
minetest.register_node("cityscape:road_white", newnode)

minetest.register_node("cityscape:road_broken", {
	description = "Road",
	tiles = {"cityscape_tarmac.png^cityscape_broken_3.png"},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = { type = "fixed",
		fixed = {
			{0.5, 0.3, 0.5, -0.5, -0.5, -0.5}
		}
	},
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 2, level = 1},
})

minetest.register_node("cityscape:road_yellow_line", {
	description = "Road",
	tiles = {"cityscape_tarmac_yellow_line.png"},
	paramtype2 = "facedir",
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 2, level = 1},
})

minetest.register_node("cityscape:plaster", {
	description = "Plaster",
	tiles = {"default_desert_stone.png^[colorize:#8C8175:225"},
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 3, level = 0, flammable = 2, oddly_breakable_by_hand = 1},
})
newnode = cityscape.clone_node("cityscape:plaster")
newnode.tiles = {"(default_desert_stone.png^[colorize:#8C8175:225)^cityscape_broken_3_low.png"}
minetest.register_node("cityscape:plaster_broken", newnode)

stairs.register_stair_and_slab("road", "cityscape:road",
	{cracky = 2, level = 1},
	{"cityscape_tarmac.png"},
	"Ramp",
	"Tarmac",
	default.node_sound_stone_defaults())

newnode = cityscape.clone_node("stairs:stair_stone")
newnode.description = "Concrete Stair"
newnode.groups.flammable = 3
newnode.drop = "stairs:stair_stone"
minetest.register_node("cityscape:concrete_stair", newnode)

minetest.register_node("cityscape:concrete", {
	description = "Concrete",
	tiles = {"default_stone.png"},
	groups = {cracky = 3, level=1, stone = 1},
	drop = "default:cobble",
	sounds = default.node_sound_stone_defaults(),
	is_ground_content = false,
})
newnode = cityscape.clone_node("cityscape:concrete")
newnode.tiles = {"default_stone.png^cityscape_broken_3_low.png"}
minetest.register_node("cityscape:concrete_broken", newnode)

local newnode = cityscape.clone_node("cityscape:concrete")
newnode.tiles = {"default_stone.png^[colorize:#964B00:40"}
minetest.register_node("cityscape:concrete2", newnode)
newnode.tiles = {"default_stone.png^[colorize:#FF0000:20"}
minetest.register_node("cityscape:concrete3", newnode)
newnode.tiles = {"default_stone.png^[colorize:#4682B4:10"}
minetest.register_node("cityscape:concrete4", newnode)
newnode.tiles = {"default_stone.png^[colorize:#000000:40"}
minetest.register_node("cityscape:concrete5", newnode)

local newnode = cityscape.clone_node("cityscape:concrete_broken")
newnode.tiles = {"default_stone.png^[colorize:#964B00:40^cityscape_broken_3_low.png"}
minetest.register_node("cityscape:concrete2_broken", newnode)
newnode.tiles = {"default_stone.png^[colorize:#FF0000:20^cityscape_broken_3_low.png"}
minetest.register_node("cityscape:concrete3_broken", newnode)
newnode.tiles = {"default_stone.png^[colorize:#4682B4:10^cityscape_broken_3_low.png"}
minetest.register_node("cityscape:concrete4_broken", newnode)
newnode.tiles = {"default_stone.png^[colorize:#000000:40^cityscape_broken_3_low.png"}
minetest.register_node("cityscape:concrete5_broken", newnode)

minetest.register_node("cityscape:floor_ceiling", {
	description = "Floor/Ceiling",
	tiles = {"cityscape_floor.png", "cityscape_ceiling.png", "default_stone.png"},
	paramtype2 = "facedir",
	groups = {cracky = 3, level=1, flammable = 3},
	drop = "default:cobble",
	drop = {
		max_items = 3,
		items = {
			{
				items = {"default:cobble",},
				rarity = 1,
			},
			{
				items = {"default:copper_ingot",},
				rarity = 6,
			},
		},
	},
	sounds = default.node_sound_stone_defaults(),
	is_ground_content = false,
})
newnode = cityscape.clone_node("cityscape:floor_ceiling")
newnode.tiles = {"cityscape_floor.png^cityscape_broken_3.png", "cityscape_ceiling.png^cityscape_broken_3.png", "default_stone.png^cityscape_broken_3.png"}
minetest.register_node("cityscape:floor_ceiling_broken", newnode)

minetest.register_node("cityscape:sidewalk", {
	description = "Sidewalk",
	tiles = {"cityscape_sidewalk.png"},
	groups = {cracky = 3, level=1, stone = 1},
	drop = "default:cobble",
	sounds = default.node_sound_stone_defaults(),
	is_ground_content = false,
})
newnode = cityscape.clone_node("cityscape:sidewalk")
newnode.tiles = {"cityscape_sidewalk.png^cityscape_broken_3.png"}
minetest.register_node("cityscape:sidewalk_broken", newnode)

minetest.register_node("cityscape:roof", {
	description = "Roof",
	tiles = {"cityscape_tarmac.png", "cityscape_ceiling.png", "default_stone.png"},
	paramtype2 = "facedir",
	groups = {cracky = 3, level=1, flammable = 3},
	drop = "default:cobble",
	sounds = default.node_sound_stone_defaults(),
	is_ground_content = false,
})
minetest.register_node("cityscape:roof_broken", {
	description = "Roof",
	tiles = {"cityscape_tarmac.png^cityscape_broken_3.png", "cityscape_ceiling.png^cityscape_broken_3.png", "default_stone.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	drop = "default:cobble",
	node_box = { type = "fixed",
		fixed = {
			{0.5, 0.3, 0.5, -0.5, -0.5, -0.5}
		}
	},
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 3, level=1, flammable = 3},
	is_ground_content = false,
})


if default.register_fence then
	default.register_fence("cityscape:fence_steel", {
		description = "Safety Rail",
		texture = "cityscape_safety_rail.png",
		material = "default:steel_ingot",
		groups = {cracky = 1, level = 2},
		sounds = default.node_sound_metal_defaults(),
	})
else
	minetest.register_node("cityscape:fence_steel", {
		description = "Safety Rail",
		tiles = {"cityscape_safety_rail.png"},
		paramtype = "light",
		drawtype = "nodebox",
		node_box = { type = "fixed",
		fixed = {
			{0.1, 0.5, 0.1, -0.1, -0.5, -0.1},
		}, },
		groups = {cracky = 1, level = 2},
		sounds = default.node_sound_metal_defaults(),
	})
end

minetest.register_node("cityscape:gargoyle", {
	description = "Concrete",
	tiles = {"default_stone.png^[colorize:#000000:60"},
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = { type = "fixed",
		fixed = {
			{0.2, 0.23, -0.17, -0.1, -0.5, 0.17},   -- body f
			{-0.1, -0.07, -0.17, -0.27, -0.5, 0.17},   -- body r
			{0.17, 0.5, -0.07, 0, 0.23, 0.07}, -- head
			{0.27, 0.2, 0.1, 0.13, -0.5, 0.23}, -- leg fl
			{0.27, 0.2, -0.23, 0.13, -0.5, -0.1}, -- leg fr
			{0.03, -0.1, 0.17, -0.2, -0.5, 0.27}, -- leg rl
			{0.03, -0.1, -0.27, -0.2, -0.5, -0.17}, -- leg rl
			{-0.1, 0.23, -0.4, -0.17, 0.13, 0.4}, -- wing u
			{-0.1, 0.13, -0.3, -0.17, 0.03, 0.3}, -- wing u
		} },
	groups = {cracky = 3, level=1, stone = 1},
	drop = "default:cobble",
	on_place = minetest.rotate_and_place,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cityscape:streetlight", {
	description = "Streetlight",
	tiles = {"cityscape_streetlight.png"},
	paramtype = "light",
	light_source = 14,
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = { type = "fixed",
		fixed = {
			{0.1, 2.5, -0.1, -0.1, -0.5, 0.1},
			{0.05, 2.5, -0.5, -0.05, 2.4, -0.1},
			{0.1, 2.5, -0.7, -0.1, 2.35, -0.5},
		} },
	groups = {cracky = 2, level=2},
	on_place = minetest.rotate_and_place,
	sounds = default.node_sound_metal_defaults(),
})
newnode = cityscape.clone_node("cityscape:streetlight")
newnode.light_source = 0
minetest.register_node("cityscape:streetlight_broken", newnode)

minetest.register_node("cityscape:light_panel", {
	description = "Light Panel",
	tiles = {"default_sandstone.png"},
	light_source = 14,
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = { type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.48, 0.5},
		} },
	groups = {cracky = 3, level=1, oddly_breakable_by_hand = 1, flammable = 3},
	on_place = minetest.rotate_and_place,
	sounds = default.node_sound_stone_defaults(),
})
newnode = cityscape.clone_node("cityscape:light_panel")
newnode.light_source = 0
minetest.register_node("cityscape:light_panel_broken", newnode)

newnode = cityscape.clone_node("default:brick")
newnode.tiles = {"default_brick.png^cityscape_broken_3_low.png"}
minetest.register_node("cityscape:brick_broken", newnode)

newnode = cityscape.clone_node("default:sandstonebrick")
newnode.tiles = {"default_sandstone_brick.png^cityscape_broken_3_low.png"}
minetest.register_node("cityscape:sandstonebrick_broken", newnode)

newnode = cityscape.clone_node("default:stonebrick")
newnode.tiles = {"default_stone_brick.png^cityscape_broken_3_low.png"}
minetest.register_node("cityscape:stonebrick_broken", newnode)

newnode = cityscape.clone_node("default:desert_stonebrick")
newnode.tiles = {"default_desert_stone_brick.png^cityscape_broken_3_low.png"}
minetest.register_node("cityscape:desert_stonebrick_broken", newnode)

cityscape.current_cars = {}
local function start_non_laggy_car(player, node)
	if not player or not node then
		return
	end

	local name = player:get_player_name()
	if not cityscape.current_cars[name] then
		local tex = "cityscape_car_blue.png"
		if node.name == "cityscape:car_broken" then
			tex = "cityscape_car_wreck.png"
		end
		cityscape.current_cars[name] = {}
		cityscape.current_cars[name].properties = player:get_properties()
		cityscape.current_cars[name].physics_override = player:get_physics_override()
		player:set_properties({visual="mesh",visual_size = {x=1, y=1}, mesh = "cars_car.obj", textures = {tex}, makes_footstep_sound = false})
		player:set_physics_override({speed=(minetest.setting_getbool("disable_anticheat") == true and 3 or 1), jump=0, gravity=2})
	end
end

local function stop_non_laggy_car(player)
	if not player then
		return
	end

	local name = player:get_player_name()
	if cityscape.current_cars[name] then
		player:set_properties(cityscape.current_cars[name].properties)
		player:set_physics_override(cityscape.current_cars[name].physics_override)
		cityscape.current_cars[name] = nil
	end
end

local function click_non_laggy_car(pos, node, clicker, itemstack, pointed_thing)
	if not pos or not node or not clicker then
		return
	end

	--minetest.remove_node(pos)
	--itemstack:add_item(node.name)
	--start_non_laggy_car(clicker, node)
end

local function drop_non_laggy_car(itemstack, dropper, pos)
	if not dropper then
		return
	end

	stop_non_laggy_car(dropper)
	return minetest.rotate_and_place(itemstack, dropper, pos)
end

minetest.register_node("cityscape:car", {
	description = "Car",
	drawtype = 'mesh',
	tiles = {"cityscape_car_blue.png"},
	use_texture_alpha = true,
	mesh = "cityscape_car.obj",
	selection_box = { type = "fixed",
		fixed = {
			{-0.9, -0.5, -1.5, 0.9, 0.2, 1.5},
		} },
	paramtype = "light",
	paramtype2 = "facedir",
	drop = {
		max_items = 3,
		items = {
		{
			items = {"default:car_parts 3",},
			rarity = 1,
		},
		{
			items = {"cityscape:gasoline 2",},
			rarity = 3,
		},
		{
			items = {"default:copper_ingot",},
			rarity = 6,
		},
	},
},
	on_rightclick = click_non_laggy_car,
	groups = {cracky = 1, level = 2, flammable = 3},
	on_place = drop_non_laggy_car,
	sounds = default.node_sound_metal_defaults(),
})
newnode = cityscape.clone_node("cityscape:car")
newnode.tiles = {"cityscape_car_wreck.png"}
minetest.register_node("cityscape:car_broken", newnode)

minetest.register_node("cityscape:canned_food", {
	description = "Canned Food",
	drawtype = "plantlike",
	paramtype = "light",
	visual_scale = 0.6,
	selection_box = { type = "fixed",
		fixed = {
			{0.1, -0.1, 0.1, -0.1, -0.5, -0.1}
		}
	},
	tiles = {"cityscape_canned_food.png"},
	inventory_image = "cityscape_canned_food.png",
	on_use = minetest.item_eat(3),
	groups = {dig_immediate = 3, attached_node = 1},
})

minetest.register_node("cityscape:gasoline", {
	description = "Gasoline",
	drawtype = "plantlike",
	paramtype = "light",
	visual_scale = 0.8,
	selection_box = { type = "fixed",
		fixed = {
			{0.2, 0.1, 0.2, -0.2, -0.5, -0.2}
		}
	},
	tiles = {"cityscape_gasoline.png"},
	inventory_image = "cityscape_gasoline.png",
	groups = {dig_immediate = 3, attached_node = 1, flammable = 1},
})


local goodies = {
	{ items = {"default:pine_wood 2",}, rarity = 1, },
	{ items = {"cityscape:canned_food 12",}, rarity = 10, },
	{ items = {"default:steel_ingot 3",}, rarity = 10, },
	{ items = {"default:copper_ingot 3",}, rarity = 10, },
	{ items = {"default:book 10",}, rarity = 10, },
	{ items = {"default:paper 30",}, rarity = 10, },
	{ items = {"default:soda",}, rarity = 10, },
}

if minetest.get_modpath("vessels") then
	goodies[#goodies+1] = { items = {"vessels:shelf",}, rarity = 10, }
	goodies[#goodies+1] = { items = {"vessels:glass_bottle 10",}, rarity = 10, }
	goodies[#goodies+1] = { items = {"vessels:drinking_glass 10",}, rarity = 10, }
	goodies[#goodies+1] = { items = {"vessels:steel_bottle 10",}, rarity = 10, }
	goodies[#goodies+1] = { items = {"vessels:glass_fragments 20",}, rarity = 10, }
end

if minetest.get_modpath("bucket") then
	goodies[#goodies+1] = { items = {"bucket:bucket_empty 10",}, rarity = 10, }
end

if minetest.get_modpath("wool") then
	goodies[#goodies+1] = { items = {"wool:blue 10",}, rarity = 10, }
	goodies[#goodies+1] = { items = {"wool:red 10",}, rarity = 10, }
	goodies[#goodies+1] = { items = {"wool:green 10",}, rarity = 10, }
	goodies[#goodies+1] = { items = {"wool:yellow 10",}, rarity = 10, }
	goodies[#goodies+1] = { items = {"wool:cyan 10",}, rarity = 10, }
	goodies[#goodies+1] = { items = {"wool:magenta 10",}, rarity = 10, }
	goodies[#goodies+1] = { items = {"wool:orange 10",}, rarity = 10, }
	goodies[#goodies+1] = { items = {"wool:violet 10",}, rarity = 10, }
	goodies[#goodies+1] = { items = {"wool:pink 10",}, rarity = 10, }
end

if minetest.get_modpath("gemalde") then
	goodies[#goodies+1] = { items = {"gemalde:node_1",}, rarity = 10, }
end

if minetest.get_modpath("beds") then
	goodies[#goodies+1] = { items = {"beds:fancy_bed",}, rarity = 10, }
	goodies[#goodies+1] = { items = {"beds:bed",}, rarity = 10, }
end

if minetest.get_modpath("body_pillow") then
	goodies[#goodies+1] = { items = {"body_pillow:body_pillow",}, rarity = 10, }
end

local function crate(pos, oldnode, oldmetadata, digger)
end

minetest.register_node("cityscape:crate", {
	description = "Crate",
	tiles = {"cityscape_crate.png"},
	sounds = default.node_sound_wood_defaults(),
	groups = {choppy = 1, level = 1, flammable = 2},
	--drop = {
	--	max_items = 0,
	--	items = {}
	--},
	drop = {
		max_items = 2,
		items = goodies
	},
	--after_dig_node = crate,
})

minetest.register_node("cityscape:swing_set", {
	description = "Swing Set",
	tiles = {"cityscape_swing_set.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = { type = "fixed",
		fixed = {
			{1.5, 1.5, 0.5, 1.4, -0.5, 0.4},  -- pole 1
			{-1.4, 1.5, 0.5, -1.5, -0.5, 0.4},  -- pole 2
			{-1.4, 1.5, -0.4, -1.5, -0.5, -0.5},  -- pole 3
			{1.5, 1.5, -0.4, 1.4, -0.5, -0.5},  -- pole 4
			{1.5, 1.5, 0.5, 1.4, 1.4, -0.5},  -- cross 1
			{-1.4, 1.5, 0.5, -1.5, 1.4, -0.5},  -- cross 2
			{1.5, 1.5, 0.05, -1.5, 1.4, -0.05},  -- main
			{0.71, 1.5, 0.01, 0.69, 0, -0.01},  -- line 1
			{0.31, 1.5, 0.01, 0.29, 0, -0.01},  -- line 2
			{-0.71, 1.5, 0.01, -0.69, 0, -0.01},  -- line 3
			{-0.31, 1.5, 0.01, -0.29, 0, -0.01},  -- line 4
			{0.7, 0.02, 0.1, 0.3, -0.02, -0.1},  -- seat 1
			{-0.7, 0.02, 0.1, -0.3, -0.02, -0.1},  -- seat 2
		} },
	groups = {cracky = 2, level=2},
	on_place = minetest.rotate_and_place,
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("cityscape:park_bench", {
	description = "Park Bench",
	tiles = {"default_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = { type = "fixed",
		fixed = {
			{1.0, 0.01, -0.25, -1.0, -0.01, 0.25},  -- seat
			{1.0, 0.5, 0.23, -1.0, 0, 0.25},  -- back
			{0.95, 0, -0.05, 0.85, -0.5, 0.05},  -- leg 1
			{-0.95, 0, -0.05, -0.85, -0.5, 0.05},  -- leg 2
		} },
	groups = {choppy = 3, level=0},
	on_place = minetest.rotate_and_place,
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("cityscape:doll", {
	description = "Child's Doll",
	tiles = {"wool_pink.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = { type = "fixed",
		fixed = {
			{0.2, -0.41, 0.04, 0.1, -0.49, -0.04},  -- head
			{0.1, -0.4, 0.075, 0, -0.5, -0.075},  -- body
			{0.07, -0.43, 0.15, 0.03, -0.47, 0.075},  -- arm
			{0.07, -0.43, -0.15, 0.03, -0.47, -0.075},  -- arm
			{0, -0.4, 0.1, -0.1, -0.5, -0.1},  -- skirt
			{-0.1, -0.43, 0.06, -0.2, -0.47, 0.02},  -- leg
			{-0.1, -0.43, -0.06, -0.2, -0.47, -0.02},  -- leg
		} },
	groups = {dig_immediate = 3, attached_node = 1, flammable = 1},
	on_place = minetest.rotate_and_place,
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("cityscape:carpet", {
	description = "Carpet",
	tiles = {"wool_blue.png", "default_stone.png", "default_stone.png"},
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 2, level = 1},
})
minetest.register_alias("cityscape:carpet_broken", "default:stone")

minetest.register_node("cityscape:wood_broken", {
	description = "Rotten Wood",
	tiles = {"default_wood.png^cityscape_wood_rot.png"},
	sounds = default.node_sound_wood_defaults(),
	groups = {choppy = 3, level = 0, oddly_breakable_by_hand = 3},
})
