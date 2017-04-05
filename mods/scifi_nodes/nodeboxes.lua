
-- GENERATED CODE
-- Node Box Editor, version 0.9.0
-- Namespace: scifi_nodes

minetest.register_node("scifi_nodes:gloshroom", {
	description = "Gloshroom",
	tiles = {
		"scifi_nodes_gloshroom.png",
		"scifi_nodes_gloshroom_under.png",
		"scifi_nodes_gloshroom.png",
		"scifi_nodes_gloshroom.png",
		"scifi_nodes_gloshroom.png",
		"scifi_nodes_gloshroom.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	light_source = default.LIGHT_MAX,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = false,
	use_texture_alpha =  true,
	groups = {fleshy=1, oddly_breakable_by_hand=1, dig_immediate=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.05, -0.5, -0.05, 0.05, 0.0625, 0.05}, -- NodeBox1
			{-0.4375, -0.0625, -0.375, 0.4375, 0, 0.375}, -- NodeBox2
			{-0.375, 0, -0.375, 0.375, 0.0625, 0.375}, -- NodeBox3
			{-0.3125, 0.0625, -0.3125, 0.3125, 0.125, 0.3125}, -- NodeBox4
			{-0.1875, 0.125, -0.1875, 0.1875, 0.1875, 0.1875}, -- NodeBox5
			{-0.375, -0.0625, -0.4375, 0.375, 0, 0.4375}, -- NodeBox6
		}
	}
})

minetest.register_node("scifi_nodes:pot_lid", {
	description = "plant pot lid(place above plant)",
	tiles = {
		"scifi_nodes_glass2.png",
		"scifi_nodes_glass2.png",
		"scifi_nodes_glass2.png",
		"scifi_nodes_glass2.png",
		"scifi_nodes_glass2.png",
		"scifi_nodes_glass2.png"
	},
	inventory_image = "scifi_nodes_pod_inv.png",
	wield_image = "scifi_nodes_pod_inv.png",
	use_texture_alpha = true,
	drawtype = "nodebox",
	paramtype = "light",
	groups = {cracky=1, not_in_creative_inventory=1},
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.5, -1.5, -0.5, 0.5, -0.5, 0.5}
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5625, -0.1875, 0.1875, -0.5, 0.1875}, -- NodeBox13
			{-0.25, -0.625, -0.25, 0.25, -0.5625, 0.25}, -- NodeBox14
			{-0.3125, -0.6875, -0.3125, 0.3125, -0.625, 0.3125}, -- NodeBox15
			{-0.375, -0.75, -0.375, 0.375, -0.6875, 0.375}, -- NodeBox16
			{-0.4375, -0.75, 0.375, 0.4375, -1.5, 0.4375}, -- NodeBox17
			{-0.4375, -0.75, -0.4375, 0.4375, -1.5, -0.375}, -- NodeBox18
			{0.375, -0.75, -0.4375, 0.4375, -1.5, 0.4375}, -- NodeBox19
			{-0.4375, -0.75, -0.4375, -0.375, -1.5, 0.4375}, -- NodeBox20
		}
	},
	sounds = default.node_sound_glass_defaults()
})



minetest.register_node("scifi_nodes:pot", {
	description = "metal plant pot (right click for lid, shift+rightclick to plant)",
	tiles = {
		"scifi_nodes_pot.png",
		"scifi_nodes_greybolts.png",
		"scifi_nodes_greybolts.png",
		"scifi_nodes_greybolts.png",
		"scifi_nodes_greybolts.png",
		"scifi_nodes_greybolts.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	groups = {crumbly=3, soil=1, sand=1, wet=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.25, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
			{0.1875, -0.5, 0.1875, 0.5, -0.25, 0.5}, -- NodeBox2
			{-0.5, -0.5, -0.5, -0.1875, -0.25, -0.1875}, -- NodeBox3
			{-0.5, -0.5, 0.1875, -0.1875, -0.25, 0.5}, -- NodeBox4
			{0.1875, -0.5, -0.5, 0.5, -0.25, -0.1875}, -- NodeBox5
		}
	},
	on_rightclick = function(pos, node, clicker, item, _)
	local node = minetest.get_node({x=pos.x, y=pos.y+2, z=pos.z})
	if node.name == "scifi_nodes:pot_lid" then
		minetest.set_node({x=pos.x, y=pos.y+2, z=pos.z}, {name="air", param2=node.param2})
	elseif node.name ~= "scifi_nodes:pot_lid" and node.name == "air" then
		minetest.set_node({x=pos.x, y=pos.y+2, z=pos.z}, {name="scifi_nodes:pot_lid", param2=node.param2})
	end
	end,
	on_destruct = function(pos, node, _)
		minetest.remove_node({x=pos.x, y=pos.y+2, z=pos.z})
	end
})

minetest.register_node("scifi_nodes:pot2", {
	description = "metal wet plant pot(right click for lid, shift+rightclick to plant)",
	tiles = {
		"scifi_nodes_pot.png^[colorize:black:100",
		"scifi_nodes_greybolts.png",
		"scifi_nodes_greybolts.png",
		"scifi_nodes_greybolts.png",
		"scifi_nodes_greybolts.png",
		"scifi_nodes_greybolts.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	groups = {crumbly=3, soil=3, wet=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.25, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
			{0.1875, -0.5, 0.1875, 0.5, -0.25, 0.5}, -- NodeBox2
			{-0.5, -0.5, -0.5, -0.1875, -0.25, -0.1875}, -- NodeBox3
			{-0.5, -0.5, 0.1875, -0.1875, -0.25, 0.5}, -- NodeBox4
			{0.1875, -0.5, -0.5, 0.5, -0.25, -0.1875}, -- NodeBox5
		}
	},
	on_rightclick = function(pos, node, clicker, item, _)
	local node = minetest.get_node({x=pos.x, y=pos.y+2, z=pos.z})
	if node.name == "scifi_nodes:pot_lid" then
		minetest.set_node({x=pos.x, y=pos.y+2, z=pos.z}, {name="air", param2=node.param2})
	elseif node.name ~= "scifi_nodes:pot_lid" and node.name == "air" then
		minetest.set_node({x=pos.x, y=pos.y+2, z=pos.z}, {name="scifi_nodes:pot_lid", param2=node.param2})
	end
	end,
	on_destruct = function(pos, node, _)
		minetest.remove_node({x=pos.x, y=pos.y+2, z=pos.z})
	end
})

minetest.register_node("scifi_nodes:lightbar", {
	description = "ceiling light",
	tiles = {
		"scifi_nodes_white2.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	light_source = default.LIGHT_MAX,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.5, 0.125, -0.375, 0.5}, -- NodeBox1
		}
	},
	groups = {cracky=1},
	sounds = default.node_sound_glass_defaults()
})
--wall switch, currently does not do anything
minetest.register_node("scifi_nodes:switch_off", {
	description = "Wall switch",
	tiles = {
		"scifi_nodes_switch_off.png",
	},
	inventory_image = "scifi_nodes_switch_on.png",
	wield_image = "scifi_nodes_switch_on.png",
	drawtype = "signlike",
	sunlight_propagates = true,
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.3, -0.3, -0.45, 0.3, 0.3}
	},
	paramtype = "light",
	paramtype2 = "wallmounted",
	groups = {cracky=1, oddly_breakable_by_hand=1},
	on_rightclick = function(pos, node, clicker, item, _)
			minetest.set_node(pos, {name="scifi_nodes:switch_on", param2=node.param2})
	end,
	sounds = default.node_sound_glass_defaults()
})

minetest.register_node("scifi_nodes:switch_on", {
	description = "Wall switch",
	sunlight_propagates = true,
	tiles = {
		"scifi_nodes_switch_on.png",
	},
	inventory_image = "scifi_nodes_switch_on.png",
	wield_image = "scifi_nodes_switch_on.png",
	drawtype = "signlike",
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.3, -0.3, -0.45, 0.3, 0.3}
	},
	paramtype = "light",
	paramtype2 = "wallmounted",
	light_source = 5,
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	on_rightclick = function(pos, node, clicker, item, _)
			minetest.set_node(pos, {name="scifi_nodes:switch_off", param2=node.param2})
	end,
	sounds = default.node_sound_glass_defaults()
})
--end of wall switch

minetest.register_node("scifi_nodes:light_dynamic", {
	description = "Wall light",
	tiles = {
		"scifi_nodes_lightoverlay.png",
	},
	inventory_image = "scifi_nodes_lightoverlay.png",
	wield_image = "scifi_nodes_lightoverlay.png",
	drawtype = "signlike",
	paramtype = "light",
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, -0.45, 0.5, 0.5}
	},
	paramtype2 = "wallmounted",
	light_source = default.LIGHT_MAX,
	groups = {cracky=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_node("scifi_nodes:ladder", {
	description = "Metal Ladder",
	tiles = {
		"scifi_nodes_ladder.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	selection_box = {
		type = "wallmounted",
		fixed = {-0.5, -0.5, -0.5, -0.45, 0.5, 0.5}
	},
	node_box = {
		type = "fixed",
		fixed = {
			{0.3125, -0.5, -0.4375, 0.4375, -0.375, -0.3125}, -- NodeBox12
			{-0.4375, -0.5, -0.4375, -0.3125, -0.375, -0.3125}, -- NodeBox13
			{-0.375, -0.375, -0.4375, 0.375, -0.3125, -0.3125}, -- NodeBox14
			{-0.375, -0.375, 0.3125, 0.375, -0.3125, 0.4375}, -- NodeBox18
			{-0.375, -0.375, 0.0625, 0.375, -0.3125, 0.1875}, -- NodeBox19
			{-0.375, -0.375, -0.1875, 0.375, -0.3125, -0.0625}, -- NodeBox20
			{-0.4375, -0.5, -0.1875, -0.3125, -0.375, -0.0625}, -- NodeBox21
			{-0.4375, -0.5, 0.0625, -0.3125, -0.375, 0.1875}, -- NodeBox22
			{-0.4375, -0.5, 0.3125, -0.3125, -0.375, 0.4375}, -- NodeBox23
			{0.3125, -0.5, 0.3125, 0.4375, -0.375, 0.4375}, -- NodeBox24
			{0.3125, -0.5, 0.0625, 0.4375, -0.375, 0.1875}, -- NodeBox25
			{0.3125, -0.5, -0.1875, 0.4375, -0.375, -0.0625}, -- NodeBox26
		}
	},
	paramtype2 = "wallmounted",
	walkable = false,
	climbable = true,
	sounds = default.node_sound_metal_defaults(),
	groups = {cracky=1, oddly_breakable_by_hand=1},
})

minetest.register_node("scifi_nodes:lightbars", {
	description = "orange lightbars",
	tiles = {
		"scifi_nodes_orange2.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	use_texture_alpha = true,
	light_source = default.LIGHT_MAX,
	node_box = {
		type = "fixed",
		fixed = {
			{0.125, -0.5, 0.125, 0.375, 0.5, 0.375}, -- NodeBox1
			{-0.375, -0.5, 0.125, -0.125, 0.5, 0.375}, -- NodeBox2
			{-0.375, -0.5, -0.375, -0.125, 0.5, -0.125}, -- NodeBox3
			{0.125, -0.5, -0.375, 0.375, 0.5, -0.125}, -- NodeBox4
		}
	},
	groups = {cracky=1},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_node("scifi_nodes:liquid_pipe", {
	description = "Liquid pipe",
tiles = {{
		name = "scifi_nodes_liquid.png",
		animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1.00},
	}},
	use_texture_alpha = true,
	light_source = default.LIGHT_MAX,
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, 0.5, 0.375}, -- NodeBox1
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_node("scifi_nodes:liquid_pipe2", {
	description = "Liquid pipe 2",
tiles = {
		"scifi_nodes_orange.png",
	},
	use_texture_alpha = true,
	light_source = default.LIGHT_MAX,
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, 0.5, 0.375}, -- NodeBox1
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_node("scifi_nodes:powered_stand", {
	description = "powered stand",
	tiles = {
		"scifi_nodes_pwrstnd_top.png",
		"scifi_nodes_pwrstnd_top.png",
		"scifi_nodes_pwrstnd_side.png",
		"scifi_nodes_pwrstnd_side.png",
		"scifi_nodes_pwrstnd_side.png",
		"scifi_nodes_pwrstnd_side.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, 0.25, -0.3125, 0.375, 0.4375, 0.3125}, -- NodeBox1
			{-0.3125, 0.25, -0.375, 0.3125, 0.4375, 0.375}, -- NodeBox2
			{-0.3125, 0.4375, -0.3125, 0.3125, 0.5, 0.3125}, -- NodeBox3
			{-0.5, -0.5, -0.125, 0.5, 0.125, 0.125}, -- NodeBox4
			{-0.125, -0.5, -0.5, 0.125, 0.125, 0.5}, -- NodeBox5
			{-0.4375, 0.125, -0.125, 0.4375, 0.25, 0.125}, -- NodeBox6
			{-0.125, 0.125, -0.4375, 0.125, 0.25, 0.4375}, -- NodeBox7
			{-0.3125, -0.5, -0.375, 0.3125, 0.0625, 0.3125}, -- NodeBox8
			{-0.25, 0.0625, -0.3125, 0.25, 0.125, 0.3125}, -- NodeBox9
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1},
	on_rightclick = function(pos, node, clicker, item, _)
		local wield_item = clicker:get_wielded_item():get_name()
		item:take_item()
		minetest.add_item({x=pos.x, y=pos.y+1, z=pos.z}, wield_item)
	end,
})

minetest.register_node("scifi_nodes:cover", {
	description = "Metal cover",
	tiles = {
		"scifi_nodes_pwrstnd_top.png",
		"scifi_nodes_pwrstnd_top.png",
		"scifi_nodes_pwrstnd_top.png",
		"scifi_nodes_pwrstnd_top.png",
		"scifi_nodes_pwrstnd_top.png",
		"scifi_nodes_pwrstnd_top.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	sounds = default.node_sound_metal_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.3125, 0.375, -0.375, 0.3125}, -- NodeBox1
			{-0.3125, -0.5, -0.375, 0.3125, -0.375, 0.375}, -- NodeBox5
			{-0.3125, -0.375, -0.3125, 0.3125, -0.3125, 0.3125}, -- NodeBox6
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1}
})

minetest.register_node("scifi_nodes:computer", {
	description = "computer",
	tiles = {
		"scifi_nodes_black.png",
		"scifi_nodes_black.png",
		"scifi_nodes_blackvent.png",
		"scifi_nodes_black.png",
		"scifi_nodes_mesh2.png",
		"scifi_nodes_pc.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.5, 0.0625, 0.5, 0.5}, -- NodeBox1
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1}
})

minetest.register_node("scifi_nodes:keysmonitor", {
	description = "Keyboard and monitor",
	tiles = {
		"scifi_nodes_keyboard.png",
		"scifi_nodes_black.png",
		"scifi_nodes_black.png",
		"scifi_nodes_black.png",
		"scifi_nodes_black.png",
		"scifi_nodes_monitor.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.4375, 0.5, -0.4375, -0.0625}, -- NodeBox1
			{-0.125, -0.5, 0.375, 0.125, 0.0625, 0.4375}, -- NodeBox2
			{-0.25, -0.5, 0.125, 0.25, -0.4375, 0.5}, -- NodeBox3
			{-0.5, -0.3125, 0.25, 0.5, 0.5, 0.375}, -- NodeBox4
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1}
})

minetest.register_node("scifi_nodes:microscope", {
	description = "Microscope",
	tiles = {
		"scifi_nodes_white.png",
		"scifi_nodes_black.png",
		"scifi_nodes_white_vent.png",
		"scifi_nodes_white_vent.png",
		"scifi_nodes_white_vent.png",
		"scifi_nodes_white_vent.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.3125, 0.25, -0.375, 0.3125}, -- NodeBox1
			{-0.0625, -0.5, 0.125, 0.0625, 0.3125, 0.25}, -- NodeBox2
			{-0.0625, -0.0625, -0.0625, 0.0625, 0.5, 0.0625}, -- NodeBox3
			{-0.0625, 0.0625, 0.0625, 0.0625, 0.25, 0.125}, -- NodeBox4
			{-0.125, -0.25, -0.125, 0.125, -0.1875, 0.1875}, -- NodeBox5
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1}
})

minetest.register_node("scifi_nodes:table", {
	description = "Metal table",
	tiles = {
		"scifi_nodes_grey.png",
		"scifi_nodes_grey.png",
		"scifi_nodes_grey.png",
		"scifi_nodes_grey.png",
		"scifi_nodes_grey.png",
		"scifi_nodes_grey.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = default.node_sound_metal_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5}, -- NodeBox1
			{-0.0625, -0.5, 0.125, 0.0625, 0.5, 0.3125}, -- NodeBox2
			{-0.0625, -0.5, 0.375, 0.0625, 0.5, 0.4375}, -- NodeBox3
			{-0.0625, -0.375, 0.0625, 0.0625, 0.4375, 0.125}, -- NodeBox4
			{-0.0625, -0.1875, 0, 0.0625, 0.4375, 0.0625}, -- NodeBox5
			{-0.0625, 0.0625, -0.0625, 0.0625, 0.4375, 0}, -- NodeBox6
			{-0.0625, 0.25, -0.125, 0.0625, 0.4375, -0.0625}, -- NodeBox7
		}
	},
	groups = {cracky=1}
})

minetest.register_node("scifi_nodes:laptop_open", {
	description = "laptop",
	tiles = {
		"scifi_nodes_lapkey.png",
		"scifi_nodes_black.png",
		"scifi_nodes_black.png",
		"scifi_nodes_black.png",
		"scifi_nodes_black.png",
		"scifi_nodes_laptop.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.375, 0.3125}, -- NodeBox1
			{-0.4375, -0.375, 0.3125, 0.4375, 0.4375, 0.4375}, -- NodeBox11
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	on_rightclick = function(pos, node, clicker, item, _)
			minetest.set_node(pos, {name="scifi_nodes:laptop_closed", param2=node.param2})
	end,
})

minetest.register_node("scifi_nodes:laptop_closed", {
	description = "laptop",
	tiles = {
		"scifi_nodes_black.png",
		"scifi_nodes_black.png",
		"scifi_nodes_black.png",
		"scifi_nodes_black.png",
		"scifi_nodes_black.png",
		"scifi_nodes_black.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.25, 0.3125}, -- NodeBox1
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1},
	on_rightclick = function(pos, node, clicker, item, _)
			minetest.set_node(pos, {name="scifi_nodes:laptop_open", param2=node.param2})
	end,
})

minetest.register_node("scifi_nodes:pipen", {
	description = "pipe(nodebox)",
	tiles = {
		"scifi_nodes_blacktile2.png",
		"scifi_nodes_blacktile2.png",
		"scifi_nodes_pipen.png",
		"scifi_nodes_pipen.png",
		"scifi_nodes_pipen.png",
		"scifi_nodes_pipen.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, 0.5, 0.4375}, -- NodeBox1
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5}, -- NodeBox2
			{-0.5, 0.3125, -0.5, 0.5, 0.375, 0.5}, -- NodeBox3
			{-0.5, 0.1875, -0.5, 0.5, 0.25, 0.5}, -- NodeBox4
			{-0.5, 0.0625, -0.5, 0.5, 0.125, 0.5}, -- NodeBox5
			{-0.5, -0.0625, -0.5, 0.5, 0, 0.5}, -- NodeBox6
			{-0.5, -0.1875, -0.5, 0.5, -0.125, 0.5}, -- NodeBox7
			{-0.5, -0.3125, -0.5, 0.5, -0.25, 0.5}, -- NodeBox8
			{-0.5, -0.4375, -0.5, 0.5, -0.375, 0.5}, -- NodeBox9
		}
	},
	groups = {cracky=1},
	on_place = minetest.rotate_node
})

minetest.register_node("scifi_nodes:windowcorner", {
	description = "strong window corner",
	tiles = {
		"scifi_nodes_glassstrngsd2.png",
		"scifi_nodes_white.png",
		"scifi_nodes_glassstrngcrnr.png",
		"scifi_nodes_glassstrngcrnr2.png",
		"scifi_nodes_white.png",
		"scifi_nodes_glassstrngsd.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	use_texture_alpha = true,
	sunlight_propagates = true,
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.5, 0.3125, -0.25, 0.5}, -- NodeBox1
			{-0.3125, -0.25, 0.25, 0.3125, -0.1875, 0.5}, -- NodeBox7
			{-0.3125, -0.25, 0.3125, 0.3125, -0.125, 0.375}, -- NodeBox8
			{-0.3125, -0.3125, 0.25, 0.3125, -0.1875, 0.3125}, -- NodeBox9
			{-0.3125, -0.5, 0.375, 0.3125, 0.5, 0.5}, -- NodeBox10
			{-0.0625, -0.5, -0.5, 0.0625, 0.5, 0.5}, -- NodeBox11
		}
	},
	groups = {cracky=1},
	on_place = minetest.rotate_node,
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("scifi_nodes:windowstraight", {
	description = "strong window",
	tiles = {
		"scifi_nodes_glassstrngsd2.png",
		"scifi_nodes_white.png",
		"scifi_nodes_glassstrng.png",
		"scifi_nodes_glassstrng.png",
		"scifi_nodes_glassstrngsd.png",
		"scifi_nodes_glassstrngsd.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	use_texture_alpha = true,
	sunlight_propagates = true,
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.5, 0.3125, -0.25, 0.5}, -- NodeBox10
			{-0.0625, -0.5, -0.5, 0.0625, 0.5, 0.5}, -- NodeBox11
		}
	},
	groups = {cracky=1},
	on_place = minetest.rotate_node,
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("scifi_nodes:windowcorner2", {
	description = "strong window corner(black)",
	tiles = {
		"scifi_nodes_glassstrngsd4.png",
		"scifi_nodes_black.png",
		"scifi_nodes_glassstrngcrnr3.png",
		"scifi_nodes_glassstrngcrnr4.png",
		"scifi_nodes_black.png",
		"scifi_nodes_glassstrngsd3.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	use_texture_alpha = true,
	sunlight_propagates = true,
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.5, 0.3125, -0.25, 0.5}, -- NodeBox1
			{-0.3125, -0.25, 0.25, 0.3125, -0.1875, 0.5}, -- NodeBox7
			{-0.3125, -0.25, 0.3125, 0.3125, -0.125, 0.375}, -- NodeBox8
			{-0.3125, -0.3125, 0.25, 0.3125, -0.1875, 0.3125}, -- NodeBox9
			{-0.3125, -0.5, 0.375, 0.3125, 0.5, 0.5}, -- NodeBox10
			{-0.0625, -0.5, -0.5, 0.0625, 0.5, 0.5}, -- NodeBox11
		}
	},
	groups = {cracky=1},
	on_place = minetest.rotate_node,
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("scifi_nodes:windowstraight2", {
	description = "strong window(black)",
	tiles = {
		"scifi_nodes_glassstrngsd4.png",
		"scifi_nodes_black.png",
		"scifi_nodes_glassstrng2.png",
		"scifi_nodes_glassstrng2.png",
		"scifi_nodes_glassstrngsd3.png",
		"scifi_nodes_glassstrngsd3.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	use_texture_alpha = true,
	sunlight_propagates = true,
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.5, 0.3125, -0.25, 0.5}, -- NodeBox10
			{-0.0625, -0.5, -0.5, 0.0625, 0.5, 0.5}, -- NodeBox11
		}
	},
	groups = {cracky=1},
	on_place = minetest.rotate_node,
	sounds = default.node_sound_glass_defaults(),
})



minetest.register_node("scifi_nodes:capsule", {
	description = "sample capsule",
	tiles = {
		"scifi_nodes_capsule.png",
		"scifi_nodes_capsule.png",
		"scifi_nodes_box_top.png",
		"scifi_nodes_box_top.png",
		"scifi_nodes_capsule.png",
		"scifi_nodes_capsule.png"
	},
	use_texture_alpha = true,
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{0.3125, -0.5, -0.25, 0.5, 0, 0.25}, -- NodeBox1
			{-0.5, -0.5, -0.25, -0.3125, 0, 0.25}, -- NodeBox2
			{-0.3125, -0.4375, -0.1875, 0.3125, -0.0625, 0.1875}, -- NodeBox3
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
	on_rightclick = function(pos, node, clicker, item, _)
			minetest.set_node(pos, {name="scifi_nodes:capsule2", param2=node.param2})
	end,
})

minetest.register_node("scifi_nodes:capsule3", {
	description = "sample capsule",
	tiles = {
		"scifi_nodes_capsule3.png",
		"scifi_nodes_capsule3.png",
		"scifi_nodes_box_top.png",
		"scifi_nodes_box_top.png",
		"scifi_nodes_capsule3.png",
		"scifi_nodes_capsule3.png"
	},
	use_texture_alpha = true,
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{0.3125, -0.5, -0.25, 0.5, 0, 0.25}, -- NodeBox1
			{-0.5, -0.5, -0.25, -0.3125, 0, 0.25}, -- NodeBox2
			{-0.3125, -0.4375, -0.1875, 0.3125, -0.0625, 0.1875}, -- NodeBox3
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
	on_rightclick = function(pos, node, clicker, item, _)
			minetest.set_node(pos, {name="scifi_nodes:capsule", param2=node.param2})
	end,
})

minetest.register_node("scifi_nodes:capsule2", {
	description = "sample capsule",
	tiles = {
		"scifi_nodes_capsule2.png",
		"scifi_nodes_capsule2.png",
		"scifi_nodes_box_top.png",
		"scifi_nodes_box_top.png",
		"scifi_nodes_capsule2.png",
		"scifi_nodes_capsule2.png"
	},
	use_texture_alpha = true,
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{0.3125, -0.5, -0.25, 0.5, 0, 0.25}, -- NodeBox1
			{-0.5, -0.5, -0.25, -0.3125, 0, 0.25}, -- NodeBox2
			{-0.3125, -0.4375, -0.1875, 0.3125, -0.0625, 0.1875}, -- NodeBox3
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
	on_rightclick = function(pos, node, clicker, item, _)
			minetest.set_node(pos, {name="scifi_nodes:capsule3", param2=node.param2})
	end,
})

minetest.register_node("scifi_nodes:itemholder", {
	description = "item holder",
	tiles = {
		"scifi_nodes_box_top.png",
		"scifi_nodes_box_top.png",
		"scifi_nodes_box_top.png",
		"scifi_nodes_box_top.png",
		"scifi_nodes_box_top.png",
		"scifi_nodes_box_top.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.3125, 0.3125, -0.25, 0.3125}, -- NodeBox1
			{-0.0625, -0.5, 0.1875, 0.0625, -0.0625, 0.25}, -- NodeBox2
			{-0.0625, -0.5, -0.25, 0.0625, -0.0625, -0.1875}, -- NodeBox3
			{0.1875, -0.5, -0.0625, 0.25, -0.0625, 0.0625}, -- NodeBox4
			{-0.25, -0.5, -0.0625, -0.1875, -0.0625, 0.0625}, -- NodeBox5
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1},
	on_rightclick = function(pos, node, clicker, item, _)
		local wield_item = clicker:get_wielded_item():get_name()
		item:take_item()
		minetest.add_item(pos, wield_item)
	end,
})

minetest.register_node("scifi_nodes:glassscreen", {
	description = "glass screen",
	tiles = {
		"scifi_nodes_glscrn.png",
		"scifi_nodes_glscrn.png",
		"scifi_nodes_glscrn.png",
		"scifi_nodes_glscrn.png",
		"scifi_nodes_glscrn.png",
		"scifi_nodes_glscrn.png"
	},
	use_texture_alpha = true,
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = default.LIGHT_MAX,
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.125, 0.4375, -0.1875, 0.0625}, -- NodeBox1
			{-0.375, -0.5, -0.0625, 0.375, 0.5, 0}, -- NodeBox10
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
})


minetest.register_node("scifi_nodes:widescreen", {
	description = "widescreen",
	tiles = {
		"scifi_nodes_black.png",
		"scifi_nodes_black.png",
		"scifi_nodes_black.png",
		"scifi_nodes_black.png",
		"scifi_nodes_black.png",
		"scifi_nodes_widescreen.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	light_source = 5,
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.3125, 0.4375, 0.375, 0.3125, 0.5}, -- NodeBox1
			{-0.5, -0.375, 0.375, -0.375, 0.375, 0.5}, -- NodeBox2
			{0.375, -0.375, 0.375, 0.5, 0.375, 0.5}, -- NodeBox3
			{-0.3125, 0.25, 0.375, 0.3125, 0.375, 0.5}, -- NodeBox4
			{-0.3125, -0.375, 0.375, 0.25, -0.25, 0.5}, -- NodeBox5
			{-0.5, -0.3125, 0.375, 0.5, -0.25, 0.5}, -- NodeBox6
			{-0.5, 0.25, 0.375, 0.5, 0.3125, 0.5}, -- NodeBox7
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1}
})

minetest.register_node("scifi_nodes:tallscreen", {
	description = "tallscreen",
	tiles = {
		"scifi_nodes_black.png",
		"scifi_nodes_black.png",
		"scifi_nodes_black.png",
		"scifi_nodes_black.png",
		"scifi_nodes_black.png",
		"scifi_nodes_tallscreen.png"
	},
	drawtype = "nodebox",
	light_source = 5,
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.375, 0.4375, 0.3125, 0.375, 0.5}, -- NodeBox1
			{-0.375, 0.375, 0.375, 0.375, 0.5, 0.5}, -- NodeBox2
			{-0.375, -0.5, 0.375, 0.375, -0.375, 0.5}, -- NodeBox3
			{0.25, -0.3125, 0.375, 0.375, 0.3125, 0.5}, -- NodeBox4
			{-0.375, -0.25, 0.375, -0.25, 0.3125, 0.5}, -- NodeBox5
			{-0.3125, -0.5, 0.375, -0.25, 0.5, 0.5}, -- NodeBox6
			{0.25, -0.5, 0.375, 0.3125, 0.5, 0.5}, -- NodeBox7
		}
	},
	groups = {cracky=1, oddly_breakable_by_hand=1}
})