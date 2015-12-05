--[[

Beware the Dark [bewarethedark]
==========================

A mod where darkness simply kills you outright.

Copyright (C) 2015 Ben Deutsch <ben@bendeutsch.de>

License
-------

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
USA

]]


radiation = {

    -- configuration in radiation.default.conf

    -- per-player-stash (not persistent)
    players = {
        --[[
        name = {
            pending_dmg = 0.0,
        }
        ]]
    },

    -- global things
    time_next_tick = 0.0,
}
local M = radiation

dofile(minetest.get_modpath('radiation')..'/configuration.lua')
local C = radiation.config

dofile(minetest.get_modpath('radiation')..'/persistent_player_attributes.lua')
local PPA = persistent_player_attributes

dofile(minetest.get_modpath('radiation')..'/hud.lua')

PPA.register({
    name = 'radiation_radiation',
    min  = 0,
    max  = 20,
    default = 20,
})
--problems
minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    local pl = M.players[name]
    if not pl then
        M.players[name] = { pending_dmg = 0.0 }
        pl = M.players[name]
        M.hud_init(player)
    end
end)

minetest.register_on_dieplayer(function(player)
    local name = player:get_player_name()
    local pl = M.players[name]
    pl.pending_dmg = 0.0
    local radiation = 20
    PPA.set_value(player, "radiation_radiation", radiation)
    M.hud_update(player, radiation)
end)



--ADD RADIATION HERE



--[[
--ORIG CODE
minetest.register_globalstep(function(dtime)

    M.time_next_tick = M.time_next_tick - dtime
    while M.time_next_tick < 0.0 do
        M.time_next_tick = M.time_next_tick + C.tick_time
        for _,player in ipairs(minetest.get_connected_players()) do

            if player:get_hp() <= 0 then
                -- dead players don't fear the dark
                break
            end

            local name = player:get_player_name()
            local pl = M.players[name]
            local pos  = player:getpos()
            local pos_y = pos.y
            -- the middle of the block with the player's head
            pos.y = math.floor(pos_y) + 1.5
            local node = minetest.get_node(pos)

            local light_now   = minetest.get_node_light(pos) or 0
            if node.name == 'ignore' then
                -- can happen while world loads, set to something innocent
                light_now = 9
            end

            local dps = C.damage_for_light[light_now]
            --print("Standing in " .. node.name .. " at light " .. light_now .. " taking " .. dps);

            if dps ~= 0 then
                local radiation = PPA.get_value(player, "radiation_radiation")

                radiation = radiation - dps
                --print("New radiation "..radiation)
                if radiation < 0.0 and minetest.setting_getbool("enable_damage") then
                    pl.pending_dmg = pl.pending_dmg - radiation
                    radiation = 0.0

                    if pl.pending_dmg > 0.0 then
                        local dmg = math.floor(pl.pending_dmg)
                        --print("Deals "..dmg.." damage!")
                        pl.pending_dmg = pl.pending_dmg - dmg
                        player:set_hp( player:get_hp() - dmg )
                    end
                end

                PPA.set_value(player, "radiation_radiation", radiation)

                M.hud_update(player, radiation)
            end
        end
    end
end)



--ORIG CODE

minetest.register_globalstep(function(dtime)

    M.time_next_tick = M.time_next_tick - dtime
    while M.time_next_tick < 0.0 do
        M.time_next_tick = M.time_next_tick + C.tick_time
        for _,player in ipairs(minetest.get_connected_players()) do

            if player:get_hp() <= 0 then
                -- dead players don't fear the dark
                break
            end

            local name = player:get_player_name()
            local pl = M.players[name]
            local pos  = player:getpos()
            local pos_y = pos.y
            -- the middle of the block with the player's head
            pos.y = math.floor(pos_y) + 1.5
            local node = minetest.get_node(pos)

--ADD RADIOACTIVE HERE    minetest.registered_nodes[node.name].groups.radioactive

            local light_now   = minetest.get_node_light(pos) or 0
            if node.name == 'ignore' then
                -- can happen while world loads, set to something innocent
                light_now = 9
            end

            local dps = C.damage_for_light[light_now]--change to radioactive group
            --print("Standing in " .. node.name .. " at light " .. light_now .. " taking " .. dps);

            if dps ~= 0 then
                local radiation = PPA.get_value(player, "radiation_radiation")

--END RADIOACTIVE HERE

                radiation = radiation - dps
                --print("New radiation "..radiation)
                if radiation < 0.0 and minetest.setting_getbool("enable_damage") then
                    pl.pending_dmg = pl.pending_dmg - radiation
                    radiation = 0.0

                    if pl.pending_dmg > 0.0 then
                        local dmg = math.floor(pl.pending_dmg)
                        --print("Deals "..dmg.." damage!")
                        pl.pending_dmg = pl.pending_dmg - dmg
                        player:set_hp( player:get_hp() - dmg )
                    end
                end

                PPA.set_value(player, "radiation_radiation", radiation)

                M.hud_update(player, radiation)
            end
        end
    end
end)

]]
