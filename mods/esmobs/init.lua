--esmobs v0.0.4
--maikerumine
--made for Extreme Survival game


--dofile(minetest.get_modpath("esmobs").."/esconfig.lua")

dofile(minetest.get_modpath("esmobs").."/api.lua")
--dofile(minetest.get_modpath("esmobs").."/chickoboo.lua")
dofile(minetest.get_modpath("esmobs").."/esnpc.lua")
--dofile(minetest.get_modpath("esmobs").."/esmonster.lua")
dofile(minetest.get_modpath("esmobs").."/esbadplayer.lua")
dofile(minetest.get_modpath("esmobs").."/esanimal.lua")
dofile(minetest.get_modpath("esmobs").."/crafts.lua")
--dofile(minetest.get_modpath("esmobs").."/dirt.lua")
--dofile(minetest.get_modpath("esmobs").."/icemob.lua")
--dofile(minetest.get_modpath("esmobs").."/nicemob.lua")
--dofile(minetest.get_modpath("esmobs").."/crossfire.lua")

--dofile(minetest.get_modpath("esmobs").."/spawner.lua")

--IF ES IS LOADED YOU WILL SEE OTHER MOBS HOLDING THE SPECIAL TOOLS
if es then
	dofile(minetest.get_modpath("esmobs").."/esnpc2.lua")
end

--IN CASE BONES IS NOT INSTALLED, THIS OVERRIDES NODES SO YOU HAVE THEM FOR MOBS.
if not bones then
	dofile(minetest.get_modpath("esmobs").."/bones.lua")
		minetest.register_alias("bones:bones", "esmobs:bones")
	end
	if bones then
		minetest.register_alias("esmobs:bones", "bones:bones")
	end

if minetest.setting_get("log_mods") then
	minetest.log("action", "esmobs mobs loaded")
end
