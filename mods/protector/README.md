Protector Redo mod [protect]

Protector redo for minetest is a mod that protects a players builds by placing
a block that stops other players from digging or placing blocks in that area.

based on glomie's mod, remade by Zeg9 and reworked by TenPlus1.

https://forum.minetest.net/viewtopic.php?f=11&t=9376

Released under WTFPL

0.1 - Initial release
0.2 - Texture update
0.3 - Added Protection Logo to blend in with player builds
0.4 - Code tweak for 0.4.10+
0.5 - Added protector.radius variable in init.lua (default: 5)
0.6 - Added Protected Doors (wood and steel) and Protected Chest
0.7 - Protected Chests now have "To Chest" and "To Inventory" buttons to copy
      contents across, also chests can be named
0.8 - Updated to work with Minetest 0.4.12, simplified textures
0.9 - Tweaked code
1.0 - Only owner can remove protector
1.1 - Set 'protector_pvp = true' in minetest.conf to disable pvp in protected
      areas except your own, also setting protector_pvp_spawn higher than 0 will
      disable pvp around spawn area with the radius you entered
1.2 - Shift and click support added with Minetest 0.4.13 to quickly copy stacks
      to and from protected chest
1.3 - Moved protector on_place into node itself, protector zone display changed
      from 10 to 5 seconds, general code tidy
1.4 - Changed protector recipes to give single item instead of 4, added + button
      to interface, tweaked and tidied code, added admin command /delprot to remove
      protectors in bulk from banned/old players
1.5 - Added much requested protected trapdoor
1.6 - Added protector_drop (true or false) and protector_hurt (hurt by this num)
      variables to minetest.conf settings to stop players breaking protected
      areas by dropping tools and hurting player.
1.7 - Included an edited version of WTFPL doors mod since protected doors didn't
      work with the doors mod in the latest daily build... Now it's fine :)

Usage: (requires server privelage)

list names to remove

	/delprot

remove specific user names

	/delprot name1 name2

remove all names from list

	/delprot -

Whenever a player is near any protectors with name1 or name2 then it will be
replaced by an air block.