minetest.register_privilege('pathogen', "infect and cure players of pathogens")

minetest.register_chatcommand("infect", {
  params = "<pathogen> <player>",
  description = "infect a player with a pathogen",
  privs = { pathogen=true },
  func = function(name, params)
    local params = params:split(' ')
    local player_name = params[1]
    local pathogen_name = params[2]
    if not minetest.get_player_by_name( player_name ) then
      minetest.chat_send_player(name, 'could not infect: player '..player_name..' does not exist')
    end
    local _pathogen = pathogen.get_pathogen( pathogen_name )
    if _pathogen then
      local infection = pathogen.infect( _pathogen, player_name )
      if infection then
        minetest.chat_send_player(name, 'infected: '..player_name..' with '..pathogen_name )
      else
        minetest.chat_send_player(name, 'could not infect: '..pathogen_name..' is immune')
      end
    else
      minetest.chat_send_player(name, 'could not infect: pathogen '..pathogen_name..' does not exist')
    end
  end
})

minetest.register_chatcommand("pathogens", {
  params = "",
  description = "list all available pathogens",
  privs = {},
  func = function(name, params)
    local pathogens = pathogen.get_pathogens()
    for key, _pathogen in pairs( pathogens ) do
      if _pathogen.description then
        minetest.chat_send_player( name, _pathogen.name..' - '.._pathogen.description )
      else
        minetest.chat_send_player( name, _pathogen.name )
      end
    end
  end
})

minetest.register_chatcommand("immunize", {
  params = "<pathogen> <player>",
  description = "immunize a player from an infection",
  privs = { pathogen=true },
  func = function(name, params)
    local params = params:split(' ')
    local player_name = params[1]
    local pathogen_name = params[2]
    local infection = pathogen.get_infection( player_name, pathogen_name )
    if infection then
      pathogen.immunize( infection )
      minetest.chat_send_player(name, 'immunized: player '..player_name..' from '..pathogen_name)
    else
      minetest.chat_send_player(name, 'could not immunize: infection does not exist' )
    end
  end
})
