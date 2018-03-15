
local S = farming.intllib

-- rhubarb
minetest.register_craftitem("farming:rhubarb", {
	description = S("Rhubarb"),
	inventory_image = "farming_rhubarb.png",
	groups = {food_rhubarb = 1, flammable = 2},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:rhubarb_1")
	end,
	on_use = minetest.item_eat(1),
})

-- rhubarb pie
minetest.register_craftitem("farming:rhubarb_pie", {
	description = S("Rhubarb Pie"),
	inventory_image = "farming_rhubarb_pie.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craft({
	output = "farming:rhubarb_pie",
	recipe = {
		{"", "group:food_sugar", ""},
		{"group:food_rhubarb", "group:food_rhubarb", "group:food_rhubarb"},
		{"group:food_wheat", "group:food_wheat", "group:food_wheat"},
	}
})

-- rhubarb definition
local crop_def = {
	drawtype = "plantlike",
	tiles = {"farming_rhubarb_1.png"},
	paramtype = "light",
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
minetest.register_node("farming:rhubarb_1", table.copy(crop_def))

-- stage2
crop_def.tiles = {"farming_rhubarb_2.png"}
minetest.register_node("farming:rhubarb_2", table.copy(crop_def))

-- stage 3 (final)
crop_def.tiles = {"farming_rhubarb_3.png"}
crop_def.groups.growing = 0
crop_def.drop = {
	items = {
	{items = {'farming:rhubarb 2'}, rarity = 1},
		{items = {'farming:rhubarb'}, rarity = 2},
		{items = {'farming:rhubarb'}, rarity = 3},
	}
}
minetest.register_node("farming:rhubarb_3", table.copy(crop_def))
