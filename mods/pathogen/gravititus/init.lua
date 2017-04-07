local gravititus = {}

local set_player_gravity = function( player_name, gravity )
    local player = minetest.get_player_by_name( player_name )
    local pos = player:getpos()
    minetest.sound_play( "gravititus_hiccup", { pos = pos, gain = 0.3 } )
    player:set_physics_override({
      gravity = gravity
    })
end

pathogen.register_pathogen("gravititus", {
  description = "Occurs when ascending too quickly. Symptons are hiccups and random sense of gravity.",
  symptoms = 10,
  latent_period = 120,
  infection_period = 420,
  on_infect = function( infection )
    set_player_gravity( infection.player, 2 / math.random( 1, 5 ) )
    minetest.sound_play( "gravititus_hiccup", { pos = pos, gain = 0.3 } )
  end,
  on_symptom = function( infection )
    set_player_gravity( infection.player, 2/ math.random( 1, 5 ) )
    minetest.sound_play( "gravititus_hiccup", { pos = pos, gain = 0.3 } )
  end,
  on_death = function( infection )
    set_player_gravity( infection.player, 1 )
  end,
  on_cured = function( infection )
    set_player_gravity( infection.player, 1 )
  end
})

minetest.register_on_dignode( function( pos, node, digger )
  --determines when infection occurs.
  ----
  local pln = digger:get_player_name()
  local pos = pos
  local pre = gravititus[pln]
  gravititus[pln] = pos
  if ( pre == nil ) then
    minetest.after( 15, function()
      local pre = gravititus[pln]
      local dis = math.abs( pre.y - pos.y )
      if ( dis > 20 ) then
        local pat = pathogen.get_pathogen( 'gravititus' )
        pathogen.infect( pat, pln )
      end
      gravititus[pln] = nil
    end)
  end
end )
