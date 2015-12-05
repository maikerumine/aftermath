-- Holocaust created by maikerumine and Aiden Garvin
-- Minetest 0.4.13 game: "Holocaust"
-- namespace: holocaust
-- (c) 2014-2015 by: maikerumine and Aiden Garvin
-- https://github.com/maikerumine
-- LGPLv2.1  (SEE BOTTOM)
-- Inspired by Blockmen's Wasteland game.  https://github.com/BlockMen/Wasteland/releases/tag/0.5
=======================

INTRODUCTION:
_____________

You awaken in the centre of a rustic village after a long while, time seems to have forgotten about you, as you did it.  You realise there was a great war, a total catastrophy, nothing is as it seems.  There are killers out at night to raid and loot your things, as well as an unidentified creature of some sort..  You look in yout inventory and find an assortment of items, some of which are firearms and wood.
The realisation that you have to survuve at all costs is awakening, your adreneline starts to pump as you make haste to the nearest abandoned building to look for things for this epic adventure.
Can you survive a night?
Can you make it a week?
Can your mind accept that this is life after the great war?
You must start again, from scratch, in a bombed out radioactive world.
This is HOLOCAUST.


          _______  _        _______  _______  _______           _______ _________
|\     /|(  ___  )( \      (  ___  )(  ____ \(  ___  )|\     /|(  ____ \\__   __/
| )   ( || (   ) || (      | (   ) || (    \/| (   ) || )   ( || (    \/   ) (
| (___) || |   | || |      | |   | || |      | (___) || |   | || (_____    | |
|  ___  || |   | || |      | |   | || |      |  ___  || |   | |(_____  )   | |
| (   ) || |   | || |      | |   | || |      | (   ) || |   | |      ) |   | |
| )   ( || (___) || (____/\| (___) || (____/\| )   ( || (___) |/\____) |   | |
|/     \|(_______)(_______/(_______)(_______/|/     \|(_______)\_______)   )_(

CREATED BY:
___________
The great team at minetest.net for a collaboration of ideas, mods, and friendship.
Celeron C55: for creating minetest in his house back in 2010. http://wiki.minetest.net/Main_Page
Maikerumine: for the "hack-coding"
Aiden Garvin: for the idea for gameplay
Blockmen: for the original minetest concept in his Wasteland game
And read the readme's in the mod section for all other contributers

NOTES:
There are NO diamond or Mese tools in game.  Let's be realistic folks, any crystal would shatter and a complete diamond tool would be unrealistic.  Mese can be used to craft guns- see crafting guide in game.

CRAFTING:
_________
See included crafting guide in inventory for specifics.

To make clean farmable water:
*craft four cactus and a bucket.
*cook a bucket of clean water.
*to get bucket of clean water: bucket of toxic water+sand_gravel.

To make mese shards (it is not in ore generation after the nuclear war.)
*find in village chest.
*craft obsidian shard+copper_ingot+glass = mese_shard_stasis.
*cook mese_shard_stasis for mese shard.
*nine mese shards make mese crystal.

TO GET WOOD:
*chop using axe
*craft four sticks to make wood planks
*punch leaves for sticks
*plant only on green grass, all other dirt is non growable.

RADIATION:
__________
Radiation code was taken from the tehcnic mod: https://github.com/minetest-technic/technic
*The dried lake beds are filled with radioactive water and mud.
*The mud is very radioactive, you will be dead before you even touch it.
*The glimmering green toxic water is dangerous, but you can scoop up with bucket to refine.
*The HUD isn't working as of this release.
*Good luck roaming at night!

MINING:
_______
*The dig levels are much tougher, you will need steel pick to mine stone.
*The way to mine is find a cave and explore it like you would in real life.
*craft TNT to clear more stone
*Diamonds are used for protection blocks
*gold_lump is used to pay npc for random item.

Building:
_________
*This ain't minecraft.
*This is MUCH harder.
*You will need an axe to chop all wooden items except bookshelf and bed.
*most dirt and clay must be dug with shovel
*always keep one axe in your inventory or you will get stuck.  It might be wise to have a spawn function.

Mobs:
_____
Maikerumines smart mobs and blockmens creatures mobs (with changed texture) are what you will encounter here.
*Monsters are bad.
*Some NPC's are bad, you will figure this out on your first night.
*Good NPC's will help fight bad monsters.
*NPC's are your best option from escaping an attack.
*Right click NPC to command them to your side.
*Give bread or meat to heal them.
*Give gold_lump to recieve random item.
*Cook rotten flesh to make edible meat.
--https://github.com/maikerumine/esmobs
--https://github.com/BlockMen/creatures


FARMING:
________
Tenplus1's great farming mod.
*Pretty awesome and incorporated into village chests, you will have food if you explore.
*Use food in hand to plant seed of same food type except wheat and cotton.
*You will never run out of food if you make a farm.
--https://github.com/tenplus1/farming

HUD:
____
THERE ARE SOME HUDS HERE...  This may be optimised in the future.
http://repo.or.cz/w/minetest_hudbars.git
https://github.com/BlockMen/hunger
https://github.com/BlockMen/hud
--Beware The Dark is renamed to Radiation, currently trying to get the radiation to show up  so this is WIP.
https://forum.minetest.net/viewtopic.php?f=11&t=12845&hilit=beware+the+dark

ARMOR:
______
*YOU only have WOOD, IRON, GOLD, and BRONZE
*Future development will incorporate radiation to your armor protection.
https://github.com/stujones11/minetest-3d_armor--I believe the armor is the game is from Carbone though.

PROTECTOR:
__________
This is a modified version from TenPlus1's protector redo mod.
*Craft 8 stone around one diamond block.
*Protection is r5.
*You get Two protectors.
--https://github.com/tenplus1/protector

GUNS!:
______
A modified version of shooter:
--https://github.com/maikerumine/extreme_survival/tree/master/mods/shooter

VILLAGES: A.K.A. SOKOMINE's amasing compilation with a few expert Minetest coders, please read the readme's.
_________
This one is tricky...  I have re-coded a few things for this game, specifically: the chests, the mapgen, the trees, the buildings (some will look more bombed out due to having cottages installed but only for the hammer and anvil.
*Villages are your bread and butter. YOu will need to stay a night or to on your initial experience with this game.
*Right click traders to buy things, this comes in very handy.
*Chests will have MUCH to loot, the world is never ending, have fun.
*Type "/visit "#"" to teleport to a nearby village.
*Type "/vmap" to see surrounding villages.
*Did I mention these villages are your bread and butter?
*Make a base in a far away village for optimum safety against online players, however, if you got there, they will get there too.

--https://github.com/maikerumine/holocaust/tree/master/mods/mg_villages
--https://github.com/Sokomine/village_modern_houses
--https://github.com/Sokomine/cottages
--https://github.com/Sokomine/handle_schematics
--https://github.com/Sokomine/mobf_trader
--https://github.com/Sokomine/village_gambit
--https://github.com/Sokomine/village_towntest


INSTALLATION:
_____________
Extract this game into your games folder and rename the folder to "holocaust"
In the mods folder in holocaust:
Minetest/games/mods
extract the esmobs and bones to this directory.
For some reason github won't let me inclust the folders to the game due to a conflict.




License of source code:
-----------------------
LGPLv2.1 for holocaust game, based off of minetest_game (SEE BOTTOM FOR ORIGINAL LICENsE INFO.)
WTFPL or otherwise stated in mods.

License of media:
-----------------------

Any Custom texture from maikerumine:
Maikerumine (CC BY-SA 3.0)
INSERT LIST HERE

or otherwise stated in mods included in this subgame.





The main game for the Minetest game engine [minetest_game]
==========================================================

To use this game with Minetest, insert this repository as
  /games/minetest_game
in the Minetest Engine.

The Minetest Engine can be found in:
  https://github.com/minetest/minetest/

Compatibility
--------------
The minetest_game github master HEAD is generally compatible with the github
master HEAD of minetest.

Additionally, when the minetest engine is tagged to be a certain version (eg.
0.4.10), minetest_game is tagged with the version too.

When stable releases are made, minetest_game is packaged and made available in
  http://minetest.net/download
and in case the repository has grown too much, it may be reset. In that sense,
this is not a "real" git repository. (Package maintainers please note!)

License of source code
----------------------
Copyright (C) 2010-2012 celeron55, Perttu Ahola <celeron55@gmail.com>
See README.txt in each mod directory for information about other authors.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 2.1 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

License of media (textures and sounds)
--------------------------------------
Copyright (C) 2010-2012 celeron55, Perttu Ahola <celeron55@gmail.com>
See README.txt in each mod directory for information about other authors.

Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)
http://creativecommons.org/licenses/by-sa/3.0/

License of menu/header.png
Copyright (C) 2013 BlockMen CC BY-3.0
