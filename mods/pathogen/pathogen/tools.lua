minetest.register_tool( 'pathogen:decontaminator', {
  description = 'Decontaminator',
  inventory_image = "pathogen_decontaminator.png",
  on_use = function(itemstack, user, pt)
    minetest.sound_play( 'pathogen_spray', { pos = user:getpos(), gain = 0.2, max_hear_distance = 5 })
    if not pt then return itemstack end
    if math.random(5) == 1 then return itemstack end
    pathogen.decontaminate( pt.under )
  end
})
