--[[

Persistent player attributes (mixin)
====================================

A mixin to provide persistent player attributes. Simply include and do
this file in your mod, it will take care to update itself.

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

local global_exists = minetest.global_exists or function(name) rawget(_G, name) end
if not global_exists('persistent_player_attributes') then
    persistent_player_attributes = {
        -- trigger "newer version available" below
        version = 0.000,
    }
end

--[[

DO NOT RESET THE GLOBAL VARIABLE!

The following code *and library users* localize the (overly long)
library global variable. If another mod later includes a newer version
of this library, and this newer version changes the global variable
"persistent_player_attributes", then the mods which previously
included this mixin may *or may not* be using the old version.
Chaos will certainly ensue.

]]

--[[
Helper functions that take care of the conversions *and* the
clamping for us
]]

local function _count_for_val(value, def)
    local count = math.floor((value - def.min) / (def.max - def.min) * 65535)
    if count < 0 then count = 0 end
    if count > 65535 then count = 65535 end
    return count
end
local function _val_for_count(count, def)
    local value = count / 65535 * (def.max - def.min) + def.min
    if value < def.min then value = def.min end
    if value > def.max then value = def.max end
    return value
end
-- end helper functions


-- Version: 1.0.1 - with read cache

local PPA = persistent_player_attributes

if PPA.version < 1.000 then

    -- the version, minor and patch are in thousandths,
    -- e.g. 1.2.3 becomes 1.002003

    PPA.version = 1.000

    -- the stash of registered attributes

    PPA.defs = {--[[
        name = {
            name = "mymod_attr1",
            min = 0,
            max = 10,
            default = 5,
        },
    ]]}

    --[[
    How to register a new attribute, with named parameters:
       PPA.register({ name = "mymod_attr1", min = 0, ... })
    ]]

    PPA.register = function(def)
        PPA.defs[def.name] = {
            name = def.name,
            min = def.min or 0.0,
            max = def.max or 1.0,
            default = def.default or def.min or 0.0,
        }
    end

    --[[
    We cannot override / take back a register_on_joinplayer,
    so we'll only create and register this one, which calls the
    (overridable) actual handler
    ]]
    if not PPA.shim_on_joinplayer then
        PPA.shim_on_joinplayer = function(player)
            PPA.on_joinplayer(player)
        end
        minetest.register_on_joinplayer(PPA.shim_on_joinplayer)
    end


end

if PPA.version < 1.000001 then

    PPA.version = 1.000001 -- 1.0.1

    PPA.read_cache = {--[[
        player_name = {
            attr1 = value1,
            attr2 = value2,
        },
    ]]}

    -- The actual on_joinplayer handler

    PPA.on_joinplayer = function(player)
        local inv = player:get_inventory()
        local player_name = player:get_player_name()
        PPA.read_cache[player_name] = {}
        for name, def in pairs(PPA.defs) do
            inv:set_size(name, 1)
            if inv:is_empty(name) then
                -- set default value
                inv:set_stack(name, 1, ItemStack({ name = ":", count = _count_for_val(def.default, def) }))
                -- cache default value
                PPA.read_cache[player_name][name] = def.default
            end
        end
    end

    --[[ get an attribute, procedural style:
        local attr1 = PPA.get_value(player, "mymod_attr1")
    ]]

    PPA.get_value = function(player, name)
        local player_name = player:get_player_name()
        if PPA.read_cache[player_name][name] == nil then
            local def = PPA.defs[name]
            local inv = player:get_inventory()
            local count = inv:get_stack(name, 1):get_count()
            PPA.read_cache[player_name][name] = _val_for_count(count, def)
        end
        return PPA.read_cache[player_name][name]
    end

    --[[ set an attribute, procedural style:
        PPA.set_value(player, "mymod_attr1", attr1)
    ]]

    PPA.set_value = function(player, name, value)
        local def = PPA.defs[name]
        local inv = player:get_inventory()
        local player_name = player:get_player_name()
        PPA.read_cache[player_name][name] = value
        inv:set_stack(name, 1, ItemStack({ name = ":", count = _count_for_val(value, def) }))
    end

end

