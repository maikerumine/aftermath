--scifi_nodes by D00Med 

minetest.register_node("scifi_nodes:light", {
	description = "blue lightbox",
	sunlight_propagates = false,
	tiles = {
		"scifi_nodes_lighttop.png",
		"scifi_nodes_lighttop.png",
		"scifi_nodes_light.png",
		"scifi_nodes_light.png",
		"scifi_nodes_light.png",
		"scifi_nodes_light.png"
	},
	light_source = 10,
	paramtype = "light",
	sounds = default.node_sound_glass_defaults(),
	groups = {cracky=1}
})

minetest.register_node("scifi_nodes:rfloor", {
	description = "rusty floor",
	tiles = {
		"scifi_nodes_rustfloor.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 10,
	sounds = default.node_sound_metal_defaults(),
	groups = {cracky=1}
})

minetest.register_node("scifi_nodes:bfloor", {
	description = "blue floor",
	tiles = {
		"scifi_nodes_bluefloor.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 10,
	sounds = default.node_sound_metal_defaults(),
	groups = {cracky=1}
})


minetest.register_node("scifi_nodes:stripes2", {
	description = "hazard stripes2",
	sunlight_propagates = false,
	tiles = {
		"scifi_nodes_stripes2top.png",
		"scifi_nodes_stripes2top.png",
		"scifi_nodes_stripes2.png",
		"scifi_nodes_stripes2.png",
		"scifi_nodes_stripes2.png",
		"scifi_nodes_stripes2.png"
	},
	paramtype = "light",
	sounds = default.node_sound_metal_defaults(),
	groups = {cracky=1}
})

minetest.register_node("scifi_nodes:gblock", {
	description = "Green metal block",
	sunlight_propagates = false,
	tiles = {
		"scifi_nodes_gblock.png",
		"scifi_nodes_gblock.png",
		"scifi_nodes_gblock.png",
		"scifi_nodes_gblock.png",
		"scifi_nodes_gblock.png",
		"scifi_nodes_gblock.png"
	},
	paramtype = "light",
	sounds = default.node_sound_metal_defaults(),
	groups = {cracky=1}
})

minetest.register_node("scifi_nodes:gblock2", {
	description = "Green metal block 2",
	sunlight_propagates = false,
	tiles = {
		"scifi_nodes_gblock2_top.png",
		"scifi_nodes_gblock.png",
		"scifi_nodes_gblock2.png",
		"scifi_nodes_gblock2_fx.png",
		"scifi_nodes_gblock.png",
		"scifi_nodes_gblock2_front1.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = default.node_sound_metal_defaults(),
	groups = {cracky=1}
})

minetest.register_node("scifi_nodes:gblock3", {
	description = "Green metal block 3",
	sunlight_propagates = false,
	tiles = {
		"scifi_nodes_gblock2_top.png",
		"scifi_nodes_gblock.png",
		"scifi_nodes_gblock2.png",
		"scifi_nodes_gblock2_fx.png",
		"scifi_nodes_gblock.png",
		"scifi_nodes_gblock2_screen.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = default.node_sound_metal_defaults(),
	groups = {cracky=1}
})



minetest.register_node("scifi_nodes:green_light", {
	description = "green lightbox",
	sunlight_propagates = false,
	tiles = {
		"scifi_nodes_lighttop.png",
		"scifi_nodes_lighttop.png",
		"scifi_nodes_greenlight.png",
		"scifi_nodes_greenlight.png",
		"scifi_nodes_greenlight.png",
		"scifi_nodes_greenlight.png"
	},
	light_source = 10,
	paramtype = "light",
	sounds = default.node_sound_glass_defaults(),
	groups = {cracky=1}
})

minetest.register_node("scifi_nodes:red_light", {
	description = "red lightbox",
	sunlight_propagates = false,
	tiles = {
		"scifi_nodes_lighttop.png",
		"scifi_nodes_lighttop.png",
		"scifi_nodes_redlight.png",
		"scifi_nodes_redlight.png",
		"scifi_nodes_redlight.png",
		"scifi_nodes_redlight.png"
	},
	light_source = 10,
	paramtype = "light",
	sounds = default.node_sound_glass_defaults(),
	groups = {cracky=1}
})

minetest.register_node("scifi_nodes:discs", {
	description = "disc shelves",
	sunlight_propagates = false,
	tiles = {
		"scifi_nodes_box_top.png",
		"scifi_nodes_box_top.png",
		"scifi_nodes_discs.png",
		"scifi_nodes_discs.png",
		"scifi_nodes_discs.png",
		"scifi_nodes_discs.png"
	},
	paramtype = "light",
	groups = {cracky=1}
})

minetest.register_node("scifi_nodes:disc", {
	description = "disc",
	drawtype = "torchlike",
	sunlight_propagates = false,
	tiles = {
		"scifi_nodes_disc.png"
	},
	inventory_image = "scifi_nodes_disc.png",
	wield_image = "scifi_nodes_disc.png",
	paramtype = "light",
	groups = {cracky=1}
})


minetest.register_node("scifi_nodes:blink", {
	description = "blinking light",
	sunlight_propagates = false,
	tiles = {{
		name="scifi_nodes_lightbox.png",
		animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.00},
	}},
	paramtype = "light",
	groups = {cracky=1},
	sounds = default.node_sound_glass_defaults(),
	light_source = 5,
})

minetest.register_node("scifi_nodes:black_lights", {
	description = "black wallpanel",
	sunlight_propagates = false,
	tiles = {{
		name="scifi_nodes_black_lights.png",
		animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.50},
	}},
	paramtype = "light",
	groups = {cracky=1},
})

minetest.register_node("scifi_nodes:black_screen", {
	description = "black wall screen",
	sunlight_propagates = false,
	tiles = {{
		name="scifi_nodes_black_screen.png",
		animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.00},
	}},
	paramtype = "light",
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
	light_source = 1,
})

minetest.register_node("scifi_nodes:screen", {
	description = "electronic screen",
	sunlight_propagates = false,
	tiles = {{
		name="scifi_nodes_screen.png",
		animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.50},
	}},
	paramtype = "light",
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
	light_source = 5,
})

minetest.register_node("scifi_nodes:screen2", {
	description = "electronic screen 2",
	sunlight_propagates = false,
	tiles = {{
		name="scifi_nodes_screen2.png",
		animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.50},
	}},
	paramtype = "light",
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
	light_source = 5,
})



minetest.register_node("scifi_nodes:white_pad", {
	description = "white keypad",
	sunlight_propagates = false,
	tiles = {
		"scifi_nodes_white2.png",
		"scifi_nodes_white2.png",
		"scifi_nodes_white2.png",
		"scifi_nodes_white2.png",
		"scifi_nodes_white2.png",
		"scifi_nodes_white_pad.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = default.node_sound_metal_defaults(),
	groups = {cracky=1}
})

minetest.register_node("scifi_nodes:white_base", {
	description = "white wall base",
	sunlight_propagates = false,
	tiles = {
		"scifi_nodes_white2.png",
		"scifi_nodes_white2.png",
		"scifi_nodes_white_side.png",
		"scifi_nodes_white_side.png",
		"scifi_nodes_white_side.png",
		"scifi_nodes_white_side.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = default.node_sound_metal_defaults(),
	groups = {cracky=1}
})

minetest.register_node("scifi_nodes:grnpipe", {
	description = "green pipe",
	sunlight_propagates = false,
	tiles = {
		"scifi_nodes_greenpipe_front.png",
		"scifi_nodes_greenpipe_front.png",
		"scifi_nodes_greenpipe_top.png",
		"scifi_nodes_greenpipe_top.png",
		"scifi_nodes_greenpipe_top.png",
		"scifi_nodes_greenpipe_top.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
	on_place = minetest.rotate_node
})


minetest.register_node("scifi_nodes:grnpipe2", {
	description = "broken green pipe",
	sunlight_propagates = false,
	tiles = {
		"scifi_nodes_greenpipe_front.png",
		"scifi_nodes_greenpipe_front.png",
		"scifi_nodes_greenpipe2_top.png",
		"scifi_nodes_greenpipe2_top.png",
		"scifi_nodes_greenpipe2_top.png",
		"scifi_nodes_greenpipe2_top.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
	on_place = minetest.rotate_node
})


--edited wool code (Copyright (C) 2012 celeron55, Perttu Ahola <celeron55@gmail.com>)

local node = {}
-- This uses a trick: you can first define the recipes using all of the base
-- colors, and then some recipes using more specific colors for a few non-base
-- colors available. When crafting, the last recipes will be checked first.
--add new block using texture name(without "scifi_nodes_" prefix) then the description, and then the name of the block
node.types = {
	{"blue",      "blue lines",        "blue"},
	{"holes",       "metal with holes","holes"},
	{"white2",      "plastic",         "white2"},
	{"engine",      "engine",          "engine"},
	{"wall",      "metal wall",        "wall"},
	{"white",      "plastic wall",     "white"},
	{"stripes2top",     "dirty metal block","metal2"},
	{"rough",      "rough metal",      "rough"},
	{"lighttop",      "metal block",      "metal"},
	{"red",      "red lines",          "red"},
	{"green",      "green lines",      "green"},
	{"vent2",      "vent",              "vent"},
	{"stripes",      "hazard stripes", "stripes"},
	{"rust",      "rusty metal",       "rust"},
	{"mesh",      "metal mesh",       "mesh"},
	{"black",      "black wall",       "black"},
	{"blackoct",      "black octagon",       "blackoct"},
	{"blackpipe",      "black pipe",       "blackpipe"},
	{"blacktile",      "black tile",       "blktl"},
	{"blacktile2",      "black tile 2",       "blktl2"},
	{"blackvent",      "black vent",       "blkvnt"},
	{"bluebars",      "blue bars",       "bluebars"},
	{"bluemetal",      "blue metal",       "blumtl"},
	{"bluetile",      "blue tile",       "blutl"},
	{"greytile",      "grey tile",       "grytl"},
	{"mesh2",      "metal floormesh",       "mesh2"},
	{"white",      "plastic wall",       "white"},
	{"pipe",      "wall pipe",       "pipe2"},
	{"pipeside",      "side pipe",       "pipe3"},
	{"tile",      "white tile",       "tile"},
	{"whiteoct",      "white octagon",       "whiteoct"},
	{"whitetile",      "white tile2",       "whttl"},
	{"black_detail",      "black detail",       "blckdtl"},
	{"green_square",      "green metal block",       "grnblck"},
	{"red_square",      "red metal block",       "redblck"},
	{"grey_square",      "grey metal block",       "greyblck"},
	{"blue_square",      "blue metal block",       "blublck"},
	{"black_mesh",      "black vent block",       "blckmsh"},
	{"dent",      "dented metal block",       "dent"},
	{"greenmetal",      "green metal wall",       "grnmetl"},
	{"greenmetal2",      "green metal wall2",       "grnmetl2"},
	{"greenlights",      "green wall lights",       "grnlt"},
	{"greenlights2",      "green wall lights2",       "grnlt2"},
	{"greenbar",      "green light bar",       "grnlghtbr"},
	{"green2",      "green wall panel",       "grn2"},
	{"greentubes",      "green pipes",       "grntubes"},
	{"grey",      "grey wall",       "gry"},
	{"greybolts",      "grey wall bolts",       "gryblts"},
	{"greybars",      "grey bars",       "grybrs"},
	{"greydots",      "grey wall dots",       "grydts"},
	{"greygreenbar",      "gray power pipe",       "grygrnbr"},
	{"octofloor",      "Doom floor",       "octofloor"},
	{"octofloor2",      "Brown Doom floor",       "octofloor2"},
	{"doomwall1",      "Doom wall 1",       "doomwall1"},
	{"doomwall2",      "Doom wall 2",       "doomwall2"},
	{"doomwall3",      "Doom wall 3",       "doomwall3"},
	{"doomwall4",      "Doom wall 4",       "doomwall4"},
	{"doomwall41",      "Doom wall 4.1",       "doomwall4.1"},
	{"doomwall42",      "Doom wall 4.2",       "doomwall4.2"},
	{"doomwall43",      "Doom wall 4.3",       "doomwall4.3"},
	{"doomwall431",      "Doom wall 4.3.1",       "doomwall4.3.1"},
	{"doomwall44",      "Doom wall 4.4",       "doomwall4.4"},
	{"blackdmg",      "Damaged black wall",       "blckdmg"},
	{"blackdmgstripe",      "Damaged black wall(stripes)",       "blckdmgstripe"},
	{"doomengine",      "Doom engine wall",       "doomengine"},
	{"monitorwall",      "Wall monitors",       "monitorwall"},
	{"screen3",      "Wall monitor",       "screen3"},
	{"doomlight",      "Doom light",       "doomlight", 12},
	{"bluwllight",      "Blue wall light",       "capsule3", 14},
	{"fan",      "Fan",       "fan"},
}

for _, row in ipairs(node.types) do
	local name = row[1]
	local desc = row[2]
	local light = row[4]
	-- Node Definition
	minetest.register_node("scifi_nodes:"..name, {
		description = desc,
		tiles = {"scifi_nodes_"..name..".png"},
		groups = {cracky=1},
		paramtype = "light",
		sounds = default.node_sound_metal_defaults(),
		light_source = light,
	})
end

node.plants = {
	{"flower1", "Glow Flower", 1,0, 14},
	{"flower2", "Pink Flower", 1.5,0, 10},
	{"flower3", "Triffid", 2,5, 0},
	{"flower4", "Weeping flower", 1.5,0, 0},
	{"plant1", "Bulb Plant", 1,0, 0},
	{"plant2", "Trap Plant", 1.5,0, 14},
	{"plant3", "Blue Jelly Plant", 1.2,0, 10},
	{"plant4", "Green Jelly Plant", 1.2,0, 10},
	{"plant5", "Fern Plant", 1.7,0, 0},
	{"plant6", "Curly Plant", 1,0, 10},
	{"plant7", "Egg weed", 1,0, 0},
}

for _, row in ipairs(node.plants) do
	local name = row[1]
	local desc = row[2]
	local size = row[3]
	local dmg = row[4]
	local light = row[5]
	-- Node Definition
	minetest.register_node("scifi_nodes:"..name, {
		description = desc,
		tiles = {"scifi_nodes_"..name..".png"},
		drawtype = "plantlike",
		inventory_image = {"scifi_nodes_"..name..".png"},
		groups = {snappy=1, oddly_breakable_by_hand=1, dig_immediate=3, flora=1},
		paramtype = "light",
		visual_scale = size,
		buildable_to = true,
		walkable = false,
		damage_per_second = dmg,
		selection_box = {
		type = "fixed",
		fixed = {
			{-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
		}
		},
		is_ground_content = false,
		light_source = light,
	})
end

--chest code from default(Copyright (C) 2012 celeron55, Perttu Ahola <celeron55@gmail.com>)

local chest_formspec =
	"size[8,9]" ..
	default.gui_bg ..
	default.gui_bg_img ..
	default.gui_slots ..
	"list[current_name;main;0,0.3;8,4;]" ..
	"list[current_player;main;0,4.85;8,1;]" ..
	"list[current_player;main;0,6.08;8,3;8]" ..
	"listring[current_name;main]" ..
	"listring[current_player;main]" ..
	default.get_hotbar_bg(0,4.85)

local function get_locked_chest_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," .. pos.z
	local formspec =
		"size[8,9]" ..
		default.gui_bg ..
		default.gui_bg_img ..
		default.gui_slots ..
		"list[nodemeta:" .. spos .. ";main;0,0.3;8,4;]" ..
		"list[current_player;main;0,4.85;8,1;]" ..
		"list[current_player;main;0,6.08;8,3;8]" ..
		"listring[nodemeta:" .. spos .. ";main]" ..
		"listring[current_player;main]" ..
		default.get_hotbar_bg(0,4.85)
 return formspec
end


-- Helper functions

local function drop_chest_stuff()
	return function(pos, oldnode, oldmetadata, digger)
		local meta = minetest.get_meta(pos)
		meta:from_table(oldmetadata)
		local inv = meta:get_inventory()
		for i = 1, inv:get_size("main") do
			local stack = inv:get_stack("main", i)
			if not stack:is_empty() then
				local p = {
					x = pos.x + math.random(0, 5)/5 - 0.5,
					y = pos.y,
					z = pos.z + math.random(0, 5)/5 - 0.5}
				minetest.add_item(p, stack)
			end
		end
	end
end

--chest code Copyright (C) 2011-2012 celeron55, Perttu Ahola <celeron55@gmail.com>
minetest.register_node("scifi_nodes:crate", {
	description = "Crate",
	tiles = {"scifi_nodes_crate.png"},
	paramtype2 = "facedir",
	groups = {cracky = 1, oddly_breakable_by_hand = 2, fuel = 8},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_wood_defaults(),

	after_dig_node = drop_chest_stuff(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", chest_formspec)
		meta:set_string("infotext", "Chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 8 * 4)
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in chest at " .. minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff to chest at " .. minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes stuff from chest at " .. minetest.pos_to_string(pos))
	end,
})

minetest.register_node("scifi_nodes:box", {
	description = "Storage box",
	tiles = {
		"scifi_nodes_box_top.png",
		"scifi_nodes_box_top.png",
		"scifi_nodes_box.png",
		"scifi_nodes_box.png",
		"scifi_nodes_box.png",
		"scifi_nodes_box.png"
	},
	paramtype2 = "facedir",
	groups = {cracky = 1, oddly_breakable_by_hand = 2, fuel = 8},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_metal_defaults(),

	after_dig_node = drop_chest_stuff(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", chest_formspec)
		meta:set_string("infotext", "Chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 8 * 4)
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in chest at " .. minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff to chest at " .. minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes stuff from chest at " .. minetest.pos_to_string(pos))
	end,
})
--end of chest code

minetest.register_node("scifi_nodes:blumetlight", {
	description = "blue metal light",
	sunlight_propagates = false,
	tiles = {
		"scifi_nodes_bluemetal.png",
		"scifi_nodes_bluemetal.png",
		"scifi_nodes_blue_metal_light.png",
		"scifi_nodes_blue_metal_light.png",
		"scifi_nodes_blue_metal_light.png",
		"scifi_nodes_blue_metal_light.png"
	},
	light_source = 10,
	paramtype = "light",
	sounds = default.node_sound_metal_defaults(),
	groups = {cracky=1}
})


minetest.register_node("scifi_nodes:lightstp", {
	description = "twin lights",
	sunlight_propagates = false,
	tiles = {
		"scifi_nodes_lightstripe.png"
	},
	light_source = default.LIGHT_MAX,
	paramtype = "light",
	sounds = default.node_sound_metal_defaults(),
	groups = {cracky=1}
})

minetest.register_node("scifi_nodes:blklt2", {
	description = "black stripe light",
	sunlight_propagates = false,
	tiles = {
		"scifi_nodes_black_light2.png"
	},
	light_source = 10,
	paramtype = "light",
	sounds = default.node_sound_metal_defaults(),
	groups = {cracky=1}
})

minetest.register_node("scifi_nodes:blumetstr", {
	description = "blue stripe light",
	sunlight_propagates = false,
	tiles = {
		"scifi_nodes_blue_metal_stripes2.png"
	},
	light_source = 10,
	paramtype = "light",
	sounds = default.node_sound_metal_defaults(),
	groups = {cracky=1}
})

minetest.register_node("scifi_nodes:glass", {
	description = "dark glass",
	drawtype = "glasslike",
	sunlight_propagates = false,
	tiles = {
		"scifi_nodes_glass.png"
	},
	use_texture_alpha = true,
	paramtype = "light",
	sounds = default.node_sound_glass_defaults(),
	groups = {cracky=1}
})

minetest.register_node("scifi_nodes:whtlightbnd", {
	description = "white light stripe",
	sunlight_propagates = false,
	tiles = {
		"scifi_nodes_lightband.png"
	},
	light_source = 10,
	paramtype = "light",
	sounds = default.node_sound_metal_defaults(),
	groups = {cracky=1}
})

--extra stuff
local xpane = minetest.get_modnames()
if xpane == xpane then
dofile(minetest.get_modpath("scifi_nodes").."/panes.lua")
end
dofile(minetest.get_modpath("scifi_nodes").."/doors.lua")
dofile(minetest.get_modpath("scifi_nodes").."/nodeboxes.lua")
dofile(minetest.get_modpath("scifi_nodes").."/models.lua")
--dofile(minetest.get_modpath("scifi_nodes").."/flowers.lua")