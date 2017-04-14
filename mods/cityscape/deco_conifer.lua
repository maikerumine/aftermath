-------------------
-- Conifer Trees --
-------------------

-- Create different colored needles with the same properties.
newnode = cityscape.clone_node("default:pine_needles")
if cityscape.noleafdecay then
	newnode.groups.leafdecay = 0
end
newnode.tiles = {"default_pine_needles.png^[colorize:#FF0000:20"}
minetest.register_node("cityscape:pine_needles2", newnode)
newnode.tiles = {"default_pine_needles.png^[colorize:#FFFF00:20"}
minetest.register_node("cityscape:pine_needles3", newnode)
newnode.tiles = {"default_pine_needles.png^[colorize:#00FF00:20"}
minetest.register_node("cityscape:pine_needles4", newnode)

if cityscape.glow then
	minetest.register_node("cityscape:pine_tree_glowing_moss", {
		description = "Pine tree with glowing moss",
		tiles = {"default_pine_tree_top.png", "default_pine_tree_top.png",
		"default_pine_tree.png^trunks_moss.png"},
		paramtype2 = "facedir",
		is_ground_content = false,
		light_source = 4,
		drop = 'default:pine_tree',
		groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
		sounds = default.node_sound_wood_defaults(),

		on_place = minetest.rotate_node
	})
end


-- similar to the general tree schematic, but basically vertical
function cityscape.generate_conifer_schematic(trunk_height, radius, trunk, leaf)
	local height = trunk_height + radius * 3 + 2
	local width = 2 * radius + 1
	local trunk_top = height - radius - 1
	local s = cityscape.schematic_array(width, height, width)

	-- the main trunk
	local probs = {200,150,100,75,50,25}
	for z = -radius,radius do
		for y = 1,trunk_top do
			-- Gives it a vaguely conical shape.
			local r1 = math.ceil((height - y) / 4)
			-- But rounded at the bottom.
			if y == trunk_height + 1 then
				r1 = r1 -1 
			end

			for x = -radius,radius do
				local i = (z+radius)*width*height + y*width + (x+radius) + 1
				local dist = math.floor(math.sqrt(x^2 + z^2 + 0.5))
				if x == 0 and z == 0 then
					if trunk == "default:pine_tree" and cityscape.glow and math.random(1,10) == 1 then
						s.data[i].name = "cityscape:pine_tree_glowing_moss"
					else
						s.data[i].name = trunk
					end
					s.data[i].param1 = 255
					s.data[i].force_place = true
				elseif y > trunk_height and dist <= r1 then
					s.data[i].name = leaf
					s.data[i].param1 = probs[dist]
				end
			end
		end
	end

	-- leaves at the top
	for z = -1,1 do
		for y = trunk_top, height-1 do
			for x = -1,1 do
				local i = (z+radius)*width*height + y*width + (x+radius) + 1
				if (x == 0 and z == 0) or y < height - 1 then
					s.data[i].name = leaf
					if x == 0 and z == 0 then
						s.data[i].param1 = 255
					else
						s.data[i].param1 = 200
					end
				end
			end
		end
	end

	return s
end


-- the default pine schematic
function cityscape.generate_default_conifer_schematic(trunk, leaf)
	local height = 13 + 1
	local width = 5
	local s = cityscape.schematic_array(width, height, width)

	-- the main trunk
	local probs = {255,220,190}

	for p = 0,2 do
		local c = math.floor(width / 2)
		local y = height - p * 3 - 1
		for r = 0,2 do
			for z = c-r,c+r do
				for x = c-r,c+r do
					local i = z*width*height + (y-r)*width + x + 1
					s.data[i].name = leaf
					s.data[i].param1 = probs[r]
				end
			end
		end

		s.yslice_prob = {}
		for y = 1,height-3 do
			local i = 2*width*height + y*width + 2 + 1
			if trunk == "default:pine_tree" and cityscape.glow and math.random(1,10) == 1 then
				s.data[i].name = "cityscape:pine_tree_glowing_moss"
			else
				s.data[i].name = trunk
			end

			s.data[i].param1 = 255
			s.data[i].force_place = true

			local j = (height - y - 1) / 3
			if j == 0 or j == 1 or j == 2 or y <= height - 11 then
				s.yslice_prob[#s.yslice_prob+1] = {ypos=y,prob=170}
			end
		end
	end

	return s
end


-- generic conifers
cityscape.schematics.conifer_trees = {}
leaves = {"default:pine_needles", "cityscape:pine_needles2", "cityscape:pine_needles3", "cityscape:pine_needles4"}
for i = 1,#leaves do
	local max_r = 4
	for r = 2,max_r do
		local schem = cityscape.generate_conifer_schematic(2, r, "default:pine_tree", leaves[i])

		cityscape.schematics.conifer_trees[#cityscape.schematics.conifer_trees+1] = schem

		--minetest.register_decoration({
		--	deco_type = "schematic",
		--	sidelen = 80,
		--	place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
		--	fill_ratio = (max_r-r+1)/500,
		--	biomes = {"coniferous_forest", "taiga",},
		--	schematic = schem,
		--	flags = "place_center_x, place_center_z",
		--	y_min = 2,
		--	rotation = "random",
		--})
	end
end


if false then
	-- generic conifers
	cityscape.schematics.conifer_trees = {}
	leaves = {"default:pine_needles", "cityscape:pine_needles2", "cityscape:pine_needles3", "cityscape:pine_needles4"}
	for i = 1,#leaves do
		local schem = cityscape.generate_default_conifer_schematic("default:pine_tree", leaves[i])

		cityscape.schematics.conifer_trees[#cityscape.schematics.conifer_trees+1] = schem

		minetest.register_decoration({
			deco_type = "schematic",
			sidelen = 80,
			place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
			fill_ratio = 6/500,
			biomes = {"coniferous_forest", "taiga",},
			schematic = schem,
			flags = "place_center_x, place_center_z",
			y_min = 2,
			rotation = "random",
		})
	end
end
--[[
-- Place the schematic when a sapling grows.
function default.grow_new_pine_tree(pos, bad)
	local schem = cityscape.schematics.conifer_trees[math.random(1,#cityscape.schematics.conifer_trees)]
	local adj = {x = pos.x - math.floor(schem.size.x / 2),
	             y = pos.y - 1,
	             z = pos.z - math.floor(schem.size.z / 2)}
	minetest.place_schematic(adj, schem, 'random', nil, true)
end
]]
