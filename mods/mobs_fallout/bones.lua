--mobs_fallout v0.0.4
--maikerumine
--made for Extreme Survival game

--THESE ARE "FAKE" BONES OFR USE WITH THESE MOBS



minetest.register_node("mobs_fallout:bones", {
	description = "Bones",
	tiles = {
		"bones_top.png",
		"bones_bottom.png",
		"bones_side.png",
		"bones_side.png",
		"bones_rear.png",
		"bones_front.png"
	},
	waving = 1,
	visual_scale = 1.0,
		sunlight_propagates = true,
	walkable = true,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
	},
	paramtype2 = "facedir",
	groups = {dig_immediate=3},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		return 0
	end,

	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if meta:get_inventory():is_empty("main") then
			minetest.remove_node(pos)
		end
	end,


	on_punch = function(pos, node, player)


		local inv = minetest.get_meta(pos):get_inventory()
		local player_inv = player:get_inventory()
		local has_space = true

		for i=1,inv:get_size("main") do
			local stk = inv:get_stack("main", i)
			if player_inv:room_for_item("main", stk) then
				inv:set_stack("main", i, nil)
				player_inv:add_item("main", stk)

			else
				has_space = false
				break
			end
		end
	end
	
	
	})