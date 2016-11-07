
vault_spawn = {}
vault_spawn.pos = {x=-189, y=3, z=67}
vault_spawn.pos2 = {x=0, y=-100, z=0}

if minetest.setting_get_pos("static_spawnpoint") then
    vault_spawn.pos = minetest.setting_get_pos("static_spawnpoint")
end

minetest.register_chatcommand("spawn", {
    description = "Teleport you to an abandoned town.",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if player == nil then
            -- just a check to prevent the server crashing
            return false
        end
        local pos = player:getpos()
        if pos.x>-20 and pos.x<20 and pos.y>-20 and pos.z>-20 and pos.z<20 then
        
        else
            player:setpos(vault_spawn.pos)
            minetest.chat_send_player(name, "Teleported to topside!")
        end
    end,
})

minetest.register_chatcommand("vault2017", {
    description = "Teleport you to the vault.",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if player == nil then
            -- just a check to prevent the server crashing
            return false
        end
        local pos = player:getpos()
        if pos.x>-20 and pos.x<20 and pos.y>-20 and pos.z>-20 and pos.z<20 then
        
        else
            player:setpos(vault_spawn.pos2)
            minetest.chat_send_player(name, "Teleported to vault!")
        end
    end,
})