minetest.register_privilege("delprotect","Ignore player protection")

protector = {}
protector.mod = "redo"
protector.radius = (tonumber(minetest.setting_get("protector_radius")) or 5)
protector.drop = minetest.setting_getbool("protector_drop") or false
protector.hurt = (tonumber(minetest.setting_get("protector_hurt")) or 0)

protector.get_member_list = function(meta)

	return meta:get_string("members"):split(" ")
end

protector.set_member_list = function(meta, list)

	meta:set_string("members", table.concat(list, " "))
end

protector.is_member = function (meta, name)

	for _, n in pairs(protector.get_member_list(meta)) do

		if n == name then
			return true
		end
	end

	return false
end

protector.add_member = function(meta, name)

	if protector.is_member(meta, name) then
		return
	end

	local list = protector.get_member_list(meta)

	table.insert(list, name)

	protector.set_member_list(meta, list)
end

protector.del_member = function(meta, name)

	local list = protector.get_member_list(meta)

	for i, n in pairs(list) do

		if n == name then
			table.remove(list, i)
			break
		end
	end

	protector.set_member_list(meta, list)
end

-- Protector Interface

protector.generate_formspec = function(meta)

	local formspec = "size[8,7]"
		.. default.gui_bg
		.. default.gui_bg_img
		.. default.gui_slots
		.. "label[2.5,0;-- Protector interface --]"
		.. "label[0,1;PUNCH node to show protected area or USE for area check]"
		.. "label[0,2;Members: (type player name then press Enter to add)]"
		.. "button_exit[2.5,6.2;3,0.5;close_me;Close]"

	local members = protector.get_member_list(meta)
	local npp = 12 -- max users added onto protector list
	local i = 0

	for _, member in pairs(members) do

		if i < npp then

			-- show username
			formspec = formspec .. "button[" .. (i % 4 * 2)
			.. "," .. math.floor(i / 4 + 3)
			.. ";1.5,.5;protector_member;" .. member .. "]"

			-- username remove button
			.. "button[" .. (i % 4 * 2 + 1.25) .. ","
			.. math.floor(i / 4 + 3)
			.. ";.75,.5;protector_del_member_" .. member .. ";X]"
		end

		i = i + 1
	end
	
	if i < npp then

		-- user name entry field
		formspec = formspec .. "field[" .. (i % 4 * 2 + 1 / 3) .. ","
		.. (math.floor(i / 4 + 3) + 1 / 3)
		.. ";1.433,.5;protector_add_member;;]"

		-- username add button
		.."button[" .. (i % 4 * 2 + 1.25) .. ","
		.. math.floor(i / 4 + 3) .. ";.75,.5;protector_submit;+]"

	end

	return formspec
end

-- Infolevel:
-- 0 for no info
-- 1 for "This area is owned by <owner> !" if you can't dig
-- 2 for "This area is owned by <owner>.
-- 3 for checking protector overlaps

protector.can_dig = function(r, pos, digger, onlyowner, infolevel)

	if not digger
	or not pos then
		return false
	end

	-- Delprotect privileged users can override protections

	if minetest.check_player_privs(digger, {delprotect = true})
	and infolevel == 1 then
		return true
	end

	if infolevel == 3 then infolevel = 1 end

	-- Find the protector nodes

	local positions = minetest.find_nodes_in_area(
		{x = pos.x - r, y = pos.y - r, z = pos.z - r},
		{x = pos.x + r, y = pos.y + r, z = pos.z + r},
		{"protector:protect", "protector:protect2"})

	local meta, owner, members

	for _, pos in pairs(positions) do

		meta = minetest.get_meta(pos)
		owner = meta:get_string("owner")
		members = meta:get_string("members")

		if owner ~= digger then 

			if onlyowner
			or not protector.is_member(meta, digger) then

				if infolevel == 1 then

					minetest.chat_send_player(digger,
					"This area is owned by " .. owner .. " !")

				elseif infolevel == 2 then

					minetest.chat_send_player(digger,
					"This area is owned by " .. owner .. ".")

					minetest.chat_send_player(digger,
					"Protection located at: " .. minetest.pos_to_string(pos))

					if members ~= "" then

						minetest.chat_send_player(digger,
						"Members: " .. members .. ".")
					end
				end

				return false
			end
		end

		if infolevel == 2 then

			minetest.chat_send_player(digger,
			"This area is owned by " .. owner .. ".")

			minetest.chat_send_player(digger,
			"Protection located at: " .. minetest.pos_to_string(pos))

			if members ~= "" then

				minetest.chat_send_player(digger,
				"Members: " .. members .. ".")
			end

			return false
		end

	end

	if infolevel == 2 then

		if #positions < 1 then

			minetest.chat_send_player(digger,
			"This area is not protected.")
		end

		minetest.chat_send_player(digger, "You can build here.")
	end

	return true
end

-- Can node be added or removed, if so return node else true (for protected)

protector.old_is_protected = minetest.is_protected

function minetest.is_protected(pos, digger)

	if not protector.can_dig(protector.radius, pos, digger, false, 1) then

		local player = minetest.get_player_by_name(digger)

		-- hurt player if protection violated
		if protector.hurt > 0
		and player then
			player:set_hp(player:get_hp() - protector.hurt)
		end

		-- drop tool/item if protection violated
		if protector.drop == true
		and player then

			local holding = player:get_wielded_item()

			if holding:to_string() ~= "" then

				-- take stack
				local sta = holding:take_item(holding:get_count())
				player:set_wielded_item(holding)

				-- incase of lag, reset stack
				minetest.after(0.1, function()
					player:set_wielded_item(holding)

					-- drop stack
					local obj = minetest.add_item(player:getpos(), sta)
					obj:setvelocity({x = 0, y = 5, z = 0})
				end)

			end

		end

		return true
	end

	return protector.old_is_protected(pos, digger)

end

-- Make sure protection block doesn't overlap another protector's area

function protector.check_overlap(itemstack, placer, pointed_thing)

	if pointed_thing.type ~= "node" then
		return itemstack
	end

	if not protector.can_dig(protector.radius * 2, pointed_thing.above,
	placer:get_player_name(), true, 3) then

		minetest.chat_send_player(placer:get_player_name(),
			"Overlaps into above players protected area")

		return
	end

	return minetest.item_place(itemstack, placer, pointed_thing)

end

--= Protection Block

minetest.register_node("protector:protect", {
	description = "Protection Block",
	drawtype = "nodebox",
	tiles = {
		"protector_top.png",
		"protector_top.png",
		"protector_side.png"
	},
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 2, choppy = 2, unbreakable = 1},
	is_ground_content = false,
	paramtype = "light",
	light_source = 4,

	node_box = {
		type = "fixed",
		fixed = {
			{-0.5 ,-0.5, -0.5, 0.5, 0.5, 0.5},
		}
	},

	on_place = protector.check_overlap,

	after_place_node = function(pos, placer)

		local meta = minetest.get_meta(pos)

		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Protection (owned by " .. meta:get_string("owner") .. ")")
		meta:set_string("members", "")
	end,

	on_use = function(itemstack, user, pointed_thing)

		if pointed_thing.type ~= "node" then
			return
		end

		protector.can_dig(protector.radius, pointed_thing.under, user:get_player_name(), false, 2)
	end,

	on_rightclick = function(pos, node, clicker, itemstack)

		local meta = minetest.get_meta(pos)

		if meta
		and protector.can_dig(1, pos,clicker:get_player_name(), true, 1) then
			minetest.show_formspec(clicker:get_player_name(), 
			"protector:node_" .. minetest.pos_to_string(pos), protector.generate_formspec(meta))
		end
	end,

	on_punch = function(pos, node, puncher)

		if not protector.can_dig(1, pos, puncher:get_player_name(), true, 1) then
			return
		end

		minetest.add_entity(pos, "protector:display")
	end,

	can_dig = function(pos, player)

		return protector.can_dig(1, pos, player:get_player_name(), true, 1)
	end,

	on_blast = function() end,
})

minetest.register_craft({
	output = "protector:protect",
	recipe = {
		{"default:stone", "default:stone", "default:stone"},
		{"default:stone", "default:mese", "default:stone"},
		{"default:stone", "default:stone", "default:stone"},
	}
})
--[[
--= Protection Logo

minetest.register_node("protector:protect2", {
	description = "Protection Logo",
	tiles = {"protector_logo.png"},
	wield_image = "protector_logo.png",
	inventory_image = "protector_logo.png",
	sounds = default.node_sound_stone_defaults(),
	groups = {dig_immediate = 2, unbreakable = 1},
	paramtype = 'light',
	paramtype2 = "wallmounted",
	legacy_wallmounted = true,
	light_source = 4,
	drawtype = "nodebox",
	sunlight_propagates = true,
	walkable = true,
	node_box = {
		type = "wallmounted",
		wall_top    = {-0.375, 0.4375, -0.5, 0.375, 0.5, 0.5},
		wall_bottom = {-0.375, -0.5, -0.5, 0.375, -0.4375, 0.5},
		wall_side   = {-0.5, -0.5, -0.375, -0.4375, 0.5, 0.375},
	},
	selection_box = {type = "wallmounted"},

	on_place = protector.check_overlap,

	after_place_node = function(pos, placer)

		local meta = minetest.get_meta(pos)

		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Protection (owned by " .. meta:get_string("owner") .. ")")
		meta:set_string("members", "")
	end,

	on_use = function(itemstack, user, pointed_thing)

		if pointed_thing.type ~= "node" then
			return
		end

		protector.can_dig(protector.radius, pointed_thing.under, user:get_player_name(), false, 2)
	end,

	on_rightclick = function(pos, node, clicker, itemstack)

		local meta = minetest.get_meta(pos)

		if protector.can_dig(1, pos, clicker:get_player_name(), true, 1) then

			minetest.show_formspec(clicker:get_player_name(), 
			"protector:node_" .. minetest.pos_to_string(pos), protector.generate_formspec(meta))
		end
	end,

	on_punch = function(pos, node, puncher)

		if not protector.can_dig(1, pos, puncher:get_player_name(), true, 1) then
			return
		end

		minetest.add_entity(pos, "protector:display")
	end,

	can_dig = function(pos, player)

		return protector.can_dig(1, pos, player:get_player_name(), true, 1)
	end,

	on_blast = function() end,
})

minetest.register_craft({
	output = "protector:protect2",
	recipe = {
		{"default:stone", "default:bronze_ingot", "default:stone"},
		{"default:bronze_ingot", "default:mese", "default:bronze_ingot"},
		{"default:stone", "default:bronze_ingot", "default:stone"},
	}
})
]]
-- If name entered or button press

minetest.register_on_player_receive_fields(function(player, formname, fields)

	if string.sub(formname, 0, string.len("protector:node_")) == "protector:node_" then

		local pos_s = string.sub(formname, string.len("protector:node_") + 1)
		local pos = minetest.string_to_pos(pos_s)
		local meta = minetest.get_meta(pos)

		if not protector.can_dig(1, pos, player:get_player_name(), true, 1) then
			return
		end

		if fields.protector_add_member then

			for _, i in pairs(fields.protector_add_member:split(" ")) do
				protector.add_member(meta, i)
			end
		end

		for field, value in pairs(fields) do

			if string.sub(field, 0, string.len("protector_del_member_")) == "protector_del_member_" then
				protector.del_member(meta, string.sub(field,string.len("protector_del_member_") + 1))
			end
		end
		
		if not fields.close_me then
			minetest.show_formspec(player:get_player_name(), formname, protector.generate_formspec(meta))
		end

	end

end)

-- Display entity shown when protector node is punched

minetest.register_entity("protector:display", {
	physical = false,
	collisionbox = {0, 0, 0, 0, 0, 0},
	visual = "wielditem",
	-- wielditem seems to be scaled to 1.5 times original node size
	visual_size = {x = 1.0 / 1.5, y = 1.0 / 1.5},
	textures = {"protector:display_node"},
	timer = 0,

	on_activate = function(self, staticdata)

		-- Xanadu server only
		if mobs and mobs.entity and mobs.entity == false then
			self.object:remove()
		end
	end,

	on_step = function(self, dtime)

		self.timer = self.timer + dtime

		if self.timer > 7 then
			self.object:remove()
		end
	end,
})

-- Display-zone node, Do NOT place the display as a node,
-- it is made to be used as an entity (see above)

local x = protector.radius
minetest.register_node("protector:display_node", {
	tiles = {"protector_display.png"},
	use_texture_alpha = true,
	walkable = false,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- sides
			{-(x+.55), -(x+.55), -(x+.55), -(x+.45), (x+.55), (x+.55)},
			{-(x+.55), -(x+.55), (x+.45), (x+.55), (x+.55), (x+.55)},
			{(x+.45), -(x+.55), -(x+.55), (x+.55), (x+.55), (x+.55)},
			{-(x+.55), -(x+.55), -(x+.55), (x+.55), (x+.55), -(x+.45)},
			-- top
			{-(x+.55), (x+.45), -(x+.55), (x+.55), (x+.55), (x+.55)},
			-- bottom
			{-(x+.55), -(x+.55), -(x+.55), (x+.55), -(x+.45), (x+.55)},
			-- middle (surround protector)
			{-.55,-.55,-.55, .55,.55,.55},
		},
	},
	selection_box = {
		type = "regular",
	},
	paramtype = "light",
	groups = {dig_immediate = 3, not_in_creative_inventory = 1},
	drop = "",
})

dofile(minetest.get_modpath("protector") .. "/doors_chest.lua")
dofile(minetest.get_modpath("protector") .. "/pvp.lua")
dofile(minetest.get_modpath("protector") .. "/admin.lua")

print ("[MOD] Protector Redo loaded")

minetest.register_craft({
	type = "cooking",
	cooktime = 180,
	output = "default:mese_crystal 8",
	recipe = "protector:protect",
})
