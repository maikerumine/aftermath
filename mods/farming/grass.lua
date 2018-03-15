
for i = 4, 5 do

	-- Override default grass and have it drop Wheat Seeds

	minetest.override_item("default:grass_" .. i, {
		drop = {
			max_items = 1,
			items = {
				{items = {'farming:seed_wheat'}, rarity = 5},
				{items = {'default:grass_1'}},
			}
		},
	})

	-- Override default dry grass and have it drop Barley Seeds

	if minetest.registered_nodes["default:dry_grass_1"] then

		minetest.override_item("default:dry_grass_" .. i, {
			drop = {
				max_items = 1,
				items = {
					{items = {'farming:seed_barley'}, rarity = 6},
					{items = {'default:dry_grass_1'}},
				}
			},
		})
	end

end

-- Override default Jungle Grass and have it drop Cotton Seeds

minetest.override_item("default:junglegrass", {
	drop = {
		max_items = 1,
		items = {
			{items = {'farming:seed_cotton'}, rarity = 8},
			{items = {'default:junglegrass'}},
		}
	},
})
