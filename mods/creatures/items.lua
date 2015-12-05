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


-- drop items
minetest.register_craftitem("creatures:flesh", {
	description = "Flesh",
	inventory_image = "creatures_flesh.png",
	on_use = minetest.item_eat(2),
	stack_max = 60,
})

minetest.register_craftitem("creatures:rotten_flesh", {
	description = "Rotten Flesh",
	inventory_image = "creatures_rotten_flesh.png",
	on_use = minetest.item_eat(1),
	stack_max = 60,
})

-- food
minetest.register_craftitem("creatures:meat", {
	description = "Cooked Meat",
	inventory_image = "creatures_meat.png",
	on_use = minetest.item_eat(4),
	stack_max = 60,
})

minetest.register_craft({
	type = "cooking",
	output = "creatures:meat",
	recipe = "creatures:flesh",
})

-- spawn-eggs
minetest.register_craftitem("creatures:zombie_spawn_egg", {
	description = "Zombie spawn-egg",
	inventory_image = "creatures_egg_zombie.png",
	liquids_pointable = false,
	stack_max = 60,
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type == "node" then
			local p = pointed_thing.above
			p.y = p.y+1
			creatures.spawn(p, 1, "creatures:zombie", 1, 1)
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			return itemstack
		end
	end,

})
