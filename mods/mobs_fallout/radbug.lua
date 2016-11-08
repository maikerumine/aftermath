--mobs_fallout v0.0.3
--maikerumine
--made for Extreme Survival game


--dofile(minetest.get_modpath("mobs_fallout").."/api.lua")

--REFERENCE
--function (mod_name_here):spawn_specific(name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height)

-- radbug by PilzAdam

mobs:register_mob("mobs_fallout:radbug", {
	docile_by_day = false,
	group_attack = true,
	pathfinding = true,
	type = "monster",
	hp_max = 20,
	hp_min = 20,
	collisionbox = {-0.49, 0.00, -0.49, 0.49, 0.9, 0.49},
	visual = "mesh",
	mesh = "ant_soldier.x",
	textures = {{"ant_soldier.png"}},
	visual_size = {x=3, y=3},
	makes_footstep_sound = true,
	view_range = 20,
	fear_height = 4,
	walk_velocity = 1.5,
	run_velocity = 3,
	jump = true,
	rotate = 270,
	sounds = {
		random = "ant",
	},
	drops = {
		{name = "mobs_fallout:meat_raw",
		chance = 1, min = 2, max = 3},
		{name = "default:glue",
		chance = 1, min = 1, max = 1},
	},
	reach = 2,
	armor = 90,
	water_damage = 2,
	lava_damage = 7,
	light_damage = 0,
	attack_type = "dogfight",
	animation = {
		speed_normal = 20,
		speed_run = 35,
		stand_start = 1,
		stand_end = 60,
		walk_start = 90,
		walk_end = 130,
		run_start = 90,
		run_end = 130,
		punch_start = 60,
		punch_end = 80,
	}
})

mobs:register_spawn("mobs_fallout:radbug", {"default:dry_dirt"}, 6, -1, 8000, 2, 31000)
