beds = {}
--beds.player = {}
--beds.pos = {}
--beds.spawn = {}

beds.player_spawns = {} --allowed to save to file
beds.player_pos = {}    --primary used

beds.player_sleeping = {}
beds.player_sleeping_count = 0

local is_sp = minetest.is_singleplayer() or false
local form = 	"size[8,15;true]"..
		"bgcolor[#080808BB; true]"..
		"button_exit[2,12;4,0.75;leave;Leave Bed]"


-- help functions

local function get_look_yaw(pos)
	local n = minetest.get_node(pos)
	if n.param2 == 1 then
		return 7.9, n.param2
	elseif n.param2 == 3 then
		return 4.75, n.param2
	elseif n.param2 == 0 then
		return 3.15, n.param2
	else
		return 6.28, n.param2
	end
end


local function check_in_beds()
    
    local players_count = #minetest.get_connected_players()
    if beds.player_sleeping_count > (players_count/2) then
        return true
    else
        return false
    end
end

function beds.stand_up(name)
	if beds.player_sleeping[name] ~= nil then
		beds.player_sleeping[name] = nil
		beds.player_sleeping_count = beds.player_sleeping_count - 1
        local player = minetest.get_player_by_name(name)
        if player and player:is_player() then
            -- physics, eye_offset, etc
            player:set_eye_offset({x=0,y=0,z=0}, {x=0,y=0,z=0})
            player:set_look_yaw(math.random(1, 180)/100)
            default.player_attached[name] = false
            player:set_physics_override(1, 1, 1)
            local hud_flags = player:hud_get_flags()
            hud_flags.wielditem = true
            player:hud_set_flags(hud_flags)
            default.player_set_animation(player, "stand" , 30)
        end
	end
end

function beds.lay_down(name, pos)
    if beds.player_sleeping[name] == nil then
        beds.player_sleeping[name] = pos
        beds.player_sleeping_count = beds.player_sleeping_count + 1
        local player = minetest.get_player_by_name(name)
        if player and player:is_player() then
            -- physics, eye_offset, etc
            player:set_eye_offset({x=0,y=-13,z=0}, {x=0,y=0,z=0})
            local yaw, param2 = get_look_yaw(pos)
            player:set_look_yaw(yaw)
            local dir = minetest.facedir_to_dir(param2)
            local p = {x=pos.x+dir.x/2,y=pos.y,z=pos.z+dir.z/2}
            player:setpos(p)
            player:set_physics_override(0, 0, 0)
            default.player_attached[name] = true
            local hud_flags = player:hud_get_flags()
            hud_flags.wielditem = false
            player:hud_set_flags(hud_flags)
            default.player_set_animation(player, "lay" , 0)
        end
    end
end

local function update_formspecs(finished)
	local ges = #minetest.get_connected_players()
	local form_n = ""
	local is_majority = (ges/2) < beds.player_sleeping_count

	if finished then
		form_n = form ..
			"label[2.7,11; Good morning.]"
	else
		form_n = form ..
			"label[2.2,11;"..tostring(beds.player_sleeping_count).." of "..tostring(ges).." players are in bed]"	
		if is_majority then
			form_n = form_n ..
				"button_exit[2,8;4,0.75;force;Force night skip]"
		end
	end

	for name,_ in pairs(beds.player_sleeping) do
		minetest.show_formspec(name, "beds_form", form_n)
	end
end


-- public functions

function beds.kick_players()
	for name,pos in pairs(beds.player_sleeping) do
		beds.stand_up(name)
	end
end

function beds.on_rightclick(pos, player)
	local name = player:get_player_name()
	local tod = minetest.get_timeofday()
    local meta = minetest.get_meta(pos)
    local owner = meta:get_string("owner")
    
    --return always string??!
    if owner == "" then
        owner = nil
    end

    if owner and owner~=name then
		beds.stand_up(name)
		minetest.chat_send_player(name, "This bed is not yours.")
		return
    end

	if tod > 0.2 and tod < 0.805 then
		beds.stand_up(name)
		minetest.chat_send_player(name, "You can only sleep at night.")
		return
	end

    --temporaryly set this bed as spawn for player
    beds.player_pos[name] = pos
    
    --make bed private
    if not owner then
        meta:set_string("owner", name or nil)
        meta:set_string("infotext", name.."'s bed")
    end
    
	-- move to bed
    beds.lay_down(name, pos)

	update_formspecs(false)

	-- skip the night and let all stand up
	if check_in_beds() then
		minetest.after(0, function()
            beds.set_spawns()
			beds.kick_players()
			update_formspecs(true)
            minetest.set_timeofday(0.23)
		end)
	end
end


-- callbacks
minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
    beds.stand_up(name)
	if check_in_beds() then
		minetest.after(0, function()
            beds.set_spawns()
            beds.kick_players()
            update_formspecs(true)
            minetest.set_timeofday(0.23)
		end)
	end
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "beds_form" then
		return
	end
    local name = player:get_player_name()
	if fields.quit or fields.leave then
        beds.stand_up(name)
		update_formspecs(false)
	elseif fields.force then
        beds.set_spawns()
        beds.kick_players()
        update_formspecs(true)
        minetest.set_timeofday(0.23)
	end
end)

minetest.register_on_respawnplayer(function(player)
	local name = player:get_player_name()
	local pos = beds.player_pos[name] or nil
	if pos then
        local player_pos = player:getpos()
        if math.abs(pos.x - player_pos.x) < 10 and math.abs(pos.z - player_pos.z) < 10 and math.abs(pos.y - player_pos.y) < 300 then
               --bed dont work if too close. Moustly needed for servers, where bone farming needs to be prevented
        else
            player:setpos(pos)
            --remove spawn, if bed was removed there
            minetest.after(4, function(name)
                local pos = beds.player_pos[name] or nil
                if pos then
                    local bed = minetest.get_node(pos)
                    if bed.name~="ignore" then
                        if not ( bed.name=="beds:fancy_bed_bottom" or bed.name=="beds:fancy_bed_top" or
                           bed.name=="beds:bed_bottom" or bed.name=="beds:bed_top") then
                           beds.player_pos[name]=nil
                           beds.player_spawns[name]=nil
                           minetest.chat_send_player(name, "Your bed is lost.")
                        end
                    end
                end
            end,
            name)
            return true
        end
	end
end)


-- nodes and respawn function
dofile(minetest.get_modpath("beds").."/nodes.lua")
dofile(minetest.get_modpath("beds").."/spawns.lua")
