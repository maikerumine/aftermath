-- Check for necessary mod functions and abort if they aren't available.
if not minetest.get_biome_id then
	minetest.log()
	minetest.log("* Not loading Cityscape *")
	minetest.log("Cityscape requires mod functions which are")
	minetest.log(" not exposed by your Minetest build.")
	minetest.log()
	return
end

cityscape = {}
cityscape.version = "1.0"
cityscape.path = minetest.get_modpath(minetest.get_current_modname())
cityscape.first_flag = 0

cityscape.vacancies = tonumber(minetest.setting_get('cityscape_vacancies')) or 3
if cityscape.vacancies < 0 or cityscape.vacancies > 10 then
	cityscape.vacancies = 0
end
cityscape.desolation = tonumber(minetest.setting_get('cityscape_desolation')) or 9
if cityscape.desolation < 0 or cityscape.desolation > 10 then
	cityscape.desolation = 0
end
cityscape.suburbs = tonumber(minetest.setting_get('cityscape_suburbs')) or 2
if cityscape.suburbs < 0 or cityscape.suburbs > 10 then
	cityscape.suburbs = 5
end


minetest.register_on_mapgen_init(function(mgparams)
	minetest.set_mapgen_params({mgname="valleys"})
	--minetest.set_mapgen_params({mgname="v7"})
end)


-- Modify a node to add a group
function minetest.add_group(node, groups)
	local def = minetest.registered_items[node]
	if not def then
		return false
	end
	local def_groups = def.groups or {}
	for group, value in pairs(groups) do
		if value ~= 0 then
			def_groups[group] = value
		else
			def_groups[group] = nil
		end
	end
	minetest.override_item(node, {groups = def_groups})
	return true
end

function cityscape.clone_node(name)
	local node = minetest.registered_nodes[name]
	local node2 = table.copy(node)
	return node2
end

function cityscape.node(name)
	if not cityscape.node_cache then
		cityscape.node_cache = {}
	end

	if not cityscape.node_cache[name] then
		cityscape.node_cache[name] = minetest.get_content_id(name)
		if name ~= "ignore" and cityscape.node_cache[name] == 127 then
			print("*** Failure to find node: "..name)
		end
	end

	return cityscape.node_cache[name]
end

local breakable = {}
do
	local t = { "cityscape:concrete", "cityscape:concrete2",
	"cityscape:concrete3", "cityscape:concrete4", "cityscape:concrete5",
	"cityscape:sidewalk", "cityscape:floor_ceiling", "cityscape:roof",
	"default:brick", "default:sandstonebrick", "default:stonebrick",
	"default:desert_stonebrick", "cityscape:road", "cityscape:plate_glass", 
	"cityscape:carpet", "default:wood", }
	for _, i in pairs(t) do
		breakable[i] = true
	end
end

function cityscape.breaker(node)
	local sr = math.random(50)
	if sr <= cityscape.desolation then
		return "air"
	elseif breakable[node] and cityscape.desolation > 0 and sr / 5 <= cityscape.desolation then
		return string.gsub(node, ".*:", "cityscape:").."_broken"
	else
		return node
	end
end


dofile(cityscape.path .. "/nodes.lua")
dofile(cityscape.path .. "/deco.lua")
dofile(cityscape.path .. "/deco_rocks.lua")
dofile(cityscape.path .. "/mapgen.lua")
dofile(cityscape.path .. "/valleys.lua")
dofile(cityscape.path .. "/buildings.lua")
dofile(cityscape.path .. "/houses.lua")
dofile(cityscape.path .. "/molotov.lua")

local unbroken = true
local unbreak_this = "house_with_pool"
cityscape.house_schematics = {}
for _, filename in pairs(minetest.get_dir_list(cityscape.path.."/schematics/")) do
	if string.find(filename, "^house_[%a%d_]+%.house$") then
		local file = io.open(cityscape.path.."/schematics/"..filename, "rb")
		if file then
			local data = file:read("*all")
			file:close()
			cityscape.house_schematics[#cityscape.house_schematics+1] = data
			print("loaded "..filename)
			if not unbroken and string.find(filename, unbreak_this) then
				local new_data = data
				new_data = minetest.decompress(new_data)
				new_data = minetest.deserialize(new_data)
				for _, i in pairs(new_data.data) do
					i.name = string.gsub(i.name, "_broken", "")
					if string.find(i.name, "default:dry_shrub") then
						i.name = "air"
						i.prob = 0
					end
					if string.find(i.name, "default:grass") then
						i.name = "air"
						i.prob = 0
					end
				end
				new_data = minetest.serialize(new_data)
				new_data = minetest.compress(new_data)
				cityscape.house_schematics[#cityscape.house_schematics] = new_data

				filename = minetest.get_worldpath().."/"..unbreak_this..".house"
				local file = io.open(filename, "wb")
				if file then
					file:write(new_data)
					file:close()
				end
				unbroken = true
			end
		end
	end
end

minetest.register_chatcommand("saveplot", {
	params = "[filename]",
	description = "save the plot you're in as a schematic file",
	--privs = {privs=true}, -- Require the "privs" privilege to run
	func = function(name, param)
		local filename = param
		if not filename or filename == "" or string.find(filename, "[^%a%d_]") then
			print("* Cityscape: Specify a simple filename containing digits and letters. The suffix will be added automatically. Paths are not allowed.")
			return
		end

		filename = minetest.get_worldpath().."/"..filename..".house"
		local pos = minetest.get_player_by_name(name):getpos()
		local csize = (minetest.setting_get("chunksize") or 5) * 16
		local sec = math.floor(csize / 2)
		local x0 = math.floor((pos.x + 32) / sec) * sec - 32
		local y0 = math.floor((pos.y + 32) / sec) * sec - 32
		local z0 = math.floor((pos.z + 32) / sec) * sec - 32
		local y1 = cityscape.get_elevation({x=x0,z=z0})
		local p1 = {x=x0+7,y=y1,z=z0+7}
		local p2 = {x=x0+sec-2, y=y0+sec, z=z0+sec-2}
		local vm = minetest.get_voxel_manip()
		local emin, emax = vm:read_from_map(p1, p2)
		local data = vm:get_data()
		local p2data = vm:get_param2_data()
		local a = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
		local y2
		for y = emax.y, emin.y, -1 do
			for z = p1.z, p2.z do
				local ivm = a:index(p1.x, y, z)
				for x = p1.x, p2.x do
					if not y2 and data[ivm] ~= cityscape.node("air") and data[ivm] ~= cityscape.node("ignore") then
						y2 = y
					end

					ivm = ivm + 1
				end
			end
		end
		if y2 then
			p2.y = y2
			local schem = {size=vector.add(vector.subtract(p2, p1), 1)}
			schem.data = {}
			for z = p1.z, p2.z do
				for y = p1.y, p2.y do
					local ivm = a:index(p1.x, y, z)
					for x = p1.x, p2.x do
						local node = {}
						node.name = minetest.get_name_from_content_id(data[ivm])
						if node.name == "air" then
							node.prob = 0
						end
						if p2data[ivm] ~= 0 then
							node.param2 = p2data[ivm]
						end
						schem.data[#schem.data+1] = node

						ivm = ivm + 1
					end
				end
			end

			local file = io.open(filename, "wb")
			if file then
				local data = minetest.serialize(schem)
				data = minetest.compress(data)
				file:write(data)
				file:close()
			end
			print("Cityscape saved a schematic to \""..filename.."\"")
		else
			print("* Cityscape cannot determine coordinates for plotsave.")
		end
	end,
})

cityscape.players_to_check = {}

function cityscape.respawn(player)
	cityscape.players_to_check[#cityscape.players_to_check+1] = player:get_player_name()
end

function cityscape.unearth(dtime)
	for i, player_name in pairs(cityscape.players_to_check) do
		local player = minetest.get_player_by_name(player_name)
		if not player then
			return
		end
		local pos = player:getpos()
		if not pos then
			return
		end
		local count = 0
		local node = minetest.get_node_or_nil(pos)
		while node do
			if node.name == 'air' then
				player:setpos(pos)
				table.remove(cityscape.players_to_check, i)
				if count > 1 then
					print("*** Cityscape unearthed "..player_name.." from "..count.." meters below.")
				end
				return
			elseif node.name == "ignore" then
				return
			else
				pos.y = pos.y + 1
				count = count + 1
			end
			node = minetest.get_node_or_nil(pos)
			end
	end
end

minetest.register_on_newplayer(cityscape.respawn)
minetest.register_on_respawnplayer(cityscape.respawn)
minetest.register_on_generated(cityscape.generate)
minetest.register_globalstep(cityscape.unearth)
