-- mods/default/crafting.lua

minetest.register_craft({
	output = 'default:wood 4',
	recipe = {
		{'default:tree'},
	}
})

minetest.register_craft({
	output = 'default:junglewood 4',
	recipe = {
		{'default:jungletree'},
	}
})

minetest.register_craft({
	output = 'default:pine_wood 4',
	recipe = {
		{'default:pine_tree'},
	}
})

minetest.register_craft({
	output = 'default:acacia_wood 4',
	recipe = {
		{'default:acacia_tree'},
	}
})

minetest.register_craft({
	output = 'default:aspen_wood 4',
	recipe = {
		{'default:aspen_tree'},
	}
})

minetest.register_craft({
	output = 'default:wood',
	recipe = {
		{'default:bush_stem'},
	}
})

minetest.register_craft({
	output = 'default:acacia_wood',
	recipe = {
		{'default:acacia_bush_stem'},
	}
})

minetest.register_craft({
	output = 'default:stick 4',
	recipe = {
		{'group:wood'},
	}
})

minetest.register_craft({
	output = 'default:wood',
	recipe = {
		{'group:stick', 'group:stick'},
		{'group:stick', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:stick 6',
	recipe = {
		{'default:dry_shrub', 'default:dry_shrub', 'default:dry_shrub'},
		{'default:dry_shrub', 'default:dry_shrub', 'default:dry_shrub'},
		{'default:dry_shrub', 'default:dry_shrub', 'default:dry_shrub'},
	}
})

minetest.register_craft({
	output = 'default:sign_wall_steel 3',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:sign_wall_wood 3',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
		{'', 'group:stick', ''},
	}
})
minetest.register_craft({
	output = 'default:fence_wood 2',
	recipe = {
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', 'group:stick', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:torch 4',
	recipe = {
		{'default:coal_lump'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:pick_wood',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'default:duct_tape', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_stone',
	recipe = {
		{'group:stone', 'group:stone', 'group:stone'},
		{'default:duct_tape', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_steel',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:duct_tape', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_bronze',
	recipe = {
		{'default:bronze_ingot', 'default:bronze_ingot', 'default:bronze_ingot'},
		{'', 'group:stick', ''},
		{'default:duct_tape', 'group:stick', ''},
	}
})
--[[
minetest.register_craft({
	output = 'default:pick_mese',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_diamond',
	recipe = {
		{'default:diamond', 'default:diamond', 'default:diamond'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})
]]
--moreores
minetest.register_craft({
	output = 'default:pick_mithril',
	recipe = {
		{'default:mithril_ingot', 'default:mithril_ingot', 'default:mithril_ingot'},
		{'', 'group:stick', ''},
		{'default:duct_tape', 'group:stick', ''},
	}
})


minetest.register_craft({
	output = 'default:shovel_wood',
	recipe = {
		{'default:duct_tape','group:wood',''},
		{'','group:stick',''},
		{'','group:stick',''},
	}
})

minetest.register_craft({
	output = 'default:shovel_stone',
	recipe = {
		{'default:duct_tape','group:stone',''},
		{'','group:stick',''},
		{'','group:stick',''},
	}
})

minetest.register_craft({
	output = 'default:shovel_steel',
	recipe = {
		{'default:duct_tape','default:steel_ingot',''},
		{'','group:stick',''},
		{'','group:stick',''},
	}
})

minetest.register_craft({
	output = 'default:shovel_bronze',
	recipe = {
		{'default:duct_tape','default:bronze_ingot',''},
		{'','group:stick',''},
		{'','group:stick',''},
	}
})
--[[
minetest.register_craft({
	output = 'default:shovel_mese',
	recipe = {
		{'default:mese_crystal'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_diamond',
	recipe = {
		{'default:diamond'},
		{'group:stick'},
		{'group:stick'},
	}
})
]]
minetest.register_craft({
	output = 'default:axe_wood',
	recipe = {
		{'group:wood', 'group:wood',''},
		{'group:wood', 'group:stick',''},
		{'', 'group:stick','default:duct_tape'},
	}
})

minetest.register_craft({
	output = 'default:axe_stone',
	recipe = {
		{'group:stone', 'group:stone',''},
		{'group:stone', 'group:stick',''},
		{'', 'group:stick','default:duct_tape'},
	}
})

minetest.register_craft({
	output = 'default:axe_steel',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot',''},
		{'default:steel_ingot', 'group:stick',''},
		{'', 'group:stick','default:duct_tape',},
	}
})

minetest.register_craft({
	output = 'default:axe_bronze',
	recipe = {
		{'default:bronze_ingot', 'default:bronze_ingot',''},
		{'default:bronze_ingot', 'group:stick',''},
		{'', 'group:stick','default:duct_tape'},
	}
})
--[[
minetest.register_craft({
	output = 'default:axe_mese',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_diamond',
	recipe = {
		{'default:diamond', 'default:diamond'},
		{'default:diamond', 'group:stick'},
		{'', 'group:stick'},
	}
})
]]
minetest.register_craft({
	output = 'default:axe_wood',
	recipe = {
		{'','group:wood', 'group:wood'},
		{'','group:stick', 'group:wood'},
		{'default:duct_tape','group:stick',''},
	}
})

minetest.register_craft({
	output = 'default:axe_stone',
	recipe = {
		{'','group:stone', 'group:stone'},
		{'','group:stick', 'group:stone'},
		{'default:duct_tape','group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:axe_steel',
	recipe = {
		{'','default:steel_ingot', 'default:steel_ingot'},
		{'','group:stick', 'default:steel_ingot'},
		{'default:duct_tape','group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:axe_bronze',
	recipe = {
		{'','default:bronze_ingot', 'default:bronze_ingot'},
		{'','group:stick', 'default:bronze_ingot'},
		{'default:duct_tape','group:stick', ''},
	}
})
--[[
minetest.register_craft({
	output = 'default:axe_mese',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal'},
		{'group:stick', 'default:mese_crystal'},
		{'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:axe_diamond',
	recipe = {
		{'default:diamond', 'default:diamond'},
		{'group:stick', 'default:diamond'},
		{'group:stick', ''},
	}
})
]]
minetest.register_craft({
	output = 'default:bokken',
	recipe = {
		{'','group:wood',''},
		{'','group:wood',''},
		{'default:duct_tape','group:stick',''},
	}
})

minetest.register_craft({
	output = 'default:club_stone',
	recipe = {
		{'','group:stone',''},
		{'','group:stone',''},
		{'default:duct_tape','group:stick',''},
	}
})

minetest.register_craft({
	output = 'default:machete_steel',
	recipe = {
		{'','default:steel_ingot',''},
		{'','default:steel_ingot',''},
		{'default:duct_tape','group:stick',''},
	}
})

minetest.register_craft({
	output = 'default:machete_bronze',
	recipe = {
		{'','default:bronze_ingot',''},
		{'','default:bronze_ingot',''},
		{'default:duct_tape','group:stick',''},
	}
})
--[[
minetest.register_craft({
	output = 'default:sword_mese',
	recipe = {
		{'default:mese_crystal'},
		{'default:mese_crystal'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_diamond',
	recipe = {
		{'default:diamond'},
		{'default:diamond'},
		{'group:stick'},
	}
})
]]
--moreores
minetest.register_craft({
	output = 'default:sword_mithril',
	recipe = {
		{'','default:mithril_ingot',''},
		{'','default:mithril_ingot',''},
		{'default:duct_tape','group:stick',''},
	}
})

minetest.register_craft({
	output = 'default:skeleton_key',
	recipe = {
		{'default:gold_ingot'},
	}
})

minetest.register_craft({
	output = 'default:chest',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:wood', '', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'default:chest_locked',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:wood', 'default:steel_ingot', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft( {
	type = "shapeless",
	output = "default:chest_locked",
	recipe = {"default:chest", "default:steel_ingot"},
})

minetest.register_craft({
	output = 'default:furnace',
	recipe = {
		{'group:stone', 'group:stone', 'group:stone'},
		{'group:stone', 'default:dry_shrub', 'group:stone'},
		{'group:stone', 'group:stone', 'group:stone'},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "default:bronze_ingot",
	recipe = {"default:steel_ingot", "default:copper_ingot"},
})

minetest.register_craft({
	type = "shapeless",
	output = "default:bronze_ingot",
	recipe = {"default:tin_ingot", "default:copper_ingot"},
})

minetest.register_craft({
	output = 'default:coalblock',
	recipe = {
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
	}
})

minetest.register_craft({
	output = 'default:coal_lump 9',
	recipe = {
		{'default:coalblock'},
	}
})

minetest.register_craft({
	output = 'default:steelblock',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'default:steel_ingot 9',
	recipe = {
		{'default:steelblock'},
	}
})

minetest.register_craft({
	output = 'default:copperblock',
	recipe = {
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
	}
})

minetest.register_craft({
	output = 'default:copper_ingot 9',
	recipe = {
		{'default:copperblock'},
	}
})

minetest.register_craft({
	output = 'default:bronzeblock',
	recipe = {
		{'default:bronze_ingot', 'default:bronze_ingot', 'default:bronze_ingot'},
		{'default:bronze_ingot', 'default:bronze_ingot', 'default:bronze_ingot'},
		{'default:bronze_ingot', 'default:bronze_ingot', 'default:bronze_ingot'},
	}
})

minetest.register_craft({
	output = 'default:bronze_ingot 9',
	recipe = {
		{'default:bronzeblock'},
	}
})

minetest.register_craft({
	output = 'default:goldblock',
	recipe = {
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
	}
})

minetest.register_craft({
	output = 'default:gold_ingot 9',
	recipe = {
		{'default:goldblock'},
	}
})

minetest.register_craft({
	output = 'default:diamondblock',
	recipe = {
		{'default:diamond', 'default:diamond', 'default:diamond'},
		{'default:diamond', 'default:diamond', 'default:diamond'},
		{'default:diamond', 'default:diamond', 'default:diamond'},
	}
})

minetest.register_craft({
	output = 'default:diamond 9',
	recipe = {
		{'default:diamondblock'},
	}
})

--moreores
minetest.register_craft({
	output = 'default:tinblock',
	recipe = {
		{'default:tin_ingot', 'default:tin_ingot', 'default:tin_ingot'},
		{'default:tin_ingot', 'default:tin_ingot', 'default:tin_ingot'},
		{'default:tin_ingot', 'default:tin_ingot', 'default:tin_ingot'},
	}
})
minetest.register_craft({
	output = 'default:tin_ingot 9',
	recipe = {
		{'default:tinblock'},
	}
})

minetest.register_craft({
	output = 'default:silverblock',
	recipe = {
		{'default:silver_ingot', 'default:silver_ingot', 'default:silver_ingot'},
		{'default:silver_ingot', 'default:silver_ingot', 'default:silver_ingot'},
		{'default:silver_ingot', 'default:silver_ingot', 'default:silver_ingot'},
	}
})
minetest.register_craft({
	output = 'default:silver_ingot 9',
	recipe = {
		{'default:silverblock'},
	}
})

minetest.register_craft({
	output = 'default:mithrilblock',
	recipe = {
		{'default:mithril_ingot', 'default:mithril_ingot', 'default:mithril_ingot'},
		{'default:mithril_ingot', 'default:mithril_ingot', 'default:mithril_ingot'},
		{'default:mithril_ingot', 'default:mithril_ingot', 'default:mithril_ingot'},
	}
})
minetest.register_craft({
	output = 'default:mithril_ingot 9',
	recipe = {
		{'default:mithrilblock'},
	}
})









--stones
minetest.register_craft({
	output = 'default:sandstone',
	recipe = {
		{'group:sand', 'group:sand'},
		{'group:sand', 'group:sand'},
	}
})

minetest.register_craft({
	output = 'default:sand 4',
	recipe = {
		{'default:sandstone'},
	}
})

minetest.register_craft({
	output = 'default:sandstonebrick 4',
	recipe = {
		{'default:sandstone', 'default:sandstone'},
		{'default:sandstone', 'default:sandstone'},
	}
})

minetest.register_craft({
	output = 'default:sandstone_block 9',
	recipe = {
		{'default:sandstone', 'default:sandstone', 'default:sandstone'},
		{'default:sandstone', 'default:sandstone', 'default:sandstone'},
		{'default:sandstone', 'default:sandstone', 'default:sandstone'},
	}
})

minetest.register_craft({
	output = "default:desert_sandstone",
	recipe = {
		{"default:desert_sand", "default:desert_sand"},
		{"default:desert_sand", "default:desert_sand"},
	}
})

minetest.register_craft({
	output = "default:desert_sand 4",
	recipe = {
		{"default:desert_sandstone"},
	}
})

minetest.register_craft({
	output = "default:desert_sandstone_brick 4",
	recipe = {
		{"default:desert_sandstone", "default:desert_sandstone"},
		{"default:desert_sandstone", "default:desert_sandstone"},
	}
})

minetest.register_craft({
	output = "default:desert_sandstone_block 9",
	recipe = {
		{"default:desert_sandstone", "default:desert_sandstone", "default:desert_sandstone"},
		{"default:desert_sandstone", "default:desert_sandstone", "default:desert_sandstone"},
		{"default:desert_sandstone", "default:desert_sandstone", "default:desert_sandstone"},
	}
})

minetest.register_craft({
	output = "default:silver_sandstone",
	recipe = {
		{"default:silver_sand", "default:silver_sand"},
		{"default:silver_sand", "default:silver_sand"},
	}
})

minetest.register_craft({
	output = "default:silver_sand 4",
	recipe = {
		{"default:silver_sandstone"},
	}
})

minetest.register_craft({
	output = "default:silver_sandstone_brick 4",
	recipe = {
		{"default:silver_sandstone", "default:silver_sandstone"},
		{"default:silver_sandstone", "default:silver_sandstone"},
	}
})

minetest.register_craft({
	output = "default:silver_sandstone_block 9",
	recipe = {
		{"default:silver_sandstone", "default:silver_sandstone", "default:silver_sandstone"},
		{"default:silver_sandstone", "default:silver_sandstone", "default:silver_sandstone"},
		{"default:silver_sandstone", "default:silver_sandstone", "default:silver_sandstone"},
	}
})

minetest.register_craft({
	output = 'default:clay',
	recipe = {
		{'default:clay_lump', 'default:clay_lump'},
		{'default:clay_lump', 'default:clay_lump'},
	}
})

minetest.register_craft({
	output = 'default:brick',
	recipe = {
		{'default:clay_brick', 'default:clay_brick'},
		{'default:clay_brick', 'default:clay_brick'},
	}
})

minetest.register_craft({
	output = 'default:clay_brick 4',
	recipe = {
		{'default:brick'},
	}
})

minetest.register_craft({
	output = 'default:paper',
	recipe = {
		{'default:papyrus', 'default:papyrus', 'default:papyrus'},
	}
})

minetest.register_craft({
	output = 'default:book',
	recipe = {
		{'default:paper'},
		{'default:paper'},
		{'default:paper'},
	}
})

minetest.register_craft({
	output = 'default:bookshelf',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'default:book', 'default:book', 'default:book'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'default:ladder',
	recipe = {
		{'group:stick', '', 'group:stick'},
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:ladder_steel 15',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', '', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'default:ladder_steel 15',
	recipe = {
		{'default:tin_ingot', '', 'default:tin_ingot'},
		{'default:tin_ingot', 'default:tin_ingot', 'default:tin_ingot'},
		{'default:tin_ingot', '', 'default:tin_ingot'},
	}
})

minetest.register_craft({
	output = 'default:mese',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'default:meselamp 1',
	recipe = {
		{'', 'default:mese_crystal',''},
		{'default:mese_crystal', 'default:glass', 'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = "default:mese_post_light 3",
	recipe = {
		{"", "default:glass", ""},
		{"default:mese_crystal", "default:mese_crystal", "default:mese_crystal"},
		{"", "group:wood", ""},
	}
})

minetest.register_craft({
	output = 'default:mese_crystal 9',
	recipe = {
		{'default:mese'},
	}
})

--Playing with a new mese recipie  mobs_futuremobs:alien_skin
minetest.register_craft({
	output = 'default:mese_crystal_fragment_stasis 4',
	recipe = {
	{'', 'mobs_futuremobs:alien_skin',''},
		{'default:obsidian_shard', 'default:copper_ingot', 'default:glass'},
	}
})

minetest.register_craft({
	output = 'default:mese_crystal_fragment_stasis 4',
	recipe = {
			{'', 'mobs_futuremobs:alien_skin',''},
		{'default:obsidian_shard', 'default:tin_ingot', 'default:glass'},
	}
})

minetest.register_craft({
	output = 'default:mese_crystal_fragment_stasis 4',
	recipe = {
	{'', 'mobs_futuremobs:alien_skin',''},
		{'default:obsidian_shard', 'default:silver_ingot', 'default:glass'},
	}
})

minetest.register_craft({
	output = 'default:mese_crystal 4',
	recipe = {
	{'', 'mobs_futuremobs:claw',''},
		{'', 'default:mese_crystal_fragment_stasis', ''},
	}
})


minetest.register_craft({
	output = 'default:duct_tape 4',
	recipe = {
		{'default:glue','default:paper','default:glue'},
		{'default:glue','default:glue','default:glue'},
		{'default:glue','default:paper','default:glue'},
	}
})

minetest.register_craft({
	output = 'default:mese_crystal_fragment 9',
	recipe = {
		{'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'default:mese_crystal',
	recipe = {
		{'default:mese_crystal_fragment', 'default:mese_crystal_fragment', 'default:mese_crystal_fragment'},
		{'default:mese_crystal_fragment', 'default:mese_crystal_fragment', 'default:mese_crystal_fragment'},
		{'default:mese_crystal_fragment', 'default:mese_crystal_fragment', 'default:mese_crystal_fragment'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "default:mese_crystal_fragment",
	recipe = "default:mese_crystal_fragment_stasis",
	cooktime = 40,
})

minetest.register_craft({
	output = 'default:meselamp 1',
	recipe = {
		{'', 'default:mese_crystal',''},
		{'default:mese_crystal', 'default:glass', 'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'default:obsidian_shard 9',
	recipe = {
		{'default:obsidian'}
	}
})

minetest.register_craft({
	output = 'default:obsidian',
	recipe = {
		{'default:obsidian_shard', 'default:obsidian_shard', 'default:obsidian_shard'},
		{'default:obsidian_shard', 'default:obsidian_shard', 'default:obsidian_shard'},
		{'default:obsidian_shard', 'default:obsidian_shard', 'default:obsidian_shard'},
	}
})

minetest.register_craft({
	output = 'default:obsidianbrick 4',
	recipe = {
		{'default:obsidian', 'default:obsidian'},
		{'default:obsidian', 'default:obsidian'}
	}
})

minetest.register_craft({
	output = 'default:obsidian_block 9',
	recipe = {
		{'default:obsidian', 'default:obsidian', 'default:obsidian'},
		{'default:obsidian', 'default:obsidian', 'default:obsidian'},
		{'default:obsidian', 'default:obsidian', 'default:obsidian'},
	}
})

minetest.register_craft({
	output = 'default:stonebrick 4',
	recipe = {
		{'default:stone', 'default:stone'},
		{'default:stone', 'default:stone'},
	}
})

minetest.register_craft({
	output = 'default:stone_block 9',
	recipe = {
		{'default:stone', 'default:stone', 'default:stone'},
		{'default:stone', 'default:stone', 'default:stone'},
		{'default:stone', 'default:stone', 'default:stone'},
	}
})

minetest.register_craft({
	output = 'default:desert_stonebrick 4',
	recipe = {
		{'default:desert_stone', 'default:desert_stone'},
		{'default:desert_stone', 'default:desert_stone'},
	}
})

minetest.register_craft({
	output = 'default:desert_stone_block 9',
	recipe = {
		{'default:desert_stone', 'default:desert_stone', 'default:desert_stone'},
		{'default:desert_stone', 'default:desert_stone', 'default:desert_stone'},
		{'default:desert_stone', 'default:desert_stone', 'default:desert_stone'},
	}
})

minetest.register_craft({
	output = 'default:snowblock',
	recipe = {
		{'default:snow', 'default:snow', 'default:snow'},
		{'default:snow', 'default:snow', 'default:snow'},
		{'default:snow', 'default:snow', 'default:snow'},
	}
})

minetest.register_craft({
	output = 'default:snow 9',
	recipe = {
		{'default:snowblock'},
	}
})

minetest.register_craft({
	output = 'default:cobble 5',
	recipe = {
		{'default:furnace'},
	}
})

minetest.register_craft({
	output = 'default:desert_cobble 3',
	recipe = {
	{'default:clay_brick',},
    {'default:cobble', },
    {'default:cobble', },
}
})

minetest.register_craft({
	output = 'default:car_parts 6',
	recipe = {
		{'default:wrecked_car_1'},
	}
})
--
-- Crafting (tool repair)
--
minetest.register_craft({
	type = "toolrepair",
	additional_wear = -0.02,
})

--
-- Cooking recipes
--

minetest.register_craft({
	type = "cooking",
	output = "default:mese_crystal",
	recipe = "default:mese_crystal_fragment_stasis",
	cooktime = 90,
})

minetest.register_craft({
	type = "cooking",
	output = "default:glass",
	recipe = "group:sand",
})

minetest.register_craft({
	type = "cooking",
	output = "default:obsidian_glass",
	recipe = "default:obsidian_shard",
})

minetest.register_craft({
	type = "cooking",
	output = "default:stone",
	recipe = "default:cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "default:stone",
	recipe = "default:mossycobble",
})

minetest.register_craft({
	type = "cooking",
	output = "default:desert_stone",
	recipe = "default:desert_cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "default:steel_ingot",
	recipe = "default:iron_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "default:copper_ingot",
	recipe = "default:copper_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "default:gold_ingot",
	recipe = "default:gold_lump",
})

--moreores
minetest.register_craft({
	type = "cooking",
	output = "default:tin_ingot",
	recipe = "default:tin_lump",
})
minetest.register_craft({
	type = "cooking",
	output = "default:silver_ingot",
	recipe = "default:silver_lump",
})
minetest.register_craft({
	type = "cooking",
	output = "default:mithril_ingot",
	recipe = "default:mithril_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "default:clay_brick",
	recipe = "default:clay_lump",
})

minetest.register_craft({
	type = 'cooking',
	output = 'default:gold_ingot',
	recipe = 'default:skeleton_key',
	cooktime = 5,
})

minetest.register_craft({
	type = 'cooking',
	output = 'default:gold_ingot',
	recipe = 'default:key',
	cooktime = 5,
})

minetest.register_craft({
	type = "cooking",
	output = "default:coal_lump 3",
	recipe = "default:dead_tree",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 90,
	output = "default:steel_ingot 5",
	recipe = "default:car_parts",
})

--[[
--CUSTOM
minetest.register_craft({
	type = "cooking",
	cooktime = 90,
	output = "default:machete_carbon_steel",
	recipe = "default:machete_steel",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 90,
	output = "default:pick_carbon_steel",
	recipe = "default:pick_steel",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 90,
	output = "default:bronze_ingot 2",
	recipe = "default:sword_bronze",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 90,
	output = "default:bronze_ingot 2",
	recipe = "default:pick_bronze",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "default:glue 7",
	recipe = "default:duct_tape",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 60,
	output = "default:steel_ingot 3",
	recipe = "default:ladder_steel",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 60,
	output = "default:steel_ingot 2",
	recipe = "default:sign_wall_steel",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 60,
	output = "default:steel_ingot 1",
	recipe = "default:shovel_steel",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 60,
	output = "default:bronze_ingot 1",
	recipe = "default:shovel_bronze",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 60,
	output = "default:steel_ingot 2",
	recipe = "default:axe_steel",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 60,
	output = "default:bronze_ingot 2",
	recipe = "default:axe_bronze",
})
]]
--
-- Fuels
--

-- Support use of group:tree
minetest.register_craft({
	type = "fuel",
	recipe = "group:tree",
	burntime = 30,
})

-- Burn time for all woods are in order of wood density,
-- which is also the order of wood colour darkness:
-- aspen, pine, apple, acacia, jungle

minetest.register_craft({
	type = "fuel",
	recipe = "default:aspen_tree",
	burntime = 22,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:pine_tree",
	burntime = 26,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:tree",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:acacia_tree",
	burntime = 34,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:jungletree",
	burntime = 38,
})


-- Support use of group:wood
minetest.register_craft({
	type = "fuel",
	recipe = "group:wood",
	burntime = 7,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:aspen_wood",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:pine_wood",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:wood",
	burntime = 7,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:acacia_wood",
	burntime = 8,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:junglewood",
	burntime = 9,
})


-- Support use of group:sapling
minetest.register_craft({
	type = "fuel",
	recipe = "group:sapling",
	burntime = 10,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:aspen_sapling",
	burntime = 8,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:pine_sapling",
	burntime = 9,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:sapling",
	burntime = 10,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:acacia_sapling",
	burntime = 11,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:junglesapling",
	burntime = 12,
})


minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_aspen_wood",
	burntime = 11,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_pine_wood",
	burntime = 13,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_wood",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_acacia_wood",
	burntime = 17,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_junglewood",
	burntime = 19,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:bush_stem",
	burntime = 7,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:acacia_bush_stem",
	burntime = 8,
})


minetest.register_craft({
	type = "fuel",
	recipe = "default:junglegrass",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:leaves",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:cactus",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:papyrus",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:bookshelf",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:ladder_wood",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:lava_source",
	burntime = 60,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:torch",
	burntime = 4,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:sign_wall_wood",
	burntime = 10,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:chest",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:chest_locked",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:apple",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:coal_lump",
	burntime = 40,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:coalblock",
	burntime = 370,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:grass_1",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:dry_grass_1",
	burntime = 2,
})
