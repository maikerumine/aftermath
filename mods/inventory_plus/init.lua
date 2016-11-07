--[[

Inventory Plus for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-inventory_plus
License: BSD-3-Clause https://raw.github.com/cornernote/minetest-inventory_plus/master/LICENSE

Edited by TenPlus1 (23rd March 2016)

]]--

-- expose api
inventory_plus = {}

-- define buttons
inventory_plus.buttons = {}

-- default inventory page
inventory_plus.default = minetest.setting_get("inventory_default") or "craft"

-- register_button
inventory_plus.register_button = function(player, name, label)

	local player_name = player:get_player_name()

	if inventory_plus.buttons[player_name] == nil then
		inventory_plus.buttons[player_name] = {}
	end

	inventory_plus.buttons[player_name][name] = label
end

-- set_inventory_formspec
inventory_plus.set_inventory_formspec = function(player, formspec)

	 -- error checking
	if not formspec then
		return
	end

	if minetest.setting_getbool("creative_mode") then

		-- if creative mode is on then wait a bit
		minetest.after(0.01,function()
			player:set_inventory_formspec(formspec)
		end)
	else
		player:set_inventory_formspec(formspec)
	end
end

-- create detached inventory for trashcan
local trashInv = minetest.create_detached_inventory(
	"trash", {
		on_put = function(inv, toList, toIndex, stack, player)
			inv:set_stack(toList, toIndex, ItemStack(nil))
		end
	})

trashInv:set_size("main", 1)

-- get_formspec
inventory_plus.get_formspec = function(player, page)

	if not player then
		return
	end

	-- default inventory page
	local formspec = "size[8,7.5]"
		.. default.gui_bg
		.. default.gui_bg_img
		.. default.gui_slots
		.. "list[current_player;main;0,3.5;8,4;]"

	-- craft page
	if page == "craft" then

		local inv = player:get_inventory() or nil

		if not inv then
			print ("NO INVENTORY FOUND")
			return
		end

		formspec = formspec
			.. "button[0,1;2,0.5;main;Back]"
			.. "list[current_player;craftpreview;7,1;1,1;]"
			.. "list[current_player;craft;3,0;3,3;]"
			.. "listring[current_name;craft]"
			.. "listring[current_player;main]"
			-- trash icon
			.. "list[detached:trash;main;1,2;1,1;]"
			.. "image[1.1,2.1;0.8,0.8;creative_trash_icon.png]"
			
	end

	-- creative page
	if page == "creative" then

		return player:get_inventory_formspec()
			.. "button[5.4,4.2;2.65,0.3;main;Back]"
	end
	
	-- main page
	if page == "main" then

		-- buttons
		local x, y = 0, 1

		for k, v in pairs(inventory_plus.buttons[player:get_player_name()]) do

			formspec = formspec .. "button[" .. x .. ","
				 .. y .. ";2,0.5;" .. k .. ";" .. v .. "]"

			x = x + 2

			if x == 8 then
				x = 0
				y = y + 1
			end
		end
	end
	
	return formspec
end

-- register_on_joinplayer
minetest.register_on_joinplayer(function(player)

	inventory_plus.register_button(player,"craft", "Craft")

	if minetest.setting_getbool("creative_mode") then
		inventory_plus.register_button(player, "creative_prev", "Creative")
	end

	minetest.after(1, function()

		inventory_plus.set_inventory_formspec(player,
			inventory_plus.get_formspec(player, inventory_plus.default))
	end)
end)

-- register_on_player_receive_fields
minetest.register_on_player_receive_fields(function(player, formname, fields)

	-- main

	if fields.main then

		inventory_plus.set_inventory_formspec(player,
			inventory_plus.get_formspec(player, "main"))

		return
	end

	-- craft
	if fields.craft then

		inventory_plus.set_inventory_formspec(player,
			inventory_plus.get_formspec(player, "craft"))

		return
	end

	-- creative
	if fields.creative_prev
	or fields.creative_next then

		minetest.after(0.1, function()

			inventory_plus.set_inventory_formspec(player,
				inventory_plus.get_formspec(player, "creative"))
		end)

		return
	end
end)
