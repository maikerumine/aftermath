pathogen = {
  pathogens = {},
  infections = {},
  fluids = {},
}

dofile( minetest.get_modpath( "pathogen" ) .. "/options.lua" ) --WIP
dofile( minetest.get_modpath( "pathogen" ) .. "/recipes.lua")
dofile( minetest.get_modpath( "pathogen" ) .. "/api.lua" )
dofile( minetest.get_modpath( "pathogen" ) .. "/tools.lua" )
dofile( minetest.get_modpath( "pathogen" ) .. "/crafts.lua" )
dofile( minetest.get_modpath( "pathogen" ) .. "/nodes.lua" )
dofile( minetest.get_modpath( "pathogen" ) .. "/commands.lua" )
