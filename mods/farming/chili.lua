
local S = farming.intllib

-- chili pepper
minetest.register_craftitem("farming:chili_pepper", {
	description = S("Chili Pepper"),
	inventory_image = "farming_chili_pepper.png",
	groups = {food_chili_pepper = 1, flammable = 4},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:chili_1")
	end,
	on_use = minetest.item_eat(2),
})

-- bowl of chili
minetest.register_craftitem("farming:chili_bowl", {
	description = S("Bowl of Chili"),
	inventory_image = "farming_chili_bowl.png",
	on_use = minetest.item_eat(8),
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:chili_bowl",
	recipe = {
		"group:food_chili_pepper", "group:food_barley",
		"group:food_tomato", "group:food_beans"
	}
})

-- chili can be used for red dye
minetest.register_craft({
	output = "dye:red",
	recipe = {
		{'farming:chili_pepper'},
	}
})

-- chili definition
local crop_def = {
	drawtype = "plantlike",
	tiles = {"farming_chili_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 4, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("farming:chili_1", table.copy(crop_def))

-- stage 2
crop_def.tiles = {"farming_chili_2.png"}
minetest.register_node("farming:chili_2", table.copy(crop_def))

-- stage 3
crop_def.tiles = {"farming_chili_3.png"}
minetest.register_node("farming:chili_3", table.copy(crop_def))

-- stage 4
crop_def.tiles = {"farming_chili_4.png"}
minetest.register_node("farming:chili_4", table.copy(crop_def))

-- stage 5
crop_def.tiles = {"farming_chili_5.png"}
minetest.register_node("farming:chili_5", table.copy(crop_def))

-- stage 6
crop_def.tiles = {"farming_chili_6.png"}
minetest.register_node("farming:chili_6", table.copy(crop_def))

-- stage 7
crop_def.tiles = {"farming_chili_7.png"}
minetest.register_node("farming:chili_7", table.copy(crop_def))

-- stage 8 (final)
crop_def.tiles = {"farming_chili_8.png"}
crop_def.groups.growing = 0
crop_def.drop = {
	items = {
		{items = {'farming:chili_pepper 3'}, rarity = 1},
		{items = {'farming:chili_pepper 2'}, rarity = 2},
	}
}
minetest.register_node("farming:chili_8", table.copy(crop_def))
