-----------------
-- Decorations --
-----------------

-- The main decoration handler, through the game's decoration manager.


function table.contains_substring(t, s)
	if type(s) ~= "string" then
		return nil
	end

  for key, value in pairs(t) do
    if type(value) == 'string' and s:find(value) then
			if key then
				return key
			else
				return true
			end
    end
  end
  return false
end


-- Copy all the decorations except the ones I don't like.
--  This is currently used to remove the default trees.
local bad_deco = {"apple_tree", "pine_tree", "jungle_tree", "acacia_tree", "aspen_tree", }
local decos = {}
for id, deco_table in pairs(minetest.registered_decorations) do
	if type(deco_table.schematic) ~= "string" or not table.contains_substring(bad_deco, deco_table.schematic) then
		table.insert(decos, deco_table)
	end
end


-- Create and initialize a table for a schematic.
function cityscape.schematic_array(width, height, depth)
	-- Dimensions of data array.
	local s = {size={x=width, y=height, z=depth}}
	s.data = {}

	for z = 0,depth-1 do
		for y = 0,height-1 do
			for x = 0,width-1 do
				local i = z*width*height + y*width + x + 1
				s.data[i] = {}
				s.data[i].name = "air"
				s.data[i].param1 = 000
			end
		end
	end

	s.yslice_prob = {}

	return s
end


-- Clear all decorations, so I can place the new trees.
--minetest.clear_registered_decorations()  --supressed to keep old trees

-- A list of all schematics, for re-use.
cityscape.schematics = {}


dofile(cityscape.path.."/deco_trees.lua")


-- Re-register the good decorations.
-- This has to be done after registering the trees or
--  the trees spawn on top of grass.  /shrug
for _, i in pairs(decos) do
	minetest.register_decoration(i)
end
