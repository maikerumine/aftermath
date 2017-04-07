pathogen.register_pathogen("panola", {
  description = "Panola virus is highly contagious. It spreads threw bodily fluids.",
  symptoms = 20,
  latent_period = 840,
  infection_period = 1200,
  on_death = function( infection )
    local _player = minetest.get_player_by_name( infection.player )
    local _pos = _player:getpos()
    pathogen.spawn_fluid( "blood", _pos, infection.pathogen )
    minetest.sound_play( "pathogen_bleed", { pos = _pos, gain = 0.3} )
  end,
  on_symptom = function( infection )
    local player = minetest.get_player_by_name( infection.player )
    local pos = player:getpos()
    local hp = player:get_hp()
    if hp > 12 then
      player:set_hp( math.floor(hp /2 )  )
    else
      player:set_hp( hp - 1 )
    end
    if math.random(0, 1) == 1 then
      pathogen.spawn_fluid( "vomit", pos, infection.pathogen )
      minetest.sound_play( "pathogen_vomit", { pos = pos, gain = 0.3} )
    else
      pathogen.spawn_fluid( "feces", pos, infection.pathogen )
      minetest.sound_play( "pathogen_poop", { pos = pos, gain = 0.3} )
    end
  end
})
