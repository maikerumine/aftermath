--mobs_fallout v0.0.3
--maikerumine
--made for Extreme Survival game


--dofile(minetest.get_modpath("mobs_fallout").."/api.lua")

--REFERENCE
--function (mod_name_here):spawn_specific(name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height)

-- Sheep by PilzAdam

mobs:register_mob("mobs_fallout:sheep", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	hp_min = 32,
	hp_max = 50,
	armor = 100,
	damage = 8,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "mobs_sheep.x",
	textures = {
		{"mobs_sheep.png"},
	},
	visual_size = {x=1,y=1},
	gotten_texture = {{"mobs_sheep_shaved.png"}},
	gotten_mesh = "mobs_sheep_shaved.x",
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_stonemonster",
	},
	walk_velocity = 2.7,
	run_velocity = 3.7,
	jump = true,
	drops = {
		{name = "mobs_fallout:meat_raw",
		chance = 1, min = 2, max = 3},
		{name = "wool:brown",
		chance = 1, min = 1, max = 1},
	},
	water_damage = 1,
	lava_damage = 50,
	light_damage = 0,
	animation = {
		speed_normal = 15,		speed_run = 15,
		stand_start = 0,		stand_end = 80,
		walk_start = 81,		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 18,
	replace_rate = 50,
	replace_what = {"default:grass_3", "default:grass_4", "default:grass_5", "farming:wheat_8"},
	replace_with = "air",
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "farming:wheat" then
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
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
				self.gotten = false -- can be shaved again
				self.tamed = true
				self.object:set_properties({
					textures = {"mobs_sheep.png"},
					mesh = "mobs_sheep.x",
					mesh = "mobs_sheep.x",
				})
				minetest.sound_play("mobs_stonemonster", {object = self.object,gain = 1.0,max_hear_distance = 32,loop = false,})
			end
			return
		end

		if item:get_name() == "mobs_fallout:shears"
		and self.gotten == false
		and self.child == false then
			self.gotten = true -- shaved
			if minetest.registered_items["wool:white"] then
				local pos = self.object:getpos()
				pos.y = pos.y + 0.5
				local obj = minetest.add_item(pos, ItemStack("wool:white "..math.random(2,3)))
				if obj then
					obj:setvelocity({x=math.random(-1,1), y=5, z=math.random(-1,1)})
				end
				item:add_wear(650) -- 100 uses
				clicker:set_wielded_item(item)
			end
			self.object:set_properties({
				textures = {"mobs_sheep_shaved.png"},
				mesh = "mobs_sheep_shaved.x",
			})
		end

		if item:get_name() == "mobs:magic_lasso"
		and clicker:is_player()
		and clicker:get_inventory()
		and self.child == false
		and clicker:get_inventory():room_for_item("main", "mobs_fallout:sheep") then
			clicker:get_inventory():add_item("main", "mobs_fallout:sheep")
			self.object:remove()
			item:add_wear(3000) -- 22 uses
			print ("wear", item:get_wear())
			clicker:set_wielded_item(item)
		end
	end,
})

mobs:register_spawn("mobs_fallout:sheep", {"default:dirt_with_grass","default:dirt_with_dry_grass", "default:grass", "ethereal:green_dirt", "default:dry_dirt", "default:snow"}, 18, -1, 6000, 2, 31000)

--mobs:register_egg("mobs_fallout:sheep", "Sheep", "wool_white.png", 1)

--shears (right click sheep to shear wool)
minetest.register_tool("mobs_fallout:shears", {
	description = "Steel Shears (right-click sheep to shear)",
	inventory_image = "mobs_shears.png",
})

minetest.register_craft({
	output = 'mobs_fallout:shears',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'', 'group:stick', 'default:steel_ingot'},
	}
})



