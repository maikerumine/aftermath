
--[[

Copyright (C) 2015 - Auke Kok <sofar@foo-projects.org>

"crops" is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation; either version 2.1
of the license, or (at your option) any later version.

--]]

--
-- Builtin sky box textures and color/shadings
--

local skies = {
	{"DarkStormy", "#1f2226", 0.5},
	{"CloudyLightRays", "#5f5f5e", 0.9},
	{"FullMoon", "#24292c", 0.2},
	{"SunSet", "#72624d", 0.4},
	{"ThickCloudsWater", "#a57850", 0.8},
	{"TropicalSunnyDay", "#f1f4ee", 1.0},
}

--
-- API
--

skybox = {}

skybox.set = function(player, number)
	local sky = skies[number]
	player:override_day_night_ratio(sky[3])
	player:set_sky(sky[2], "skybox", {
		sky[1] .. "Up.jpg",
		sky[1] .. "Down.jpg",
		sky[1] .. "Front.jpg",
		sky[1] .. "Back.jpg",
		sky[1] .. "Left.jpg",
		sky[1] .. "Right.jpg",
	})
	player:set_attribute("skybox:skybox", sky[1])
end

skybox.add = function(def)
	table.add(skies, def)
end

skybox.clear = function(player)
	player:override_day_night_ratio(nil)
	player:set_sky("white", "regular")
	player:set_attribute("skybox:skybox", "off")
end

--
-- registrations and load/save code
--

minetest.register_on_joinplayer(function(player)
	local sky = player:get_attribute("skybox:skybox")
	print(dump(sky))
	if not sky or sky == "" then
		skybox.clear(player)
	else
	print(dump(skies))
		for k, v in ipairs(skies) do
		print(dump(v))
			if sky == v[1] then
				skybox.set(player, k)
				return
			end
		end
		skybox.clear(player)
	end
end)

minetest.register_privilege("skybox", {
	description = "Change sky box for yourself",
})

minetest.register_chatcommand("skybox", {
	params = "<skybox> or <number> or \"off\" or empty to list skyboxes",
	description = "Change your sky box set",
	privs = "skybox",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then
			return
		end
		if param == nil or param == "" then
			minetest.chat_send_player(name, "Available sky boxes:")
			for _, v in ipairs(skies) do
				minetest.chat_send_player(name, 
						v[1])
			end
			return
		elseif tonumber(param) ~= nil and tonumber(param) >= 1 and tonumber(param) <= table.getn(skies) then
			skybox.set(player, tonumber(param))
			return
		elseif param == "off" then
			skybox.clear(player)
			return
		end
		for k, v in ipairs(skies) do
			if v[1] == param then
				skybox.set(player, k)
				return
			end
		end
		minetest.chat_send_player(name,
				"Could not find that sky box.")
	end
})
