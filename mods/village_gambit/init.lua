
village_gambit = {}

village_gambit.replacements_gambit = function( housetype, pr, replacements )
      -- replace the wood - those are lumberjacks after all
      local wood_type = mg_villages.replace_materials( replacements, pr,
		{'default:wood'},
		{''},
		{ 'default:wood', 'default:junglewood', 'mg:savannawood', 'mg:pinewood' },
		'default:wood');
      mg_villages.replace_tree_trunk( replacements, wood_type );
      mg_villages.replace_saplings(   replacements, wood_type );

      mg_villages.replace_materials( replacements, pr,
		{'stairs:stair_cobble',  'stairs:slab_cobble', 'default:cobble'},
		{'stairs:stair_',         'stairs:slab_',      'default:'     },
		{'stonebrick', 'desert_stonebrick','sandstonebrick', 'sandstone','stone','desert_stone','stone_flat','desert_stone_flat','stone_bricks','desert_strone_bricks'},
		'stonebrick');

      return replacements;
end

-- add a new village type for all those buildings
mg_villages.add_village_type( 'gambit', { min = 30, max = 60,  space_between_buildings=2, mods={}, texture = 'default_tree_top.png',
			    replacement_function = village_gambit.replacements_gambit});

local path = minetest.get_modpath( 'village_gambit' )..'/schems/';

mg_villages.add_building( { scm="gambit_church_1_0_180",         mts_path=path, weight={gambit=4},   inh=-1, typ='church',   pervillage=1});
mg_villages.add_building( { scm="gambit_cementry_0_180",         mts_path=path, weight={gambit=1},   inh=0,  typ='cementry', pervillage=1});
mg_villages.add_building( { scm="gambit_field_1_1_90",           mts_path=path, weight={gambit=1},   inh=0,  typ='field'});
mg_villages.add_building( { scm="gambit_forge_1_2_270",          mts_path=path, weight={gambit=4},   inh=-1, typ='forge',    pervillage=1});
mg_villages.add_building( { scm="gambit_fountain_1_1_90",        mts_path=path, weight={gambit=1/6}, inh=0,typ='fountain'});
mg_villages.add_building( { scm="gambit_house_1_0_0",            mts_path=path, weight={gambit=3, single=1},   inh=3,  typ='house'});
mg_villages.add_building( { scm="gambit_lamp_0_270",             mts_path=path, weight={gambit=1},   inh=0,  typ='lamp', avoid='lamp'});
mg_villages.add_building( { scm="gambit_library_hotel_0_180",    mts_path=path, weight={gambit=1, single=1},   inh=4,  typ='hotel'});
mg_villages.add_building( { scm="gambit_pub_1_0_0",              mts_path=path, weight={gambit=1, single=1},   inh=1,  typ='pub'});
mg_villages.add_building( { scm="gambit_shed_open_chests_2_0",   mts_path=path, weight={gambit=1},   inh=0,  typ='shed'});
mg_villages.add_building( { scm="gambit_shop_0_90",              mts_path=path, weight={gambit=1},   inh=-1, typ='shop'});
mg_villages.add_building( { scm="gambit_shop_large_0_0",         mts_path=path, weight={gambit=1},   inh=1,  typ='shop'});
mg_villages.add_building( { scm="gambit_stable_1_2_90",          mts_path=path, weight={gambit=1, single=1},   inh=1,  typ='stable'});
mg_villages.add_building( { scm="gambit_tower_1_0_270",          mts_path=path, weight={gambit=1/6}, inh=-1, typ='tower'});
