lasers = {
	{"mobs_futuremobs:laser", "mobs_futuremobs:laser_entity"},
}

local shoot_laser = function(itemstack, player)
	for _,laser in ipairs(lasers) do
		if player:get_inventory():get_stack("main", player:get_wield_index()+1):get_name() == laser[1] then
			if not minetest.setting_getbool("creative_mode") then
				player:get_inventory():remove_item("main", laser[1])
			end
			local playerpos = player:getpos()
			local obj = minetest.env:add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, laser[2])
			local dir = player:get_look_dir()
			obj:setvelocity({x=dir.x*19, y=dir.y*19, z=dir.z*19})
			obj:setacceleration({x=dir.x*-3, y=0, z=dir.z*-3})
			obj:setyaw(player:get_look_yaw()+math.pi)
			minetest.sound_play("laser_sound", {pos=playerpos})
			if obj:get_luaentity().player == "" then
				obj:get_luaentity().player = player
			end
			obj:get_luaentity().node = player:get_inventory():get_stack("main", 1):get_name()
			return true
		end
	end
	return false
end

--===========================


--===========================
minetest.register_tool("mobs_futuremobs:blue_laser_gun", {
	description = "Blue Laser Gun",
	inventory_image = "blue_laser_gun.png",
    stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if shoot_laser(item, user, pointed_thing) then
			if not minetest.setting_getbool("creative_mode") then
				itemstack:add_wear(65535/100)
			end
		end
		return itemstack
	end,
})
--[[
minetest.register_craft({
	output = 'mobs_futuremobs:blue_laser_gun',
	recipe = {
		{'default:wood', 'default:steelblock', ''},
		{'default:steel_ingot', 'default:diamond', 'default:glass'},
		{'default:steel_ingot', 'default:steel_ingot', ''},
	}
})
]]
minetest.register_tool("mobs_futuremobs:red_laser_gun", {
	description = "Red Laser Gun",
	inventory_image = "red_laser_gun.png",
    stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if shoot_laser(item, user, pointed_thing) then
			if not minetest.setting_getbool("creative_mode") then
				itemstack:add_wear(65535/100)
			end
		end
		return itemstack
	end,
})
--[[
minetest.register_craft({
	output = 'mobs_futuremobs:red_laser_gun',
	recipe = {
		{'default:wood', 'default:steelblock', ''},
		{'default:steel_ingot', 'default:copper_ingot', 'default:glass'},
		{'default:steel_ingot', 'default:steel_ingot', ''},
	}
})
]]


if minetest.setting_get("log_mods") then
	minetest.log("action", "mobs_futuremobs throwing loaded")
end
