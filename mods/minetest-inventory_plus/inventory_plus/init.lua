--[[

Inventory Plus for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-inventory_plus
License: BSD-3-Clause https://raw.github.com/cornernote/minetest-inventory_plus/master/LICENSE

]]--


-- expose api
inventory_plus = {}

-- define buttons
inventory_plus.buttons = {}

-- default inventory page
inventory_plus.default = minetest.setting_get("inventory_default") or "craft"

-- register_button
inventory_plus.register_button = function(player,name,label)
	local player_name = player:get_player_name()
	if inventory_plus.buttons[player_name] == nil then
		inventory_plus.buttons[player_name] = {}
	end
	inventory_plus.buttons[player_name][name] = label
end

-- set_inventory_formspec
inventory_plus.set_inventory_formspec = function(player,formspec)
	if minetest.setting_getbool("creative_mode") then
		-- if creative mode is on then wait a bit
		minetest.after(0.01,function()
			player:set_inventory_formspec(formspec)
		end)
	else
		player:set_inventory_formspec(formspec)
	end
end

-- get_formspec
inventory_plus.get_formspec = function(player,page)
	--if not player then
	--	return
	--end
	
	local formspec = "size[8,7.5]"
	
	-- player inventory
	formspec = formspec .. "list[current_player;main;0,3.5;8,4;]"

	-- craft page
	if page=="craft" then
		formspec = formspec
			.."button[0,0;2,0.5;main;Back]"
			.."list[current_player;craftpreview;7,1;1,1;]"
		if minetest.setting_getbool("inventory_craft_small") then
			formspec = formspec.."list[current_player;craft;3,0;2,2;]"
			--player:get_inventory():set_width("craft", 2)
			--player:get_inventory():set_size("craft", 2*2)
		else
			formspec = formspec.."list[current_player;craft;3,0;3,3;]"
			--player:get_inventory():set_width("craft", 3)
			--player:get_inventory():set_size("craft", 3*3)
		end
	end
	
	-- creative page
	if page=="creative" then
		return player:get_inventory_formspec()
			.."button[5,0;2,0.5;main;Back]"
	end
	
	-- main page
	if page=="main" then
		-- buttons
		local x,y=0,0
		for k,v in pairs(inventory_plus.buttons[player:get_player_name()]) do
			formspec = formspec .. "button["..x..","..y..";2,0.5;"..k..";"..v.."]"
			x=x+2
			if x == 8 then
				x=0
				y=y+1
			end
		end
	end
	
	return formspec
end

-- register_on_joinplayer
minetest.register_on_joinplayer(function(player)
	if minetest.setting_getbool("inventory_craft_small") then
		player:get_inventory():set_width("craft", 2)
		player:get_inventory():set_size("craft", 2*2)
	else
		player:get_inventory():set_width("craft", 3)
		player:get_inventory():set_size("craft", 3*3)
	end
	inventory_plus.register_button(player,"craft","Craft")
	if minetest.setting_getbool("creative_mode") then
		inventory_plus.register_button(player,"creative_prev","Creative")
	end
	minetest.after(1,function()
		inventory_plus.set_inventory_formspec(player,inventory_plus.get_formspec(player, inventory_plus.default))
	end)
end)

-- register_on_player_receive_fields
minetest.register_on_player_receive_fields(function(player, formname, fields)
	-- main
	if fields.main then
		inventory_plus.set_inventory_formspec(player, inventory_plus.get_formspec(player,"main"))
		return
	end
	-- craft
	if fields.craft then
		inventory_plus.set_inventory_formspec(player, inventory_plus.get_formspec(player,"craft"))
		return
	end
	-- creative
	if fields.creative_prev or fields.creative_next then
		minetest.after(0.1,function()
			inventory_plus.set_inventory_formspec(player, inventory_plus.get_formspec(player,"creative"))
		end)
		return
	end
end)
