
local S = farming.intllib

-- barley seeds
minetest.register_node("farming:seed_barley", {
	description = S("Barley Seed"),
	tiles = {"farming_barley_seed.png"},
	inventory_image = "farming_barley_seed.png",
	wield_image = "farming_barley_seed.png",
	drawtype = "signlike",
	groups = {seed = 1, snappy = 3, attached_node = 1},
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = farming.select,
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:barley_1")
	end,
})

-- harvested barley
minetest.register_craftitem("farming:barley", {
	description = S("Barley"),
	inventory_image = "farming_barley.png",
	groups = {food_barley = 1, flammable = 2},
})

-- flour
minetest.register_craft({
	type = "shapeless",
	output = "farming:flour",
	recipe = {"farming:barley", "farming:barley", "farming:barley", "farming:barley"}
})

-- barley definition
local crop_def = {
	drawtype = "plantlike",
	tiles = {"farming_barley_1.png"},
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 3,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("farming:barley_1", table.copy(crop_def))

-- stage 2
crop_def.tiles = {"farming_barley_2.png"}
minetest.register_node("farming:barley_2", table.copy(crop_def))

-- stage 3
crop_def.tiles = {"farming_barley_3.png"}
minetest.register_node("farming:barley_3", table.copy(crop_def))

-- stage 4
crop_def.tiles = {"farming_barley_4.png"}
minetest.register_node("farming:barley_4", table.copy(crop_def))

-- stage 5
crop_def.tiles = {"farming_barley_5.png"}
crop_def.drop = {
	items = {
		{items = {'farming:barley'}, rarity = 2},
		{items = {'farming:seed_barley'}, rarity = 2},
	}
}
minetest.register_node("farming:barley_5", table.copy(crop_def))

-- stage 6
crop_def.tiles = {"farming_barley_6.png"}
crop_def.drop = {
	items = {
		{items = {'farming:barley'}, rarity = 2},
		{items = {'farming:seed_barley'}, rarity = 1},
	}
}
minetest.register_node("farming:barley_6", table.copy(crop_def))

-- stage 7 (final)
crop_def.tiles = {"farming_barley_7.png"}
crop_def.groups.growing = 0
crop_def.drop = {
	items = {
		{items = {'farming:barley'}, rarity = 1},
		{items = {'farming:barley'}, rarity = 3},
		{items = {'farming:seed_barley'}, rarity = 1},
		{items = {'farming:seed_barley'}, rarity = 3},
	}
}
minetest.register_node("farming:barley_7", table.copy(crop_def))
