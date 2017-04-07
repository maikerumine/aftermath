local node = cityscape.node
local breaker = cityscape.breaker
local pcount = 0


local function pstore(param, x, y, z, p)
	pcount = pcount + 1
	if param[pcount] then
		param[pcount][1] = x
		param[pcount][2] = y
		param[pcount][3] = z
		param[pcount][4] = p
	else
		param[pcount] = {x, y, z, p}
	end
end


local function crates(data, pos1, pos2)
	local y = math.min(pos2.y, pos1.y)
	for z = pos1.z,pos2.z do
		for x = pos1.x,pos2.x do
			if (data[x][y][z] == node("air") or data[x][y][z] == nil) and math.random(1000) == 1 then
				data[x][y][z] = node("cityscape:crate")
			end
		end
	end
end


local function lights(data, param, pos1, pos2)
	local y = math.max(pos2.y, pos1.y)
	for z = pos1.z,pos2.z do
		for x = pos1.x,pos2.x do
			if (data[x][y][z] == node("air") or data[x][y][z] == nil) and (data[x][y+1][z] == node("cityscape:floor_ceiling") or data[x][y+1][z] == node("cityscape:roof")) and math.random(20) == 1 then
				if cityscape.desolation > 0 then
					data[x][y][z] = node("cityscape:light_panel_broken")
				else
					data[x][y][z] = node("cityscape:light_panel")
				end
				pstore(param, x, y, z, 20) -- 20-23
			end
		end
	end
end


local function stairwell(data, param, pos1, pos2, left)
	local dz, px, py, pz
	dz = (left and 0 or 2)

	px = math.floor((pos2.x - pos1.x - 4) / 2)
	py = math.min(pos2.y, pos1.y)
	pz = math.floor((pos2.z - pos1.z - 6) / 2)
	local walls = px > 2 and pz > 2

	if walls then
		for z = 1+dz,6+dz do
			for x = 1,4 do
				for y = 1,3 do
					if z == 1+dz or z == 6+dz or x == 1 or x == 4 then
						if left and x == 2 and z == 1 and y < 3 then
							data[x + px][y + py][z + pz] = node("air")
						elseif not left and x == 3 and z == 6+dz and y < 3 then
							data[x + px][y + py][z + pz] = node("air")
						else
							data[x + px][y + py][z + pz] = node(breaker("cityscape:plaster"))
						end
					end
				end
			end
		end
	end

	if left then
		for i = 1,4 do
			data[2 + px][i + py][2 + i + pz] = node("stair_stone")
		end
		for i = 1,3 do
			data[2 + px][4 + py][2 + i + pz] = node("air")
		end
	else
		for i = 1,4 do
			data[3 + px][i + py][7 - i + pz] = node("stair_stone")
			pstore(param, 3+px, i+py, 7-i+pz, 4)
		end
		for i = 1,3 do
			data[3 + px][4 + py][7 - i + pz] = node("air")
		end
	end
end


-- This is probably a bad idea...
local function simple_tree(data, px, pz)
	local r
	local h = math.random(4,6)
	for y = 1,h do
		data[px][y][pz] = node("tree")
	end
	for z = -2,2 do
		for y = -2,2 do
			for x = -2,2 do
				r = math.sqrt(x ^ 2 + y ^ 2 + z ^ 2)
				if data[x + px][y + h][z + pz] ~= node("tree") and math.random(4,6) > r * 2 then
					data[x + px][y + h][z + pz] = node("leaves")
				end
			end
		end
	end
end


local function overgrow(data, param, dx, dy, dz)
	local sr
	if cityscape.desolation > 0 then
		for z = 1,dz do
			for x = 1,dx do
				sr = math.random(10)
				if sr < 6 then
					data[x][1][z] = node("default:grass_"..sr)
				elseif sr == 6 then
					data[x][1][z] = node("default:dry_shrub")
				end
			end
		end
	end
end


local function simple_schem(data, param, dx, dy, dz, mir)
end

local function simple(data, param, dx, dy, dz, mir)
	local develop, wall_x, wall_z, floors, conc, c
	local yard = 3
	conc = "cityscape:concrete"..math.random(2,5)
	overgrow(data, param, dx, dy, dz)

	for z = 1+yard,dz-yard do
		for x = 1+yard+1,dx-yard+1 do
			wall_x = x == yard + 2 or x == dx - yard + 1
			wall_z = z == yard + 1 or z == dz - yard
			for y = 1,3 do
				if wall_x and y == 2 and z == math.floor(dz / 2) then
					data[x][y][z] = node("air")
				elseif wall_x and y == 1 and z == math.floor(dz / 2) then
					data[x][y][z] = node("doors:door_wood_b")
					if (mir == 2) ~= (x == yard + 2) then
						pstore(param, x, y, z, 1)
					else
						pstore(param, x, y, z, 3)
					end
				elseif (wall_x or wall_z) and y == 2 and math.random(2) == 1 then
					data[x][y][z] = node(breaker("cityscape:plate_glass"))
				elseif wall_x or wall_z then
					data[x][y][z] = node(breaker("default:wood"))
				elseif x > yard + 2 and x < dx - yard + 1 and z > yard + 1 and z < dz - yard then
					data[x][y][z] = node("air")
				end
			end
			data[x][4][z] = node(breaker("cityscape:roof"))
			data[x][0][z] = node(breaker("cityscape:carpet"))
		end
	end

	--for qz = 1,math.floor(dz / yard) do
	--	for qx = 1,math.floor(dx / yard) do
	--		if qz == 1 or qz == math.floor(dz / yard) or qx == 1 or qx == math.floor(dx / yard) then
	--			sr = math.random(5)
	--			if sr == 1 then
	--				simple_tree(data, qx * yard - 1, qz * yard - 1)
	--			else
	--				sr = math.random(30)
	--				if sr == 1 then
	--					data[qx * yard - 1][1][qz * yard - 1] = node("cityscape:doll")
	--					pstore(param, qx * yard - 1, 1, qz * yard - 1, math.random(4) - 1)
	--				end
	--			end
	--		end
	--	end
	--end
end


function cityscape.house(data, param, dx, dy, dz, mir)
	pcount = 0
	local sr = math.random(1)

	if math.random(10) <= cityscape.vacancies then
		return 0
	end

	if sr <= 1 then
		simple(data, param, dx, dy, dz, mir)
	end

	return pcount
end
