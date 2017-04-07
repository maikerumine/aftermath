-----------
--PATHOGENS
-----------
pathogen.register_pathogen = function( pathogen_name, definition )
  --checks if pathogen is registererd and registers if not
  ----
  if not pathogen.get_pathogen( pathogen_name ) then
    definition.name = pathogen_name;
    pathogen.pathogens[pathogen_name] = definition
    return pathogen.pathogens[pathogen_name]
  else
    return false
  end
end

pathogen.get_pathogen = function( pathogen_name )
  --get the table of a particular pathogen
  ----
  return pathogen.pathogens[pathogen_name]
end

pathogen.get_pathogens = function()
  --gives all the pathogens that are registered
  ----
  return pathogen.pathogens
end
--------------
--CONTAMINENTS
--------------
pathogen.spawn_fluid = function( name, pos, pathogen_name )
  --spawn the infectious juices
  ----
  if minetest.get_node( pos ).name == "air" then
    local node_name = "pathogen:fluid_"..name
    minetest.set_node( pos, { name = node_name, param2=1 } )
    pathogen.contaminate( pos, pathogen_name )
  end
end

pathogen.register_fluid = function( name )
  --registering a fluid(juice). This assumes that all fluids are flat on the
  --floor
  ------
  local texture = "pathogen_fluid_"..name..".png"
  local node_name = "pathogen:fluid_"..name
  pathogen.fluids[ name ] = node_name
  minetest.register_node( node_name, {
    description= name,
    drawtype = "signlike",
    inventory_image = texture,
    tiles = { texture },
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    sunlight_propagates = true,
    drop = "",
    groups = { oddly_breakable_by_hand = 2, crumbly = 2 },
    on_punch = function(pos, node, puncher, pointed_thing)
      local meta = minetest.get_meta( pos )
      local pathogen_name = meta:get_string( "pathogen" )
      local player_name = puncher:get_player_name()
      local _pathogen = pathogen.get_pathogen( pathogen_name )
      if _pathogen then
        pathogen.infect( _pathogen, player_name )
      end
    end,
    selection_box = {
      type = "fixed",
      fixed = {-0.5, -0.5, -0.5, 0.5, -7.9/16, 0.5},
    },
  })
end

pathogen.contaminate = function( pos, pathogen_name )
  --contaminates a node which when dug infects the player that dug the node
  ----
  local meta = minetest.get_meta( pos )
  if meta then
    meta:set_string( 'pathogen', pathogen_name )
    return true
  else
    return false
  end
end

pathogen.decontaminate = function( pos )
  --remove the contamination from the node
  ----
  local meta = minetest.get_meta( pos )
  if meta then
    local str = meta:get_string('pathogen')
    if str ~= '' then
      meta:set_string( 'pathogen', '' )
      return true
    else
      return false
    end
  else
    return false
  end
end

pathogen.get_contaminant = function( pos )
  --used to check if the node is infected and to get the name of the pathogen
  --with which it is infected
  ------
  local meta = minetest.get_meta( pos )
  if not meta then return false end
  local pathogen_name = meta:get_string( 'pathogen' )
  if pathogen_name then
    if pathogen_name ~= '' then
      return pathogen_name
    else
      return false
    end
  else
    return false
  end
end
------------
--INFECTIONS
------------
pathogen.infect = function( _pathogen, player_name )
  --infects the player with a pathogen. If not able returns false
  ----
  local infection = pathogen.get_infection( player_name, _pathogen.name )
  if ( infection ~= nil ) then
    --return false if pathogen does not exist or player is immune
    if ( infection.immune ) then return false end
  end
    --consider making an is_immune function
    ----
  local infection = {
    --The table containing all the data that a infection cinsists out of. See
    --the README.md for a more extensive explanation
    -----
    id = player_name.._pathogen.name,
    symptom = 0,
    pathogen = _pathogen,
    immune = false,
    player = player_name
  }

  pathogen.infections[ player_name.._pathogen.name ] = infection
    --store the infection in a table for later use. This table is also saved and
    --loaded if the persistent option is set
    ------
  local on_infect = _pathogen.on_infect
  if on_infect then
    --check if on_infect has been registered in pathogen
    ----
    if minetest.get_player_by_name( player_name ) then
      on_infect( infection )
    end
  end
    --perform the on_infect command that is defined in the regsiter function
    --this is not the same as the on_symptoms. It is called only once at the
    --beginning of the infection
    --------
  minetest.after( _pathogen.latent_period, function()
    --latent perios is the time till the first symptom shows
    ----
    pathogen.perform_symptom( infection,  0 )
      --show the first symptom
      ----
  end)
  return infection
end

pathogen.perform_symptom = function( infection, symptom )
  --An infection can also be initiated without having to perform the on_infect.
  --you can can cut straight to a particular symptom by using this function
  --notice the symptom_n argument. This is a number that determines the state of
  --the infection.
  ----------
  if infection.immune then return false end
  --only keep showing symptoms if there is no immunity against the pathogen
  ----
  local symptom = symptom + 1
  if ( infection.pathogen.symptoms >= symptom ) then --check if all symptoms have occured
    --only show symptoms if not all symptoms have occured.
    ----
    infection.symptom = symptom

    local on_symptom = infection.pathogen.on_symptom
    if on_symptom then 
      if minetest.get_player_by_name( infection.player ) then
        on_symptom( infection ) 
      end
    end

    local interval = ( ( infection.pathogen.infection_period - infection.pathogen.latent_period ) / infection.pathogen.symptoms )
    minetest.after(  interval , function()
      --set the time till the next symptom and then perfrom it again
      --
      pathogen.perform_symptom( infection, symptom )
    end)
    infection.symptom = symptom
    return true
  elseif ( infection.pathogen.symptoms < symptom ) then
    ----
    --survives and is now immunized, immunization lasts till the server is
    --restarted
    ------
    local on_recover = infection.pathogen.on_recover
    if on_recover and ( infection.pathogen.symptoms+1 == symptom ) then
      pathogen.immunize( infection )
      local result = on_recover( infection )
      if minetest.get_player_by_name( infection.player ) then
        on_recover( infection )
      end
      return true
    else
      return false
    end
  else
    return false
  end
end

pathogen.immunize = function( infection )
  --immunize a player so the next symptom won't show. It also disables the
  --abilty to reinfect the player. Use pathogen.disinfect to also remove
  --the immunization It will also trigger the on_cured when the next symptom
  --would have triggered.
  ----
  if infection.immune == true then
    --do not immunize if alread y immunized, return false
    --
    return false
  else
    --else immunize the player and return true
    infection.immune = true
    return true
  end
end

pathogen.disinfect = function( infection )
  --removes the immunization and the infection all together
  ----
  if pathogen.infections[ infection.player..infection.pathogen.name ] then
    --only is the is infected does it do this, return true
    pathogen.infections[ infection.player..infection.pathogen.name ]= nil
    return true
  else
    -- else it will only return false
    return false
  end
end

pathogen.get_infection = function( player_name,  pathogen_name )
  --get an infection of a certain player
  ----
  if player_name and pathogen_name then
    --only if the infection is registered
    return pathogen.infections[ player_name..pathogen_name ]
  else
    --otherwise return nil
    return nil
  end
end

pathogen.get_infections = function( )
  --gives all the infections of all the players. If not infections are defined
  --it returns an empty table. That's it.
  return pathogen.infections
end

pathogen.get_player_infections = function( player_name )
  --helper function for getting the infections of a certain player
  ----
  local infections = pathogen.get_infections()
  local output = {}
  for index, infection in pairs(infections) do
    --gets and loops through the infections
    ----
    if infection.player == player_name then
      --and adds the infection to the output of matches the player_name
      output[#output+1] = infection
    end
  end
  return output
end

-------------
--PERSISTENCE
-------------

-------------
--PERSISTENCE
-------------

pathogen.save = function( )
  --TODO save the infections so it won"t get lost between server reloads
  local serialized = minetest.serialize( infections )
  return serialized
end

pathogen.load = function( )
  --TODO reinfect the players when they rejoin the server. it remembers the
  --infection fase thus the infection continues and does not get reset.
  local deserialized = minetest.deserialize(string)
  return deserialized
end

---------
--HELPERS
---------

---------
--HELPERS
---------

pathogen.get_players_in_radius = function( pos, radius )
  --helper to get players within the radius.
  ----
  local objects = minetest.get_objects_inside_radius(pos, 5)
  local players = {}
  for index, object in ipairs(objects) do
    --loops threw all objects in within a radius
    ----
    if object:is_player() then
      --and check if the object is a player
      players[#players+1] = object
    end
  end
  return players
end

pathogen.on_dieplayer = function( player )
  --when dying while having a pathogen it will trigger the on_death of the
  --pathogen and it will remove all player infections
  ----
  local player_name = player:get_player_name()
  local _infections = pathogen.get_player_infections( player_name )
  for index, infection in pairs(_infections) do
    --loops through the player infections
    ----
    local _pathogen = pathogen.get_pathogen( infection.pathogen )
    if _pathogen then
      --checks if it is a valid and still registered pathogen
      ----
      local on_death = _pathogen.on_death
      if on_death then
        --it then triggers the on_death if the on_death is defined
        pathogen.disinfect( infection )
        on_death( infection )
        return true
      end
    end
  end
  return false
end

pathogen.on_dignode = function( pos, digger )
  --infects players that dig a node that is infected with a pathogen
  ----
  local pathogen_name = pathogen.get_contaminant( pos )
  if  pathogen_name then
    local _pathogen = pathogen.get_pathogen( pathogen_name )
    local player_name = digger:get_player_name( )
    return pathogen.infect( _pathogen, player_name )
  end
  return false
end

minetest.register_on_dignode( function( pos, oldnode, digger)
  pathogen.on_dignode( pos, digger )
end)

minetest.register_on_dieplayer( function( player )
  pathogen.on_dieplayer( player )
end)

