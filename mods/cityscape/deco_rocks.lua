----------------------
-- Decorative Rocks --
----------------------

-- I'm feeling a bit zen...

-- Place a small nodebox.
local function small_cube(grid, pos, diameters)
	local rock = {}

	rock[1] = pos.x
	rock[2] = pos.y
	rock[3] = pos.z
	rock[4] = pos.x + diameters.x
	rock[5] = pos.y + diameters.y
	rock[6] = pos.z + diameters.z
	grid[#grid+1] = rock
end


-- Create some tiles of small rocks that can be picked up.
local default_grid
--local tiles = {"default_stone.png", "default_desert_stone.png", "default_sandstone.png"}
local tiles = {"default_stone.png"}

for grid_count = 1,6 do
	local grid = {}
	for rock_count = 2, math.random(1,4) + 1 do
		local diameter = math.random(5,15)/100
		local x = math.random(1,80)/100 - 0.5
		local z = math.random(1,80)/100 - 0.5
		--step_sphere(grid, {x=x,y=-0.5,z=z}, {x=diameter, y=diameter, z=diameter})
		small_cube(grid, {x=x,y=-0.5,z=z}, {x=diameter, y=diameter, z=diameter})
	end

	--local stone = tiles[math.random(1,#tiles)]
	local stone = tiles[(grid_count % #tiles) + 1]

	minetest.register_node("cityscape:small_rocks"..grid_count, {
		description = "Small Rocks",
		tiles = {stone},
		is_ground_content = true,
		walkable = false,
		paramtype = "light",
		paramtype2 = "facedir",
		drawtype = "nodebox",
		buildable_to = true,
		node_box = { type = "fixed", 
								 fixed = grid },
		selection_box = { type = "fixed", 
											fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
										},
		groups = {stone=1, oddly_breakable_by_hand=3},
		drop = "cityscape:small_rocks",
		on_place = minetest.rotate_node,
		sounds = default.node_sound_stone_defaults(),
	})

	default_grid = grid
end

-- This is the inventory item, so we don't have six different stacks.
minetest.register_node("cityscape:small_rocks", {
	description = "Small Rocks",
	tiles = {"default_stone.png"},
	inventory_image = "vmg_small_rocks.png",
	is_ground_content = true,
	walkable = false,
	paramtype = "light",
	drawtype = "nodebox",
	node_box = { type = "fixed", 
							 fixed = default_grid },
	selection_box = { type = "fixed", 
										fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
									},
	groups = {stone=1, oddly_breakable_by_hand=3},
	sounds = default.node_sound_stone_defaults(),
})


-- Small rocks can be used to create cobblestone, if you like.
minetest.register_craft({
	output = "default:cobble",
	recipe = {
		{"", "", ""},
		{"cityscape:small_rocks", "cityscape:small_rocks", ""},
		{"cityscape:small_rocks", "cityscape:small_rocks", ""},
	},
})

