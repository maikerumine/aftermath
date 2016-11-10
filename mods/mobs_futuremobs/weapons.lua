--Weapons!

-- Light Steel Stuffs:

minetest.register_tool("mobs_futuremobs:sword_lightsteel_blue", {
	description = "Blue LightSteel Sword",
	inventory_image = "sword_lightsteel_blue.png",
	tool_capabilities = {
		full_punch_interval = 0.4,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=3.75, [2]=2.75, [3]=2.85}, uses=3, maxlevel=1},
			snappy={times={[1]=2.75, [2]=1.75, [3]=0.75}, uses=3, maxlevel=1},
		},
		damage_groups = {fleshy=9},
	},
})

minetest.register_tool("mobs_futuremobs:claw", {
	description = "A Sharp Claw",
	inventory_image = "claw.png",
	tool_capabilities = {
		full_punch_interval = 2,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=3.75, [2]=2.75, [3]=2.85}, uses=3, maxlevel=1},
			snappy={times={[1]=2.75, [2]=1.75, [3]=0.75}, uses=3, maxlevel=1},
		},
		damage_groups = {fleshy=17},
	},
})

minetest.register_tool("mobs_futuremobs:sword_lightsteel_red", {
	description = "Red LightSteel Sword",
	inventory_image = "sword_lightsteel_red.png",
	tool_capabilities = {
		full_punch_interval = 0.4,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=3.35, [2]=2.10, [3]=2.85}, uses=10, maxlevel=1},
			snappy={times={[1]=2.75, [2]=1.75, [3]=0.75}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=9},
	},
})

minetest.register_tool("mobs_futuremobs:lasergun_blue", {
	description = "This Is Just A weapon For Mobs , You shouldnt be able to get this  ",
	inventory_image = "blue_laser_gun_.png",
	tool_capabilities = {
		full_punch_interval = 2,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=3.75, [2]=2.75, [3]=2.85}, uses=10, maxlevel=1},
			snappy={times={[1]=2.75, [2]=1.75, [3]=0.75}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=2.50},
	},
})

minetest.register_tool("mobs_futuremobs:lasergun_red", {
	description = "This Is Just A weapon For Mobs , You shouldnt be able to get this  ",
	inventory_image = "red_laser_gun_.png",
	tool_capabilities = {
		full_punch_interval = 2,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=3.75, [2]=2.75, [3]=2.85}, uses=10, maxlevel=1},
			snappy={times={[1]=2.75, [2]=1.75, [3]=0.75}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=2.50},
	},
})

-- Zanium Stuff

minetest.register_tool("mobs_futuremobs:pick_zanium", {
	description = "Zanium Pickaxe",
	inventory_image = "future_zanium_pick.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=3.00, [2]=1.00, [3]=0.50}, uses=26, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})

minetest.register_tool("mobs_futuremobs:shovel_zanium", {
	description = "Zanium Shovel",
	inventory_image = "future_zanium_shovel.png",
	wield_image = "future_zanium_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.10, [2]=0.60, [3]=0.30}, uses=40, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})
minetest.register_tool("mobs_futuremobs:axe_zanium", {
	description = "Zanium Axe",
	inventory_image = "future_zanium_axe.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.00, [2]=1.10, [3]=0.80}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("mobs_futuremobs:sword_zanium", {
	description = "Zanium Sword",
	inventory_image = "future_zanium_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.2}, uses=35, maxlevel=2},
		},
		damage_groups = {fleshy=7},
	}
})
--[[
--And the crafts...
minetest.register_craft({
	output = 'futureweapons:sword_lightsteel_blue',
	recipe = {
		{'default:crystal_blue', 'default:lightsteel_ingot', ''},
		{'', 'default:lightsteel_ingot', ''},
		{'', 'default:steel_ingot', ''},
	}
})

minetest.register_craft({
	output = 'futureweapons:sword_lightsteel_red',
	recipe = {
		{'default:crystal_red', 'default:lightsteel_ingot', ''},
		{'', 'default:lightsteel_ingot', ''},
		{'', 'default:steel_ingot', ''},
	}
})

minetest.register_craft({
	output = 'futureweapons:pick_zanium',
	recipe = {
		{'default:zanium_ingot', 'default:zanium_ingot', 'default:zanium_ingot'},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'futureweapons:shovel_zanium',
	recipe = {
		{'', 'default:zanium_ingot', ''},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'futureweapons:axe_zanium',
	recipe = {
		{'', 'default:zanium_ingot', 'default:zanium_ingot'},
		{'', 'default:stick', 'default:zanium_ingot'},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'futureweapons:axe_zanium',
	recipe = {
		{'default:zanium_ingot', 'default:zanium_ingot', ''},
		{'default:zanium_ingot', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'futureweapons:sword_zanium',
	recipe = {
		{'', 'default:zanium_ingot', ''},
		{'', 'default:zanium_ingot', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'futureweapons:pick_hotium',
	recipe = {
		{'default:hotium_ingot', 'default:hotium_ingot', 'default:hotium_ingot'},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'futureweapons:shovel_hotium',
	recipe = {
		{'', 'default:hotium_ingot', ''},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'futureweapons:axe_hotium',
	recipe = {
		{'', 'default:hotium_ingot', 'default:hotium_ingot'},
		{'', 'default:stick', 'default:hotium_ingot'},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'futureweapons:axe_hotium',
	recipe = {
		{'default:hotium_ingot', 'default:hotium_ingot', ''},
		{'default:hotium_ingot', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'futureweapons:sword_hotium',
	recipe = {
		{'', 'default:hotium_ingot', ''},
		{'', 'default:hotium_ingot', ''},
		{'', 'default:stick', ''},
	}
})

]]
-- Hotium Stuff

minetest.register_tool("mobs_futuremobs:pick_hotium", {
	description = "Hotium Pickaxe",
	inventory_image = "future_hotium_pick.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=2.70, [2]=0.80, [3]=0.30}, uses=29, maxlevel=2},
		},
		damage_groups = {fleshy=5},
	},
})

minetest.register_tool("mobs_futuremobs:shovel_hotium", {
	description = "Hotium Shovel",
	inventory_image = "future_hotium_shovel.png",
	wield_image = "future_hotium_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=0.90, [2]=0.40, [3]=0.20}, uses=40, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})
minetest.register_tool("mobs_futuremobs:axe_hotium", {
	description = "Hotium Axe",
	inventory_image = "future_hotium_axe.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=1.70, [2]=1.00, [3]=0.70}, uses=33, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("mobs_futuremobs:sword_hotium", {
	description = "Hotium Sword",
	inventory_image = "future_hotium_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.8, [2]=0.8, [3]=0.1}, uses=36, maxlevel=2},
		},
		damage_groups = {fleshy=7},
	}
})