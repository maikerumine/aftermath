--mobs:spawn_specific("mobs_fallout:sandworm", {"default:mud", "default:toxic_water_source"}, {"air"}, 0, 20, 20, 9000, 2, -31000, 31000)
mobs:register_spawn("mobs_fallout:mudworm", {"default:mud","default:mud_flowing",  "default:toxic_water_source", "default:toxic_water_flowing"}, 9, -1, 9000, 2, 31000)
mobs:register_mob("mobs_fallout:mudworm", {
	type = "monster",
	group_attack = true,
	pathfinding = true,
	hp_max = 30,
	hp_min = 25,
	collisionbox = {-0.4, -0.2, -0.4, 0.4, 1.90, 0.4},
	visual = "mesh",
	mesh = "sandworm.x",
	textures = {{"sandworm.png"}},
	visual_size = {x=4, y=4},
	makes_footstep_sound = false,
	view_range = 27,
	rotate = 270,
	reach = 7,
	fear_height = 3,
	walk_velocity = 2,
	run_velocity = 3.4,
	damage = 3,
	jump = false,
	sounds = {
		random = "uloboros",
		death = "mummy_death",
		distance =40,
	},
	drops = {
		{name = "default:mese_crystal_fragment", chance = 2, min = 1, max = 3},
		{name = "default:glue", chance = 19, min = 0, max = 1},
		{name = "mobs_fallout:meat_raw", chance = 1, min = 5, max = 12},
	},
	armor = 90,
	water_damage = 0,
	lava_damage = 10,
	light_damage = 4,
	attack_type = "dogfight",
	animation = {
		speed_normal = 25,
		speed_run = 40,
		stand_start = 1,
		stand_end = 100,
		walk_start = 110,
		walk_end = 140,
		run_start = 110,
		run_end = 140,
		punch_start = 150,
		punch_end = 180,
	},
	do_custom = function(self)
		--Worm
		local c=2
		local pos = self.object:getpos()
		local v = self.object:getvelocity()
		for dx = -c*(math.abs(v.x))-1 , c*(math.abs(v.x))+1 do
			for dy=0,4 do
				for dz = -c*(math.abs(v.z))-1 , c*(math.abs(v.z))+1 do
					local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
					local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
					local n = minetest.env:get_node(p).name
					if (n~="default:toxic_water_source" and n~="default:toxic_water_flowing") then
						if n=="default:mud" or n=="default:mud_flowing" then
							minetest.env:set_node(t, {name="air"})
						end
					end
				end
			end
		end
	end,
})
