-----------
-- Trees --
-----------

-- Change leafdecay ratings
minetest.add_group("default:leaves", {leafdecay = 4})
minetest.add_group("default:jungleleaves", {leafdecay = 4})
minetest.add_group("default:pine_needles", {leafdecay = 5})


-- tree creation code
dofile(cityscape.path.."/deco_deciduous.lua")
dofile(cityscape.path.."/deco_conifer.lua")
dofile(cityscape.path.."/deco_jungle.lua")
