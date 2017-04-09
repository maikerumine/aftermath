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

--maikerumine add pathogen
local function blood(data, pos1, pos2)
	local y = math.min(pos2.y, pos1.y)
	for z = pos1.z,pos2.z do
		for x = pos1.x,pos2.x do
			if (data[x][y][z] == node("air") or data[x][y][z] == nil) and math.random(100) == 1 then
				data[x][y][z] = node("pathogen:fluid_blood")
			end
		end
	end
end

local function feces(data, pos1, pos2)
	local y = math.min(pos2.y, pos1.y)
	for z = pos1.z,pos2.z do
		for x = pos1.x,pos2.x do
			if (data[x][y][z] == node("air") or data[x][y][z] == nil) and math.random(100) == 1 then
				data[x][y][z] = node("pathogen:fluid_feces")
			end
		end
	end
end

local function vomit(data, pos1, pos2)
	local y = math.min(pos2.y, pos1.y)
	for z = pos1.z,pos2.z do
		for x = pos1.x,pos2.x do
			if (data[x][y][z] == node("air") or data[x][y][z] == nil) and math.random(100) == 1 then
				data[x][y][z] = node("pathogen:fluid_vomit")
			end
		end
	end
end

local function corpse(data, pos1, pos2)
	local y = math.min(pos2.y, pos1.y)
	for z = pos1.z,pos2.z do
		for x = pos1.x,pos2.x do
			if (data[x][y][z] == node("air") or data[x][y][z] == nil) and math.random(200) == 1 then
				data[x][y][z] = node("bones:bones")
			end
		end
	end
end
--end pathogen

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


local function roof_box(data, off, sy, dx, dz, tex)
	for z = off,dz-off+1 do
		for x = off,dx-off+1 do
			for y = sy+1,sy+3 do
				if z == off or z == dz-off+1 or x == off or x == dx-off+1 then
					if y < sy + 3 and x == dx - off + 1 and z == math.floor(dz / 2) then
						data[x][y][z] = node("air")
					else
						data[x][y][z] = node(breaker(tex))
					end
				end
			end
			if z > off and z < dz-off+1 and x > off and x < dx-off+1 then
				data[x][sy+3][z] = node(breaker("cityscape:roof"))
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
			data[2 + px][i + py][2 + i + pz] = node("cityscape:concrete_stair")
		end
		for i = 1,3 do
			data[2 + px][4 + py][2 + i + pz] = node("air")
		end
	else
		for i = 1,4 do
			data[3 + px][i + py][7 - i + pz] = node("cityscape:concrete_stair")
			pstore(param, 3+px, i+py, 7-i+pz, 4)
		end
		for i = 1,3 do
			data[3 + px][4 + py][7 - i + pz] = node("air")
		end
	end
end


local function gotham(data, param, dx, dy, dz)
	local develop, wall_x, wall_x_2, wall_z, wall_z_2
	local dir, y, floors, conc

	local c = math.random(5)
	if c == 1 then
		conc = "cityscape:concrete"
	else
		conc = "cityscape:concrete"..c
	end

	local ra = math.random(2) - 1
	floors = math.random(2, math.floor(dy / 4) - (1 - ra))

	-- all this for gargoyles...
	if math.random(2) == 1 and floors > 5 then
		for z = 0,dz+1 do
			for x = 0,dx+1 do
				y = floors * 4
				y = y - (y % 4)
				if (x == 0 or x == dx + 1) and z % 5 == 4 then
					data[x][y][z] = node("cityscape:gargoyle")
					dir = (x == 0 and 18 or 12)
					pstore(param, x, y, z, dir)
				elseif (z == 0 or z == dz + 1) and x % 5 == 4 then
					data[x][y][z] = node("cityscape:gargoyle")
					dir = (z == 0 and 9 or 7)
					pstore(param, x, y, z, dir)
				end
			end
		end
	end

	for z = 1,dz do
		for x = 1,dx do
			develop = x > 1 and x < dx and z > 1 and z < dz
			wall_x = x == 1 or x == dx
			wall_z = z == 1 or z == dz
			wall_x_2 = x == 2 or x == dx - 1
			wall_z_2 = z == 2 or z == dz - 1
			for y = 0,(floors * 4) do
				if y % 4 == 0 and x > 2 and z > 2 and x < dx - 1 and z < dz - 1 then
					if floors * 4 - y < 4 then
						data[x][y][z] = node(breaker("cityscape:roof"))
					else
						data[x][y][z] = node(breaker("cityscape:floor_ceiling"))
					end
				elseif wall_x then
					if y == 0 then
						data[x][y][z] = node(breaker(conc))
					elseif z % 5 == 4 then
						data[x][y][z] = node(breaker(conc))
					else
						data[x][y][z] = node("air")
					end
				elseif wall_x_2 and develop then
					if y == 0 then
						data[x][y][z] = node(breaker(conc))
					elseif z % 12 == 3 and y <= 2 and y > 0 then
						data[x][y][z] = node("air")
					elseif y % 4 ~= 2 or z % 5 == 4 then
						data[x][y][z] = node(breaker(conc))
					else
						data[x][y][z] = node(breaker("cityscape:plate_glass"))
					end
				elseif wall_z then
					if y == 0 then
						data[x][y][z] = node(breaker(conc))
					elseif x % 5 == 4 then
						data[x][y][z] = node(breaker(conc))
					else
						data[x][y][z] = node("air")
					end
				elseif wall_z_2 and develop then
					if y == 0 then
						data[x][y][z] = node(breaker(conc))
					elseif x % 12 == 3 and y <= 2 and y > 0 then
						data[x][y][z] = node("air")
					elseif y % 4 ~= 2 or x % 5 == 4 then
						data[x][y][z] = node(breaker(conc))
					else
						data[x][y][z] = node(breaker("cityscape:plate_glass"))
					end
				else
					data[x][y][z] = node("air")
				end
			end
		end
	end

	for f = 1,floors-ra do
		stairwell(data, param, {x=2,y=((f-1)*4),z=2}, {x=dx-1,y=(f*4-1),z=dz-1}, (f / 2 == math.floor(f / 2)))
		lights(data, param, {x=3,y=((f-1)*4),z=3}, {x=dx-2,y=(f*4-1),z=dz-2})
		crates(data, {x=3,y=((f-1)*4+1),z=3}, {x=dx-2,y=((f-1)*4+1),z=dz-2})
		--maikerumine add pathogen
		blood(data, {x=3,y=((f-1)*4+1),z=3}, {x=dx-2,y=((f-1)*4+1),z=dz-2})
		feces(data, {x=3,y=((f-1)*4+1),z=3}, {x=dx-2,y=((f-1)*4+1),z=dz-2})
		vomit(data, {x=3,y=((f-1)*4+1),z=3}, {x=dx-2,y=((f-1)*4+1),z=dz-2})
		corpse(data, {x=3,y=((f-1)*4+1),z=3}, {x=dx-2,y=((f-1)*4+1),z=dz-2})
	end

	if ra == 0 then
		roof_box(data, 10, floors * 4, dx, dz, conc)
	end
end


local function glass_and_steel(data, param, dx, dy, dz)
	local develop, wall_x, wall_z, floors, conc
	local c = math.random(5)
	if c == 1 then
		conc = "cityscape:concrete"
	else
		conc = "cityscape:concrete"..c
	end

	local ra = math.random(2) - 1
	floors = math.random(2, math.floor(dy / 4) - (1 - ra))

	for z = 1,dz do
		for x = 1,dx do
			wall_x = x == 1 or x == dx
			wall_z = z == 1 or z == dz
			for y = 0,(floors * 4) do
				if y % 4 == 0 and x > 1 and z > 1 and x < dx and z < dz then
					if floors * 4 - y < 4 then
						data[x][y][z] = node(breaker("cityscape:roof"))
					else
						data[x][y][z] = node(breaker("cityscape:floor_ceiling"))
					end
				elseif wall_x then
					if (z - 2) % 5 == 2 then
						data[x][y][z] = node(breaker(conc))
					elseif y == 0 then
						data[x][y][z] = node(breaker(conc))
					elseif z == 6 and y <= 2 then
						data[x][y][z] = node("air")
					else
						data[x][y][z] = node(breaker("cityscape:plate_glass"))
					end
				elseif wall_z then
					if (x - 2) % 5 == 2 then
						data[x][y][z] = node(breaker(conc))
					elseif y == 0 then
						data[x][y][z] = node(breaker(conc))
					elseif x == 6 and y <= 2 then
						data[x][y][z] = node("air")
					else
						data[x][y][z] = node(breaker("cityscape:plate_glass"))
					end
				end
			end
		end
	end

	for f = 1,floors-ra do
		stairwell(data, param, {x=1,y=((f-1)*4),z=1}, {x=dx,y=(f*4-1),z=dz}, (f / 2 == math.floor(f / 2)))
		lights(data, param, {x=1,y=((f-1)*4),z=1}, {x=dx,y=(f*4-1),z=dz})
		crates(data, {x=1,y=((f-1)*4+1),z=1}, {x=dx,y=((f-1)*4+1),z=dz})
				--maikerumine add pathogen
		blood(data, {x=3,y=((f-1)*4+1),z=3}, {x=dx-2,y=((f-1)*4+1),z=dz-2})
		feces(data, {x=3,y=((f-1)*4+1),z=3}, {x=dx-2,y=((f-1)*4+1),z=dz-2})
		vomit(data, {x=3,y=((f-1)*4+1),z=3}, {x=dx-2,y=((f-1)*4+1),z=dz-2})
		corpse(data, {x=3,y=((f-1)*4+1),z=3}, {x=dx-2,y=((f-1)*4+1),z=dz-2})
	end

	if ra == 0 then
		roof_box(data, 10, floors * 4, dx, dz, conc)
	end
end


local function simple(data, param, dx, dy, dz, slit)
	local develop, wall_x, wall_z, floors, conc, c

	local ra = math.random(2) - 1
	floors = math.random(2, math.floor(dy / 4) - (1 - ra))

	if floors < 6 then
		c = math.random(9)
	else
		c = math.random(5)
	end

	if c == 1 then
		conc = "cityscape:concrete"
	elseif c == 6 then
		conc = "default:brick"
	elseif c == 7 then
		conc = "default:sandstonebrick"
	elseif c == 8 then
		conc = "default:stonebrick"
	elseif c == 9 then
		conc = "default:desert_stonebrick"
	else
		conc = "cityscape:concrete"..c
	end

	for z = 1,dz do
		for x = 1,dx do
			wall_x = x == 1 or x == dx
			wall_z = z == 1 or z == dz
			for y = 0,(floors * 4) do
				if y % 4 == 0 and x > 1 and z > 1 and x < dx and z < dz then
					if floors * 4 == y then
						data[x][y][z] = node(breaker("cityscape:roof"))
					else
						data[x][y][z] = node(breaker("cityscape:floor_ceiling"))
					end
				elseif wall_x then
					if z == 6 and y <= 2 and y > 0 then
						data[x][y][z] = node("air")
					elseif slit and z % 2 == 0 and y % 4 > 1 then
						data[x][y][z] = node(breaker("cityscape:plate_glass"))
					elseif not slit and math.floor(z / 2) % 2 == 1 and y % 4 > 1 then
						data[x][y][z] = node(breaker("cityscape:plate_glass"))
					else
						data[x][y][z] = node(breaker(conc))
					end
				elseif wall_z then
					if x == 6 and y <= 2 and y > 0 then
						data[x][y][z] = node("air")
					elseif slit and x % 2 == 0 and y % 4 > 1 then
						data[x][y][z] = node(breaker("cityscape:plate_glass"))
					elseif not slit and math.floor(x / 2) % 2 == 1 and y % 4 > 1 then
						data[x][y][z] = node(breaker("cityscape:plate_glass"))
					else
						data[x][y][z] = node(breaker(conc))
					end
				end
			end
		end
	end

	for f = 1,floors-ra do
		stairwell(data, param, {x=1,y=((f-1)*4),z=1}, {x=dx,y=(f*4-1),z=dz}, (f / 2 == math.floor(f / 2)))
		lights(data, param, {x=1,y=((f-1)*4),z=1}, {x=dx,y=(f*4-1),z=dz})
		crates(data, {x=1,y=((f-1)*4+1),z=1}, {x=dx,y=((f-1)*4+1),z=dz})
				--maikerumine add pathogen
		blood(data, {x=3,y=((f-1)*4+1),z=3}, {x=dx-2,y=((f-1)*4+1),z=dz-2})
		feces(data, {x=3,y=((f-1)*4+1),z=3}, {x=dx-2,y=((f-1)*4+1),z=dz-2})
		vomit(data, {x=3,y=((f-1)*4+1),z=3}, {x=dx-2,y=((f-1)*4+1),z=dz-2})
		corpse(data, {x=3,y=((f-1)*4+1),z=3}, {x=dx-2,y=((f-1)*4+1),z=dz-2})
	end

	if ra == 0 then
		roof_box(data, 10, floors * 4, dx, dz, conc)
	end
end


-- This is probably a bad idea...
local function simple_tree(data, px, pz)
	local r
	local h = math.random(4,6)
	for y = 1,h do
		data[px][y][pz] = node("default:tree")
	end
	for z = -2,2 do
		for y = -2,2 do
			for x = -2,2 do
				r = math.sqrt(x ^ 2 + y ^ 2 + z ^ 2)
				if data[x + px][y + h][z + pz] ~= node("default:tree") and math.random(4,6) > r * 2 then
					data[x + px][y + h][z + pz] = node("default:leaves")
				end
			end
		end
	end
end

local function park(data, param, dx, dy, dz)
	local sr

	for z = 1,dz do
		for x = 1,dx do
			data[x][0][z] = node("default:dirt_with_grass")
			if cityscape.desolation > 0 then
				sr = math.random(14)
				if sr < 6 then
					data[x][1][z] = node("default:grass_"..sr)
				elseif sr == 6 then
					data[x][1][z] = node("default:dry_shrub")
				end
			end
		end
	end

	for qz = 1,math.floor(dz / 5) do
		for qx = 1,math.floor(dx / 5) do
			sr = math.random(5)
			if sr == 1 then
				simple_tree(data, qx * 5 - 2, qz * 5 - 2)
			elseif sr == 2 then
				data[qx * 5 - 2][1][qz * 5 - 2] = node("cityscape:park_bench")
				pstore(param, qx * 5 - 2, 1, qz * 5 - 2, math.random(4) - 1)
			elseif sr == 3 then
				data[qx * 5 - 2][1][qz * 5 - 2] = node("cityscape:swing_set")
				pstore(param, qx * 5 - 2, 1, qz * 5 - 2, math.random(4) - 1)
			else
				sr = math.random(30)
				if sr == 1 then
					data[qx * 5 - 2][1][qz * 5 - 2] = node("cityscape:doll")
					pstore(param, qx * 5 - 2, 1, qz * 5 - 2, math.random(4) - 1)
				end
			end
		end
	end
end


function cityscape.build(data, param, dx, dy, dz)
	pcount = 0
	local sr = math.random(13)

	if sr <= 3 then
		gotham(data, param, dx, dy, dz)
	elseif sr <= 6 then
		glass_and_steel(data, param, dx, dy, dz)
	elseif sr <= 9 then
		simple(data, param, dx, dy, dz)
	elseif sr <= 12 then
		simple(data, param, dx, dy, dz, true)
	else
		park(data, param, dx, dy, dz)
	end

	return pcount
end
