-- ITEMS
minetest.register_node("medicine:medicine_block", {
		description = ("Medicine Block (red)"),
		tiles = {"medicine_block.png"},
		paramtype = "light",
		sunlight_propagates = true,
		light_source = 15,
		groups = {snappy = 3, cracky = 4, oddly_breakable_by_hand = 4},
		sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("medicine:medicine_block2", {
		description = ("Medicine Block (blue)"),
		tiles = {"medicine_block2.png"},
		paramtype = "light",
		sunlight_propagates = true,
		light_source = 15,
		groups = {snappy = 3, cracky = 4, oddly_breakable_by_hand = 4},
		sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem('medicine:filling_syringe', {
    description = 'Filling Syringe',
    inventory_image = 'filling_syringe.png',
    stack_max = 12,
    on_use = minetest.item_eat(20, 'medicine:empty_syringe'),
})

minetest.register_craftitem('medicine:empty_syringe', {
    description = 'Empty Syringe',
    inventory_image = 'empty_syringe.png',
    stack_max = 12,
})

minetest.register_craftitem('medicine:pill', {
    description = 'Pill',
    inventory_image = 'pill.png',
    stack_max = 12,
    on_use = minetest.item_eat(20),
})

minetest.register_craftitem('medicine:tablet', {
    description = 'Tablet',
    inventory_image = 'tablet.png',
    stack_max = 12,
    on_use = minetest.item_eat(20),
})

minetest.register_craftitem('medicine:alcohol', {
    description = 'Alcohol',
    inventory_image = 'alcohol.png',
    stack_max = 12,
})

minetest.register_craftitem('medicine:mask', {
    description = 'Mask',
    inventory_image = 'mask.png',
    stack_max = 12,
})

minetest.register_craftitem('medicine:thermometr', {
    description = 'Thermometr',
    inventory_image = 'thermometr.png',
    stack_max = 12,
})

minetest.register_craftitem('medicine:headphones', {
    description = 'Headphones',
    inventory_image = 'headphones.png',
    stack_max = 12,
})

minetest.register_craftitem('medicine:pinceps', {
    description = 'Pinceps',
    inventory_image = 'pinceps.png',
    stack_max = 12,
})

minetest.register_craftitem('medicine:plaster', {
    description = 'Plaster',
    inventory_image = 'plaster.png',
    stack_max = 12,
    on_use = minetest.item_eat(5),
})

minetest.register_craftitem('medicine:cotton_wool', {
    description = 'Cotton Wool',
    inventory_image = 'cotton_wool.png',
    stack_max = 12,
    on_use = minetest.item_eat(2),
})

minetest.register_node("medicine:sign", {
	description = "Sign (Hospital)",
	drawtype = "signlike",
	tiles = {"sign.png"},
	inventory_image = "sign.png",
	wield_image = "sign.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups = {choppy=2,dig_immediate=2,attached_node=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})
-- CRAFTS
minetest.register_craft({
    output = 'medicine:medicine_block',
    recipe = {
      {'default:steel_ingot','default:steel_ingot','default:steel_ingot'},
      {'default:steel_ingot','dye:red','default:steel_ingot'},
      {'default:steel_ingot','dye:red','default:steel_ingot'},
    }
})
  
minetest.register_craft({
    output = 'medicine:medicine_block2',
    recipe = {
      {'default:steel_ingot','default:steel_ingot','default:steel_ingot'},
      {'default:steel_ingot','dye:blue','default:steel_ingot'},
      {'default:steel_ingot','dye:blue','default:steel_ingot'},
    }
})
  
minetest.register_craft({
    output = 'medicine:empty_syringe',
    recipe = {
      {'default:glass','',''},
      {'default:glass','',''},
      {'','',''},
    }
})

minetest.register_craft({
    output = 'medicine:filling_syringe',
    recipe = {
      {'medicine:empty_syringe','',''},
      {'medicine:alcohol','bucket:bucket_water',''},
      {'medicine:tablet','bucket:bucket_water',''},
    }
})

minetest.register_craft({
    output = 'medicine:mask',
    recipe = {
      {'farming:cotton','',''},
      {'farming:cotton','',''},
      {'','',''},
    }
})

minetest.register_craft({
    output = 'medicine:pill',
    recipe = {
      {'medicine:alcohol','',''},
      {'default:leaves','',''},
      {'','',''},
    }
})

minetest.register_craft({
    output = 'medicine:tablet',
    recipe = {
      {'default:leaves','',''},
      {'medicine:alcohol','',''},
      {'','',''},
    }
})

minetest.register_craft({
    output = 'medicine:alcohol',
    recipe = {
      {'bucket:bucket_water','',''},
      {'default:leaves','',''},
      {'default:glass','',''},
    }
})
  
minetest.register_craft({
    output = 'medicine:headphones',
    recipe = {
      {'default:steel_ingot','',''},
      {'wool:black','',''},
      {'','',''},
    }
})

minetest.register_craft({
    output = 'medicine:thermometr',
    recipe = {
      {'default:glass','default:steel_ingot',''},
      {'','',''},
      {'','',''},
    }
})
  
minetest.register_craft({
    output = 'medicine:pinceps',
    recipe = {
      {'default:steel_ingot','',''},
      {'default:steel_ingot','',''},
      {'','',''},
    }
})
  
minetest.register_craft({
    output = 'medicine:sign',
    recipe = {
      {'medicine:medicine_block','',''},
      {'default:steel_ingot','',''},
      {'','',''},
    }
})
  
minetest.register_craft({
    output = 'medicine:plaster',
    recipe = {
      {'default:leaves','wool:yellow',''},
      {'medicine:alcohol','',''},
      {'','',''},
    }
})

minetest.register_craft({
    output = 'medicine:cotton_wool',
    recipe = {
      {'group:wool','',''},
      {'medicine:alcohol','',''},
      {'','',''},
    }
})
