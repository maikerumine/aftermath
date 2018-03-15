
local S = farming.intllib

-- coffee
minetest.register_craftitem("farming:coffee_beans", {
	description = S("Coffee Beans"),
	inventory_image = "farming_coffee_beans.png",
	groups = {food_coffee = 1, flammable = 2},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:coffee_1")
	end,
})


-- drinking cup
minetest.register_node("farming:drinking_cup", {
	description = S("Drinking Cup (empty)"),
	drawtype = "plantlike",
	tiles = {"vessels_drinking_cup.png"},
	inventory_image = "vessels_drinking_cup.png",
	wield_image = "vessels_drinking_cup.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft( {
	output = "farming:drinking_cup 5",
	recipe = {
		{ "default:glass", "", "default:glass" },
		{"", "default:glass",""},
	}
})

-- cold cup of coffee
minetest.register_node("farming:coffee_cup", {
	description = S("Cold Cup of Coffee"),
	drawtype = "plantlike",
	tiles = {"farming_coffee_cup.png"},
	inventory_image = "farming_coffee_cup.png",
	wield_image = "farming_coffee_cup.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	on_use = minetest.item_eat(2, "farming:drinking_cup"),
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft( {
	output = "farming:coffee_cup",
	recipe = {
		{"farming:drinking_cup", "group:food_coffee","bucket:bucket_water"},
	},
	replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 5,
	output = "farming:coffee_cup_hot",
	recipe = "farming:coffee_cup"
})

-- hot cup of coffee
minetest.register_node("farming:coffee_cup_hot", {
	description = S("Hot Cup of Coffee"),
	drawtype = "plantlike",
	tiles = {"farming_coffee_cup_hot.png"},
	inventory_image = "farming_coffee_cup_hot.png",
	wield_image = "farming_coffee_cup_hot.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	on_use = minetest.item_eat(3, "farming:drinking_cup"),
	sounds = default.node_sound_glass_defaults(),
})

-- coffee definition
local crop_def = {
	drawtype = "plantlike",
	tiles = {"farming_coffee_1.png"},
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
minetest.register_node("farming:coffee_1", table.copy(crop_def))

-- stage 2
crop_def.tiles = {"farming_coffee_2.png"}
minetest.register_node("farming:coffee_2", table.copy(crop_def))

-- stage 3
crop_def.tiles = {"farming_coffee_3.png"}
minetest.register_node("farming:coffee_3", table.copy(crop_def))

-- stage 4
crop_def.tiles = {"farming_coffee_4.png"}
minetest.register_node("farming:coffee_4", table.copy(crop_def))

-- stage 5 (final)
crop_def.tiles = {"farming_coffee_5.png"}
crop_def.groups.growing = 0
crop_def.drop = {
	items = {
		{items = {'farming:coffee_beans 2'}, rarity = 1},
		{items = {'farming:coffee_beans 2'}, rarity = 2},
		{items = {'farming:coffee_beans 2'}, rarity = 3},
	}
}
minetest.register_node("farming:coffee_5", table.copy(crop_def))
