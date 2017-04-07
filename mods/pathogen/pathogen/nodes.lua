pathogen.register_fluid( 'vomit' )
pathogen.register_fluid( 'blood' )
pathogen.register_fluid( 'feces' )

if not minetest.get_modpath( "xpanes" ) then

  minetest.register_node("pathogen:fence", {
    description = "Infection Hazard Fence",
    drawtype = 'nodebox',
    tiles = {"pathogen_fence.png"},
    inventory_image = 'pathogen_fence.png',
    paramtype = "light",
    sunlight_propagates = true,
    paramtype2 = "facedir",
    is_ground_content = false,
    groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
    sounds = default.node_sound_wood_defaults(),
    node_box = {
      type = 'fixed',
      fixed = {
        {-0.5, -0.5, 63/128,
          0.5, 0.5 , 63/128},
      }
    },
  })

else

  xpanes.register_pane("fence_warning", {
    description = "Infection Hazard Fence",
    tiles = {"pathogen_fence.png"},
    drawtype = "airlike",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    air_equivalent = true,
    textures = {"pathogen_fence.png", "pathogen_fence.png", 'xpanes_space.png'},
    inventory_image = "pathogen_fence.png",
    wield_image = "pathogen_fence.png",
    groups = {snappy=2, cracky=3, oddly_breakable_by_hand=3, pane=1},
    recipe = pathogen.recipes['xpanes:fence_warning']
  })

end
