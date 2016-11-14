vignette = {
  huds = {}
}

vignette.set = function (defs)

  for i=1, math.max(defs.darkness, #vignette.huds) do
    --
    -- adding huds
    if (i >= #vignette.huds) then
      local hud_id=defs.player:hud_add({
        hud_elem_type = "image",
        position = {x = 0.5, y = 0.5},
        scale = {
          x = -100,
          y = -100
        },
        text = "vignette.png"
      })
      vignette.huds[defs.player][i] = hud_id;
    end

    -- removing huds
    if (i > defs.darkness) then
      defs.player:hud_remove(vignette.huds[defs.player][i])
    end
  end
end

vignette.add = function (defs)
  defs.darkness = math.max(defs.darkness + #vignette.huds[defs.player], 0)
  vignette.set(defs)
end

minetest.register_on_joinplayer(function (player)
  vignette.huds[player] = {}
  vignette.set({
    darkness = 1,
    player = player
  })
end)
