Beware the dark [bewarethedark]
=================

A Minetest mod where darkness simply kills you directly

Version: 0.3.3

License:
  Code: LGPL 2.1 (see included LICENSE file)
  Textures: CC-BY-SA (see http://creativecommons.org/licenses/by-sa/4.0/)

Report bugs or request help on the forum topic.

Description
-----------

This is a mod for MineTest. It's only function is to make
darkness and light a valid mechanic for the default minetest_game.
In other voxel games, darkness is dangerous because it spawns
monsters. In MineTest, darkness just makes it more likely for you
to walk into a tree.

This mod changes that in a very direct fashion: you are damaged
by darkness, the darker the damager. So craft those torches!

Current behavior
----------------

If you stand in a node with light level 7 or less, you slowly
lose "sanity", represented by a hud bar with eyes. The darker it is,
the more sanity you lose per second. When you run out of sanity,
you get damaged instead!

Stand in bright light to replenish sanity. Sunlight is best, but
directly on top of a torch should work, too.

Future plans
------------

None at the moment.

Dependencies
------------
* hud (optional): https://forum.minetest.net/viewtopic.php?f=11&t=6342 (see HUD.txt for configuration)
* hudbars (optional): https://forum.minetest.net/viewtopic.php?f=11&t=11153

Installation
------------

Unzip the archive, rename the folder to to `bewarethedark` and
place it in minetest/mods/

(  Linux: If you have a linux system-wide installation place
    it in ~/.minetest/mods/.  )

(  If you only want this to be used in a single world, place
    the folder in worldmods/ in your worlddirectory.  )

For further information or help see:
http://wiki.minetest.com/wiki/Installing_Mods
