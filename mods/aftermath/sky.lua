
aftermath = {}

local path = minetest.get_modpath("aftermath")

    --Version 0.2
    --by emperor_genshin
    --modified for ESM game by: maikerumine
    --https://forum.minetest.net/viewtopic.php?f=9&t=13775&hilit=[mod]skybox


    --The skybox for space, feel free to change it to however you like.
	    local spaceskybox = {
	    "sky_pos_y.png",
	    "sky_neg_y.png",
	    "sky_pos_z.png",
	    "sky_neg_z.png",
	    "sky_neg_x.png",
	    "sky_pos_x.png",
	    }

	local time = 0

minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time > 5 then for _, player in ipairs(minetest.get_connected_players()) do
	time = 0

	local name = player:get_player_name()
	local sky = player:get_attribute("skybox:skybox")--ADDED SKYBOX

	       if minetest.get_player_by_name(name) then
			--player:set_sky({}, "skybox", spaceskybox) -- Sets skybox
			skybox.set(player, 1)--ADDED SKYBOX
		end
	end
	end
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()

	if name then
		player:set_sky({}, "regular", {})

		end
	end)
	
	