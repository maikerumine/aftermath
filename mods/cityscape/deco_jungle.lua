------------------
-- Jungle Trees --
------------------

-- Create different colored leaves with the same properties.

newnode = cityscape.clone_node("default:jungleleaves")
newnode.tiles = {"default_jungleleaves.png^[colorize:#FF0000:10"}
minetest.register_node("cityscape:jungleleaves2", newnode)
newnode.tiles = {"default_jungleleaves.png^[colorize:#FFFF00:30"}
minetest.register_node("cityscape:jungleleaves3", newnode)


-- Create a schematic for a jungle tree.
function cityscape.generate_jungle_tree_schematic(trunk_height, trunk, leaf)
	local height = trunk_height * 2 + 1
	local radius = 6
	local width = 2 * radius + 1
	local trunk_top = height - 4

	local s = cityscape.schematic_array(width, height, width)

	-- roots, trunk, and extra leaves
	for z = -1,1 do
		for y = 1,trunk_top do
			for x = -1,1 do
				local i = (z+radius)*width*height + y*width + (x+radius) + 1
				if x == 0 and z == 0 then
					s.data[i].name = trunk
					s.data[i].param1 = 255
					s.data[i].force_place = true
				elseif (x == 0 or z == 0) and y < 3 then
					s.data[i].name = trunk
					s.data[i].param1 = 255
					s.data[i].force_place = true
				elseif y > 3 then
					s.data[i].name = leaf
					s.data[i].param1 = 50
				end
			end
		end
	end

	-- canopies
	for y = 1,trunk_top+2 do
		if y > trunk_height and (y == trunk_top or math.random(1,height - y) == 1) then
			local x, z = 0, 0
			while x == 0 and z == 0 do
				x = math.random(-1,1) * 2
				z = math.random(-1,1) * 2
			end
			for j = -1,1,2 do
				local i = (j*z + radius)*width*height + y*width + (j*x + radius) + 1
				s.data[i].name = trunk
				s.data[i].param1 = 255
				s.data[i].force_place = true
				cityscape.generate_canopy(s, leaf, {x=j*x, y=y, z=j*z})
			end
		end
	end

	return s
end

-- Create a canopy of leaves.
function cityscape.generate_canopy(s, leaf, pos)
	local height = s.size.y
	local width = s.size.x
	local rx = math.floor(s.size.x / 2)
	local rz = math.floor(s.size.z / 2)
	local r1 = 4  -- leaf decay radius
	local probs = {255,200,150,100,75}

	for z = -r1,r1 do
		for y = 0,1 do
			for x = -r1,r1 do
				if x+pos.x >= -rx and x+pos.x <= rx and y+pos.y >= 0 and y+pos.y < height and z+pos.z >= -rz and z+pos.z <= rz then
					local i = (z+pos.z+rz)*width*height + (y+pos.y)*width + (x+pos.x+rx) + 1
					local dist1 = math.sqrt(x^2 + y^2 + z^2)
					local dist2 = math.sqrt((x+pos.x)^2 + (z+pos.z)^2)
					if dist1 <= r1 then
						local newprob = probs[math.max(1, math.ceil(dist1))]
						if s.data[i].name == "air" then
							s.data[i].name = leaf
							s.data[i].param1 = newprob
						elseif s.data[i].name == leaf then
							s.data[i].param1 = math.max(s.data[i].param1, newprob)
						end
					end
				end
			end
		end
	end
end

-- generic jungle trees
cityscape.schematics.jungle_trees = {}
leaves = {"default:jungleleaves", "cityscape:jungleleaves2", "cityscape:jungleleaves3"}
for i = 1,#leaves do
	local max_h = 7
	for h = 5,max_h do
		local schem = cityscape.generate_jungle_tree_schematic(h*2, "default:jungletree", leaves[i])

		cityscape.schematics.jungle_trees[#cityscape.schematics.jungle_trees+1] = schem

		--minetest.register_decoration({
		--	deco_type = "schematic",
		--	sidelen = 80,
		--	place_on = {"default:dirt_with_grass", "default:dirt"},
		--	fill_ratio = (max_h-h+1)/1200,
		--	biomes = {"rainforest", "rainforest_swamp",},
		--	schematic = schem,
		--	flags = "place_center_x, place_center_z",
		--	y_min = 0,
		--	rotation = "random",
		--})
	end
end
--[[
-- Place the schematic when a sapling grows.
function default.grow_new_jungle_tree(pos, bad)
	local schem = cityscape.schematics.jungle_trees[math.random(1,#cityscape.schematics.jungle_trees)]
	local adj = {x = pos.x - math.floor(schem.size.x / 2),
	             y = pos.y - 1,
	             z = pos.z - math.floor(schem.size.z / 2)}
	minetest.place_schematic(adj, schem, 'random', nil, true)
end
]]
