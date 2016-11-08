--mobs_fallout v0.0.4
--maikerumine
--made for Aftermath game


local path = minetest.get_modpath("mobs_fallout")


minetest.register_alias("creatures:rotten_flesh", "mobs:meat")
minetest.register_alias("creatures:zombie", "mobs_fallout:sheep")
minetest.register_alias("creatures:ghost", "mobs_fallout:sheep")
mobs:alias_mob("creatures:zombie", "mobs_fallout:sheep")
mobs:alias_mob("creatures:ghost", "mobs_fallout:sheep")
mobs:alias_mob("creatures:zombie_spawner_dummy", "mobs_fallout:sheep")
mobs:alias_mob("creatures:ghost_spawner_dummy", "mobs_fallout:sheep")
minetest.register_alias("creatures:zombie_spawner", "default:dirt")
minetest.register_alias("creatures:ghost_spawner", "default:dirt")