-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.

-- The API documentation in here was moved into game_api.txt

-- Definitions made by this mod that other mods can use too


function default.register_decorations()
minetest.clear_registered_decorations()
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dry_dirt", "default:dirt_with_dry_grass", "default:clay"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.0006,
			spread = {x = 100, y = 100, z = 100},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
		y_min = 1,
		y_max = 30,
		decoration = "scifi_nodes:plant1",
	})



	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dry_dirt", "default:dirt_with_dry_grass", "default:clay"},
		sidelen = 80,
		noise_params = {
			offset = 0,
			scale = 0.0002,
			spread = {x = 1, y = 1, z = 1},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
		y_min = 1,
		y_max = 3000,
		decoration = "scifi_nodes:plant2",
	})


	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:snowblock","default:dirt_with_snow", "default:clay"},
		sidelen = 80,
		noise_params = {
			offset = 0,
			scale = 0.0002,
			spread = {x = 1, y = 1, z = 1},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
		y_min = 13,
		y_max = 3000,
		decoration = "scifi_nodes:plant3",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:gravel"},
		sidelen = 80,
		noise_params = {
			offset = 0,
			scale = 0.0002,
			spread = {x = 1, y = 1, z = 1},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
		y_min = 21,
		y_max = 3000,
		decoration = "scifi_nodes:plant4",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dry_dirt"},
		sidelen = 80,
		noise_params = {
			offset = 0,
			scale = 0.0002,
			spread = {x = 1, y = 1, z = 1},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
		y_min = 31,
		y_max = 3000,
		decoration = "scifi_nodes:plant5",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dry_dirt"},
		sidelen = 80,
		noise_params = {
			offset = 0,
			scale = 0.002,
			spread = {x = 1, y = 1, z = 1},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
		y_min = 51,
		y_max = 3000,
		decoration = "scifi_nodes:plant6",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dry_dirt"},
		sidelen = 80,
		noise_params = {
			offset = 0,
			scale = 0.00002,
			spread = {x = 1, y = 1, z = 1},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
		y_min = 100,
		y_max = 3000,
		decoration = "scifi_nodes:plant7",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dry_dirt","default:dirt_with_rainforest_litter"},
		sidelen = 80,
		noise_params = {
			offset = 0,
			scale = 0.0002,
			spread = {x = 1, y = 1, z = 1},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
		y_min = 1,
		y_max = 30,
		decoration = "scifi_nodes:flower1",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dry_dirt"},
		sidelen = 80,
		noise_params = {
			offset = 0,
			scale = 0.0002,
			spread = {x = 1, y = 1, z = 1},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
		y_min = 44,
		y_max = 3000,
		decoration = "scifi_nodes:flower2",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dry_dirt"},
		sidelen = 80,
		noise_params = {
			offset = 0,
			scale = 0.0002,
			spread = {x = 1, y = 1, z = 1},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
		y_min = 60,
		y_max = 3000,
		decoration = "scifi_nodes:flower3",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dry_dirt"},
		sidelen = 80,
		noise_params = {
			offset = 0,
			scale = 0.00002,
			spread = {x = 1, y = 1, z = 1},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
		y_min = 100,
		y_max = 3000,
		decoration = "scifi_nodes:flower4",
	})
	
	end
	
	
	local mg_params = minetest.get_mapgen_params()
if mg_params.mgname == "v6" then
	
	default.register_mgv6_decorations()
elseif mg_params.mgname ~= "singlenode" then

	default.register_decorations()
end