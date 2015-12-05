
village_ruins = {}

village_ruins.replacements_ruins = function( housetype, pr, replacements )
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
mg_villages.add_village_type( 'ruins', { min = 15, max = 30,  space_between_buildings=1, mods={}, texture = 'default_gravel.png',
		replacement_function = village_ruins.replacements_ruins});

local path = minetest.get_modpath( 'village_ruins' )..'/schems/';


mg_villages.add_building( { scm="cabin",          mts_path=path, weight={ruins=1, single=1},   typ='house',  orients={1}});
mg_villages.add_building( { scm="cabin_old",      mts_path=path, weight={ruins=1, single=1},   typ='house',  orients={1}});
mg_villages.add_building( { scm="church",         mts_path=path, weight={ruins=1},             typ='church', orients={1}, pervillage=1});
mg_villages.add_building( { scm="church_old",     mts_path=path, weight={ruins=1},             typ='church', orients={1}, pervillage=1});
mg_villages.add_building( { scm="watchtower",     mts_path=path, weight={ruins=1/8, single=1}, typ='tower',  orients={1}});
mg_villages.add_building( { scm="watchtower_old", mts_path=path, weight={ruins=1/8, single=1}, typ='tower',  orients={1}});
mg_villages.add_building( { scm="bunker",         mts_path=path, weight={ruins=1/9, single=1}, typ='bunker', orients={1}});

mg_villages.add_building( { scm="wooden_house",   mts_path=path, weight={ruins=1,   single=1}, typ='house',  orients={1}});
mg_villages.add_building( { scm="watchtower_ruin",mts_path=path, weight={ruins=1/8, single=1}, typ='tower',  orients={1}});
mg_villages.add_building( { scm="watchtower2",    mts_path=path, weight={ruins=1/8, single=1}, typ='tower',  orients={1}});
