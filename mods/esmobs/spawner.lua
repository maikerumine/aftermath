--esmobs v0.0.4
--Andrey created mob for his world needs
--made for Extreme Survival game by maikerumine

minetest.register_alias("lagsmobs:cursed_stone", "esmmobs:cursed_stone")
--minetest.register_alias("mobs:cursed_stone", "esmmobs:cursed_stone")

minetest.register_node("esmobs:cursed_stone", {
	description = "Cursed stone",
	tiles = {
		"mobs_cursed_stone_top.png",
		"mobs_cursed_stone_bottom.png",
		"mobs_cursed_stone.png",
		"mobs_cursed_stone.png",
		"mobs_cursed_stone.png",
		"mobs_cursed_stone.png"
	},
	is_ground_content = false,
	groups = {cracky=1, level=2},
	drop = 'default:goldblock',
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'esmobs:cursed_stone',
	recipe = {
		{'default:obsidian', 'default:obsidian', 'default:obsidian'},
		{'default:obsidian', 'default:goldblock', 'default:obsidian'},
		{'default:obsidian', 'default:obsidian', 'default:obsidian'},
	}
})

--bp:register_spawn("esmobs:oerkkii", "esmobs:cursed_stone", 4, -1, 2, 40, 500, -500)