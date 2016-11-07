beds.world_path = minetest.get_worldpath()
beds.beds_file = beds.world_path .. "/beds_spawns.json"
beds.writing_file = false

function beds.read_spawns()
	if beds.writing_file then
		-- wait until spawns are safed
        
        return
	end

    local file, err = io.open(beds.beds_file, "r")
    if err then
        beds.player_spawns = {}
        return
    end
    beds.player_spawns = minetest.deserialize(file:read("*all"))
    if type(beds.player_spawns) ~= "table" then
        beds.player_spawns = {}
    end
    file:close()
end

function beds.save_spawns()
    local datastring = minetest.serialize(beds.player_spawns)
    
    if not datastring then
        return
    end
	beds.writing_file = true
    local file, err = io.open(beds.beds_file, "w")
    if err then
        return
    end
    file:write(datastring)
    file:close()
	beds.writing_file = false
end

function beds.set_spawns()
	for name, pos in pairs(beds.player_sleeping) do
        local spawn = minetest.pos_to_string(pos)
		beds.player_spawns[name] = spawn
	end
	beds.save_spawns()
end

function beds.get_spawns()
    beds.read_spawns()
	for name, spawn in pairs(beds.player_spawns) do
        local pos = minetest.string_to_pos(spawn)
		beds.player_pos[name] = pos
	end
end

beds.get_spawns()