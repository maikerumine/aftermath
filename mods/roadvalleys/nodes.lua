minetest.register_node("roadvalleys:road_black", {
	description = "Road Black",
	tiles = {"roadvalleys_road_black.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("roadvalleys:road_black_slab", {
	description = "Road Black Slab",
	tiles = {"roadvalleys_road_black.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	node_box = {
		type = "fixed",
		fixed = {{-0.5, -0.5, -0.5, 0.5, 0, 0.5}},
	},
	selection_box = {
		type = "fixed",
		fixed = {{-0.5, -0.5, -0.5, 0.5, 0, 0.5}},
	},
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("roadvalleys:road_white", {
	description = "Road White",
	tiles = {"roadvalleys_road_white.png"},
	paramtype = "light",
	--light_source = 12,
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("roadvalleys:concrete", {
	description = "Concrete",
	tiles = {"roadvalleys_concrete.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})
