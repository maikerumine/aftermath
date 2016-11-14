
	--player:get_inventory():set_size("ender", 9*4)
	
-- register_on_joinplayer
minetest.register_on_joinplayer(function(player)
	
	local player_inv = player:get_inventory():set_size("ender", 9*4)
	local ender_inv = minetest.create_detached_inventory(player:get_player_name().."ender")
	end
	)
	

	






local enderchest_formspec =
	"size[9,9.75]"..
	"background[-0.19,-0.25;9.41,10.48;crafting_inventory_chest.png]"..
	"bgcolor[#080808BB;true]"..
	"listcolors[#9990;#FFF7;#FFF0;#160816;#D4D2FF]"..
	"list[current_player;ender;0,0.5;9,4;]"..
	"list[current_player;main;0,5.5;9,3;9]"..
	"list[current_player;main;0,8.74;9,1;]"

minetest.register_node("enderchest:enderchest", {
	description = "Ender Chest",
	tiles = {"ender_top.png", "ender_top.png", "ender_side.png",
		"ender_side.png", "ender_side.png", "ender_front.png"},
	paramtype2 = "facedir",
	groups = {cracky=1,level=2},
	drop = "default:obsidian 8",
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_wood_defaults(),
	stack_max = 64,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", enderchest_formspec)
		meta:set_string("infotext", "Ender Chest")
	end,
})

minetest.register_abm({
	nodenames = {"enderchest:enderchest"},
	interval = 1,
	chance = 2,
	action = function(pos, node)
		minetest.add_particlespawner(
			16, --amount
			4, --time
			{x=pos.x-0.5, y=pos.y-0.5, z=pos.z-0.5}, --minpos
			{x=pos.x+0.5, y=pos.y+0.5, z=pos.z+0.5}, --maxpos
			{x=-0.5, y=-0.5, z=-0.5}, --minvel
			{x=0.5, y=0.5, z=0.5}, --maxvel
			{x=0,y=0,z=0}, --minacc
			{x=0,y=0,z=0}, --maxacc
			0.5, --minexptime
			3, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			--"nether_particle.png" --texture
			"default_mese_crystal.png" --texture
		)
	end,
})
--[[
--crafting
minetest.register_craft({
	output = 'enderchest:enderchest',
	recipe = {
		{'default:obsidian', 'default:obsidian', 'default:obsidian'},
		{'default:obsidian', 'farorb:farorb',    'default:obsidian'},
		{'default:obsidian', 'default:obsidian', 'default:obsidian'},
	}
})

minetest.register_craft({
	output = 'enderchest:enderchest',
	recipe = {
		{'default:obsidian', 'default:obsidian', 'default:obsidian'},
		{'default:obsidian', 'default:mese',    'default:obsidian'},
		{'default:obsidian', 'default:obsidian', 'default:obsidian'},
	}
})
]]