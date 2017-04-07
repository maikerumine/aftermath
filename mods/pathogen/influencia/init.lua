pathogen.register_pathogen("influencia", {
  description = "Highly contagious and possibly deadly for those with low health.",
  symptoms = 12,
  latent_period = 240,
  infection_period = 740,
  on_infect = function( infection )
    local _player = minetest.get_player_by_name( infection.player )
    local _pos = _player:getpos()
    minetest.sound_play( "pathogen_cough", { pos = _pos, gain = 0.3 } )
  end,
  on_symptom = function( infection )
    local player = minetest.get_player_by_name( infection.player )
    local pos = player:getpos()
    local players_nearby = pathogen.get_players_in_radius(pos, 5)
    local hp = player:get_hp()
    if hp <= 14 then
      player:set_hp( hp - 1 ) 
      if math.random(10) == 1 then
        player:set_hp( 6 ) 
      end
    end
    if math.random(2) == 1 then
    minetest.sound_play( "pathogen_sneeze", { pos = pos, gain = 0.3 } )
    else
    minetest.sound_play( "pathogen_cough", { pos = pos, gain = 0.3 } )
    end
    for index, player_nearby in ipairs(players_nearby) do
      local player_nearby_name = player_nearby:get_player_name()
      if player_nearby_name ~= infection.player then
        if math.random(3) == 1 then
          pathogen.infect( infection.pathogen, player_nearby_name )
        end
      end
    end
  end
})
