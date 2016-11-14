local player_hud = { };

local timer = 0;
local positionx = 0.97;
local positiony = 0.02;
local last_time = os.time()


local function floormod ( x, y )
	return (math.floor(x) % y);
end

local function get_time ( )
	local secs = (60*60*24*minetest.get_timeofday());
	local s = floormod(secs, 60);
	local m = floormod(secs/60, 60);
	local h = floormod(secs/3600, 60);
	return ("%02d:%02d"):format(h, m);
end

minetest.register_globalstep(function ( dtime )
	timer = timer + dtime;
	if os.time() >= last_time then
		last_time = os.time() + 1
		if (timer >= 1.0) then
			timer = 0;
			for _,p in ipairs(minetest.get_connected_players()) do
					local name = p:get_player_name();
					local h = p:hud_add({
						hud_elem_type = "text";
						position = {x=positionx, y=positiony};
						text = get_time();
						number = 0xFFFFFF;
					});
					local g = p:hud_add({
						hud_elem_type = "image",
						position = {x=positionx, y=positiony},
						offset = {x=-30, y=0},
						scale = {x=1, y=1},
						text = "mthudclock.png",
					});
					if (player_hud[name]) then
						p:hud_remove(player_hud[name]);
					end
					player_hud[name] = h;
					--player_hud[name] = g;
			end
		end
	end
end);
-- minetest.register_chatcommand("hcr", {
-- 	params = "",
-- 	description = "This should reset your hudclock.",
-- 	func = function(name, param)
-- 		local player = minetest.get_player_by_name(name)
-- 		if not player then
-- 			return
-- 		end
-- 		player:hud_remove(player_hud[name]);
-- 		player_hud[name] = nil
-- 	end,
-- })

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if player_hud[name] ~= nil then
		player:hud_remove(player_hud[name]);
		player_hud[name] = nil
	end
	return true
end)
