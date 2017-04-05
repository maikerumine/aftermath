--some code taken from moreblocks(the collision and selection boxes), license below:
--Copyright (c) 2011-2015 Calinou and contributors.
--Licensed under the zlib license.

scifi_nodes = {}

function scifi_nodes.register_slope(name, desc, texture, light)
minetest.register_node("scifi_nodes:slope_"..name, {
	description = desc.." Slope",
	sunlight_propagates = false,
	drawtype = "mesh",
	mesh = "moreblocks_slope.obj",
	tiles = texture,
		selection_box = {
			type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5, 0.5, -0.25, 0.5},
		{-0.5, -0.25, -0.25, 0.5,     0, 0.5},
		{-0.5,     0,     0, 0.5,  0.25, 0.5},
		{-0.5,  0.25,  0.25, 0.5,   0.5, 0.5}
	}
		},
		collision_box = {
			type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5, 0.5, -0.25, 0.5},
		{-0.5, -0.25, -0.25, 0.5,     0, 0.5},
		{-0.5,     0,     0, 0.5,  0.25, 0.5},
		{-0.5,  0.25,  0.25, 0.5,   0.5, 0.5}
	}
		},
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = light,
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
	on_place = minetest.rotate_node
})
end

scifi_nodes.register_slope("black", "black", {"scifi_nodes_black.png",}, 0)
scifi_nodes.register_slope("white", "white", {"scifi_nodes_white.png",}, 0)
scifi_nodes.register_slope("grey", "grey", {"scifi_nodes_grey.png",}, 0)
scifi_nodes.register_slope("blue", "blue", {"scifi_nodes_bluebars.png",}, 0)
scifi_nodes.register_slope("mesh", "mesh", {"scifi_nodes_mesh2.png",}, 0)
scifi_nodes.register_slope("vent", "vent", {"scifi_nodes_vent2.png",}, 0)
scifi_nodes.register_slope("rlight", "red light", {"scifi_nodes_redlight.png",}, 0)
scifi_nodes.register_slope("blight", "blue light", {"scifi_nodes_light.png",}, 0)
scifi_nodes.register_slope("glight", "green light", {"scifi_nodes_greenlight.png",}, 0)
scifi_nodes.register_slope("holes", "holes", {"scifi_nodes_holes.png",}, 0)
scifi_nodes.register_slope("pipe", "pipe", {"scifi_nodes_pipe.png",}, 0)
scifi_nodes.register_slope("stripes", "stripes", {"scifi_nodes_stripes.png",}, 0)
scifi_nodes.register_slope("screen", "screen", {"scifi_nodes_screen3.png",}, 5)
scifi_nodes.register_slope("lightstripe", "lightstripe", {"scifi_nodes_lightstripe.png",}, 14)
scifi_nodes.register_slope("blight2", "blue light 2", {"scifi_nodes_capsule3.png",}, 14)