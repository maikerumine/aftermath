
village_modern_houses = {}

village_modern_houses.replacements_modern_housees = function( housetype, pr, replacements )
      -- replace the wood - even though those houses use only a limited amount of wood
      local wood_type = mg_villages.replace_materials( replacements, pr,
		{'default:wood'},
		{''},
		{ 'default:wood', 'default:junglewood', 'mg:savannawood', 'mg:pinewood' },
		'default:wood');
      mg_villages.replace_tree_trunk( replacements, wood_type );
      mg_villages.replace_saplings(   replacements, wood_type );
	return replacements;
end

-- add a new village type for all those buildings
mg_villages.add_village_type( 'modern_houses', { min = 15, max = 30,  space_between_buildings=1, mods={}, texture = 'default_steelblock.png',
		-- the roads are a bit diffrent
		roadsize_list = {6,6,6,6,6},
		road_materials = {"default:coalblock", "default:coalblock", "default:coalblock",
				"default:coalblock", "default:coalblock", "default:coalblock", "default:coalblock"},
		replacement_function = village_modern_houses.replacements_modern_houses});

local path = minetest.get_modpath( 'village_modern_houses' )..'/schems/';


mg_villages.add_building( { scm="modern_house_a_5_270",        mts_path=path, weight={modern_houses=1, single=1}, inh=2,  typ='house'});
mg_villages.add_building( { scm="modern_house_facade_2_90",    mts_path=path, weight={modern_houses=1, single=1}, inh=2,  typ='house'});
mg_villages.add_building( { scm="modern_house_serenity_1_180", mts_path=path, weight={modern_houses=1, single=1}, inh=2,  typ='house'});
