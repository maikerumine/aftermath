--mobs_fallout v0.0.4
--maikerumine
--made for Nuclear_Holocaust game

local path = minetest.get_modpath("mobs_fallout")

dofile(minetest.get_modpath("mobs_fallout").."/esnpc.lua")
dofile(minetest.get_modpath("mobs_fallout").."/esbadplayer.lua")
dofile(minetest.get_modpath("mobs_fallout").."/esanimal.lua")
dofile(minetest.get_modpath("mobs_fallout").."/crafts.lua")
dofile(minetest.get_modpath("mobs_fallout").."/crossfire.lua")

--IN CASE BONES IS NOT INSTALLED, THIS OVERRIDES NODES SO YOU HAVE THEM FOR MOBS.
if not bones then
	dofile(minetest.get_modpath("mobs_fallout").."/bones.lua")
		minetest.register_alias("bones:bones", "mobs_fallout:bones")
	end
	if bones then
		minetest.register_alias("mobs_fallout:bones", "bones:bones")
	end

if minetest.setting_get("log_mods") then
	minetest.log("action", "mobs_fallout mobs loaded")
end
