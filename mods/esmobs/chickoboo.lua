
-- Chicken by JK Murray

bp:register_mob("esmobs:chickoboo", {
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	damage = 3,
	hp_min = 50,
	hp_max = 80,
	armor = 90,
	collisionbox = {-0.4, -3.1, -0.4, 0.4, -1.7, 0.4},
	--	collisionbox = {-0.3, -0.75, -0.3, 0.3, 0.1, 0.3},
	visual = "mesh",
	mesh = "mobs_chicken.x",
	textures = {
		{"mobs_chicken.png", "mobs_chicken.png", "mobs_chicken.png", "mobs_chicken.png",
		"mobs_chicken.png", "mobs_chicken.png", "mobs_chicken.png", "mobs_chicken.png", "mobs_chicken.png"},
		{"mobs_chicken_black.png", "mobs_chicken_black.png", "mobs_chicken_black.png", "mobs_chicken_black.png",
		"mobs_chicken_black.png", "mobs_chicken_black.png", "mobs_chicken_black.png", "mobs_chicken_black.png", "mobs_chicken_black.png"},
	},
	child_texture = {
		{"mobs_chick.png", "mobs_chick.png", "mobs_chick.png", "mobs_chick.png",
		"mobs_chick.png", "mobs_chick.png", "mobs_chick.png", "mobs_chick.png", "mobs_chick.png"},
	},
	visual_size = {x=4.5,y=4.5},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_chicken",
	},
	walk_velocity = 2.8,
	run_velocity = 7,
	jump = true,
	view_range = 45,
	drops = {
		{name = "esmobs:chicken_raw",
		chance = 1, min = 6, max = 12},
		{name = "esmobs:egg",
		chance = 1, min = 1, max = 3},
	},
	water_damage = 10,
	lava_damage = 50,
	light_damage = 0,
	fall_damage = 0,
	fall_speed = -4,
	animation = {
		speed_normal = 15,
		stand_start = 0,
		stand_end = 1, -- 20
		walk_start = 20,
		walk_end = 40,
	},
	follow = "farming:seed_wheat",
	view_range = 5,
	replace_rate = 20000,
	replace_what = {"air"},
	replace_with = "esmobs:egg",
	on_rightclick = function(self, clicker)
		local tool = clicker:get_wielded_item()
		if tool:get_name() == "farming:seed_wheat" then
			if not minetest.setting_getbool("creative_mode") then
				tool:take_item(1)
				clicker:set_wielded_item(tool)
			end
			if self.child == true then
				self.hornytimer = self.hornytimer + 10
				return
			end
			self.food = (self.food or 0) + 1
			if self.food >= 8 then
				self.food = 0
				if self.hornytimer == 0 then
					self.horny = true
				end
				self.tamed = true
				minetest.sound_play("mobs_chicken", {object = self.object,gain = 1.0,max_hear_distance = 15,loop = false,})
			end
			return
		end

		--[[if clicker:is_player()
		and clicker:get_inventory()
		and self.child == false
		and clicker:get_inventory():room_for_item("main", "esmobs:chickoboo") then
			clicker:get_inventory():add_item("main", "esmobs:chickoboo")
			self.object:remove()
		end]]
	end,
})

bp:register_spawn("esmobs:chickoboo", {"default:dirt_with_grass", "ethereal:bamboo_dirt"}, 15, 10, 32000, 1, 31000)

--bp:register_egg("esmobs:chickoboo", "Chickoboo", "mobs_chicken_inv.png", 0)

-- egg
minetest.register_node("esmobs:egg", {
	description = "Chicken Egg",
	tiles = {"mobs_chicken_egg.png"},
	inventory_image  = "mobs_chicken_egg.png",
	visual_scale = 0.7,
	drawtype = "plantlike",
	wield_image = "mobs_chicken_egg.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	groups = {snappy=2, dig_immediate=3},
	after_place_node = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, {name="esmobs:egg", param2=1})
		end
	end
})

-- fried egg
minetest.register_craftitem("esmobs:chicken_egg_fried", {
description = "Fried Egg",
	inventory_image = "mobs_chicken_egg_fried.png",
	on_use = minetest.item_eat(2),
})

minetest.register_craft({
	type  =  "cooking",
	recipe  = "esmobs:egg",
	output = "esmobs:chicken_egg_fried",
})

-- chicken (raw and cooked)
minetest.register_craftitem("esmobs:chicken_raw", {
description = "Raw Chicken",
	inventory_image = "mobs_chicken_raw.png",
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("esmobs:chicken_cooked", {
description = "Cooked Chicken",
	inventory_image = "mobs_chicken_cooked.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craft({
	type  =  "cooking",
	recipe  = "esmobs:chicken_raw",
	output = "esmobs:chicken_cooked",
})
