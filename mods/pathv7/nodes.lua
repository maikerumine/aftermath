minetest.register_node("pathv7:junglewood", {
	description = "Mod jungle wood",
	tiles = {"asphalt.png", "asphalt_bottom.png", "asphalt.png", "asphalt.png", "asphalt_back.png", "asphalt_front.png"},
	is_ground_content = false,
	groups = {choppy = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv7:bridgewood", {
	description = "Bridge wood",
	tiles = {"default_stone.png"},
	is_ground_content = false,
	groups = {cracky = 3, flammable = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("pathv7:stairn", { -- stair rising to the north
	description = "Jungle wood stair N",
	tiles = {"asphalt.png", "asphalt_bottom.png", "asphalt.png", "asphalt.png", "asphalt_back.png", "asphalt_front.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 2,  flammable = 2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv7:stairs", {
	description = "Jungle wood stair S",
	tiles = {"asphalt.png", "asphalt_bottom.png", "asphalt.png", "asphalt.png", "asphalt_back.png", "asphalt_front.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 2, flammable = 2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, -0.5, 0.5, 0.5, 0},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv7:staire", {
	description = "Jungle wood stair E",
	tiles = {"asphalt.png", "asphalt_bottom.png", "asphalt.png", "asphalt.png", "asphalt_back.png", "asphalt_front.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 2, flammable = 2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{0, 0, -0.5, 0.5, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv7:stairw", {
	description = "Jungle wood stair W",
	tiles = {"asphalt.png", "asphalt_bottom.png", "asphalt.png", "asphalt.png", "asphalt_back.png", "asphalt_front.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 2, flammable = 2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, -0.5, 0, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv7:stairne", {
	description = "Jungle wood stair NE",
	tiles = {"asphalt.png", "asphalt_bottom.png", "asphalt.png", "asphalt.png", "asphalt_back.png", "asphalt_front.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 2, flammable = 2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{0, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv7:stairnw", {
	description = "Jungle wood stair NW",
	tiles = {"asphalt.png", "asphalt_bottom.png", "asphalt.png", "asphalt.png", "asphalt_back.png", "asphalt_front.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 2, flammable = 2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, 0, 0, 0.5, 0.5},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv7:stairse", {
	description = "Jungle wood stair SE",
	tiles = {"asphalt.png", "asphalt_bottom.png", "asphalt.png", "asphalt.png", "asphalt_back.png", "asphalt_front.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 2, flammable = 2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{0, 0, -0.5, 0.5, 0.5, 0},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("pathv7:stairsw", {
	description = "Jungle wood stair SW",
	tiles = {"asphalt.png", "asphalt_bottom.png", "asphalt.png", "asphalt.png", "asphalt_back.png", "asphalt_front.png"},
	drawtype = "nodebox",
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 2, flammable = 2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, -0.5, 0, 0.5, 0},
		},
	},
	sounds = default.node_sound_wood_defaults(),
})
