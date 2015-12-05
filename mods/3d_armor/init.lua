ARMOR_MOD_NAME = minetest.get_current_modname()
dofile(minetest.get_modpath(ARMOR_MOD_NAME).."/armor.lua")
local use_moreores = minetest.get_modpath("moreores")

-- Register helmets:

minetest.register_tool("3d_armor:helmet_wood", {
	description = "Wooden Helmet",
	inventory_image = "3d_armor_inv_helmet_wood.png",
	groups = {armor_head = 5, armor_heal = 0, armor_use = 2000},
	wear = 0,
})

minetest.register_tool("3d_armor:helmet_steel", {
	description = "Steel Helmet",
	inventory_image = "3d_armor_inv_helmet_steel.png",
	groups = {armor_head = 10, armor_heal = 0, armor_use = 500},
	wear = 0,
})

minetest.register_tool("3d_armor:helmet_bronze", {
	description = "Bronze Helmet",
	inventory_image = "3d_armor_inv_helmet_bronze.png",
	groups = {armor_head = 10, armor_heal = 6, armor_use = 250},
	wear = 0,
})
--[[
minetest.register_tool("3d_armor:helmet_diamond", {
	description = "Diamond Helmet",
	inventory_image = "3d_armor_inv_helmet_diamond.png",
	groups = {armor_head = 15, armor_heal = 12, armor_use = 100},
	wear = 0,
})]]

minetest.register_tool("3d_armor:helmet_gold", {
	description = "Golden Helmet",
	inventory_image = "3d_armor_inv_helmet_gold.png",
	groups = {armor_head = 10, armor_heal = 6, armor_use = 250},
	wear = 0,
})

if use_moreores then
	minetest.register_tool("3d_armor:helmet_mithril", {
		description = "Mithril Helmet",
		inventory_image = "3d_armor_inv_helmet_mithril.png",
		groups = {armor_head = 15, armor_heal = 12, armor_use = 50},
		wear = 0,
	})
end

-- Register chestplates:

minetest.register_tool("3d_armor:chestplate_wood", {
	description = "Wooden Chestplate",
	inventory_image = "3d_armor_inv_chestplate_wood.png",
	groups = {armor_torso = 10, armor_heal = 0, armor_use = 2000},
	wear = 0,
})

minetest.register_tool("3d_armor:chestplate_steel", {
	description = "Steel Chestplate",
	inventory_image = "3d_armor_inv_chestplate_steel.png",
	groups = {armor_torso = 15, armor_heal = 0, armor_use = 500},
	wear = 0,
})

minetest.register_tool("3d_armor:chestplate_bronze", {
	description = "Bronze Chestplate",
	inventory_image = "3d_armor_inv_chestplate_bronze.png",
	groups = {armor_torso = 15, armor_heal = 6, armor_use = 250},
	wear = 0,
})
--[[
minetest.register_tool("3d_armor:chestplate_diamond", {
	description = "Diamond Chestplate",
	inventory_image = "3d_armor_inv_chestplate_diamond.png",
	groups = {armor_torso = 20, armor_heal = 12, armor_use = 100},
	wear = 0,
})]]

minetest.register_tool("3d_armor:chestplate_gold", {
	description = "Golden Chestplate",
	inventory_image = "3d_armor_inv_chestplate_gold.png",
	groups = {armor_torso = 15, armor_heal = 6, armor_use = 250},
	wear = 0,
})

if use_moreores then
	minetest.register_tool("3d_armor:chestplate_mithril", {
		description = "Mithril Chestplate",
		inventory_image = "3d_armor_inv_chestplate_mithril.png",
		groups = {armor_torso = 20, armor_heal = 12, armor_use = 50},
		wear = 0,
	})
end

-- Register leggings:

minetest.register_tool("3d_armor:leggings_wood", {
	description = "Wooden Leggings",
	inventory_image = "3d_armor_inv_leggings_wood.png",
	groups = {armor_legs = 5, armor_heal = 0, armor_use = 2000},
	wear = 0,
})

minetest.register_tool("3d_armor:leggings_steel", {
	description = "Steel Leggings",
	inventory_image = "3d_armor_inv_leggings_steel.png",
	groups = {armor_legs = 15, armor_heal = 0, armor_use = 500},
	wear = 0,
})

minetest.register_tool("3d_armor:leggings_bronze", {
	description = "Bronze Leggings",
	inventory_image = "3d_armor_inv_leggings_bronze.png",
	groups = {armor_legs = 15, armor_heal = 6, armor_use = 250},
	wear = 0,
})
--[[
minetest.register_tool("3d_armor:leggings_diamond", {
	description = "Diamond Leggings",
	inventory_image = "3d_armor_inv_leggings_diamond.png",
	groups = {armor_legs = 20, armor_heal = 12, armor_use = 100},
	wear = 0,
})]]

minetest.register_tool("3d_armor:leggings_gold", {
	description = "Golden Leggings",
	inventory_image = "3d_armor_inv_leggings_gold.png",
	groups = {armor_legs = 15, armor_heal = 6, armor_use = 250},
	wear = 0,
})

if use_moreores then
	minetest.register_tool("3d_armor:leggings_mithril", {
		description = "Mithril Leggings",
		inventory_image = "3d_armor_inv_leggings_mithril.png",
		groups = {armor_legs = 20, armor_heal = 12, armor_use = 50},
		wear = 0,
	})
end

-- Register boots:

minetest.register_tool("3d_armor:boots_wood", {
	description = "Wooden Boots",
	inventory_image = "3d_armor_inv_boots_wood.png",
	groups = {armor_feet = 5, armor_heal = 0, armor_use = 2000},
	wear = 0,
})

minetest.register_tool("3d_armor:boots_steel", {
	description = "Steel Boots",
	inventory_image = "3d_armor_inv_boots_steel.png",
	groups = {armor_feet = 10, armor_heal = 0, armor_use = 500},
	wear = 0,
})

minetest.register_tool("3d_armor:boots_bronze", {
	description = "Bronze Boots",
	inventory_image = "3d_armor_inv_boots_bronze.png",
	groups = {armor_feet = 10, armor_heal = 6, armor_use = 250},
	wear = 0,
})
--[[
minetest.register_tool("3d_armor:boots_diamond", {
	description = "Diamond Boots",
	inventory_image = "3d_armor_inv_boots_diamond.png",
	groups = {armor_feet = 15, armor_heal = 12, armor_use = 100},
	wear = 0,
})]]

minetest.register_tool("3d_armor:boots_gold", {
	description = "Golden Boots",
	inventory_image = "3d_armor_inv_boots_gold.png",
	groups = {armor_feet = 10, armor_heal = 6, armor_use = 250},
	wear = 0,
})

if use_moreores then
	minetest.register_tool("3d_armor:boots_mithril", {
		description = "Mithril Boots",
		inventory_image = "3d_armor_inv_boots_mithril.png",
		groups = {armor_feet = 15, armor_heal = 12, armor_use = 50},
		wear = 0,
	})
end

-- Register crafting recipes:

local craft_ingreds = {
	wood = "default:wood",
	steel = "default:steel_ingot",
	bronze = "default:bronze_ingot",
	diamond = "default:diamond",
	gold = "default:gold_ingot",
}

if use_moreores then
	craft_ingreds.mithril = "moreores:mithril_ingot"
end

for k, v in pairs(craft_ingreds) do
	minetest.register_craft({
		output = "3d_armor:helmet_"..k,
		recipe = {
			{v, v, v},
			{v, "", v},
			{"", "", ""},
		},
	})
	minetest.register_craft({
		output = "3d_armor:chestplate_"..k,
		recipe = {
			{v, "", v},
			{v, v, v},
			{v, v, v},
		},
	})
	minetest.register_craft({
		output = "3d_armor:leggings_"..k,
		recipe = {
			{v, v, v},
			{v, "", v},
			{v, "", v},
		},
	})
	minetest.register_craft({
		output = "3d_armor:boots_"..k,
		recipe = {
			{v, "", v},
			{v, "", v},
		},
	})
end

if minetest.setting_getbool("log_mods") then
	minetest.log("action", "Carbone: [3d_armor] loaded.")
end
