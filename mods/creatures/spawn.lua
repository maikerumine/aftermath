-------------------------------------------------------------------------
-- Wasteland
-- Copyright (C) 2015 BlockMen <blockmen2015@gmail.de>
--
-- This file is part of Wasteland
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
-------------------------------------------------------------------------


local max_mobs_sum = creatures.zombie_max
-- hostile mobs
if not minetest.setting_getbool("only_peaceful_mobs") then
	-- zombie
	minetest.register_abm({
		nodenames = creatures.z_spawn_nodes,
  		neighbors = {"air"},
		interval = 40.0,
		chance = 7600,
		action = function(pos, node, active_object_count, active_object_count_wider)
			-- check per mapblock max (max per creature is done by .spawn())
			if active_object_count_wider > max_mobs_sum then
				return
			end
			local n = minetest.get_node_or_nil(pos)
			--if n and n.name and n.name ~= "default:stone" and math.random(1,4)>3 then return end
			pos.y = pos.y + 1
			local ll = minetest.get_node_light(pos)
			if not ll then
				return
			end
			if ll >= creatures.z_ll then
				return
			end
			if ll < -1 then
				return
			end
			if minetest.get_node(pos).name ~= "air" then
				return
			end
			pos.y = pos.y + 1
			if minetest.get_node(pos).name ~= "air" then
				return
			end

			pos.y = pos.y - 1

			creatures.spawn(pos, math.random(1, 3), "creatures:zombie", 2, 20)
		end})
end
