-- Parameters

local DEBUG = true

-- Mapgen valleys noises

local np_terrain_height = {
	offset = -10,
	scale = 50,
	spread = {x = 1024, y = 1024, z = 1024},
	seed = 5202,
	octaves = 6,
	persist = 0.4,
	lacunarity = 2.0,
}

local np_valley_depth = {
	offset = 5,
	scale = 4,
	spread = {x = 512, y = 512, z = 512},
	seed = -1914,
	octaves = 1,
	persist = 0.0,
	lacunarity = 2.0,
}

-- Mod noises

-- 2D noise for patha

local np_patha = {
	offset = 0,
	scale = 1,
	spread = {x = 1024, y = 1024, z = 1024},
	seed = 11711,
	octaves = 3,
	persist = 0.4
}

-- 2D noise for pathb

local np_pathb = {
	offset = 0,
	scale = 1,
	spread = {x = 2048, y = 2048, z = 2048},
	seed = 8017,
	octaves = 4,
	persist = 0.4
}

-- 2D noise for pathc

local np_pathc = {
	offset = 0,
	scale = 1,
	spread = {x = 4096, y = 4096, z = 4096},
	seed = 300707,
	octaves = 5,
	persist = 0.4
}

-- 2D noise for pathd

local np_pathd = {
	offset = 0,
	scale = 1,
	spread = {x = 8192, y = 8192, z = 8192},
	seed = 80033,
	octaves = 6,
	persist = 0.4
}


-- Do files

dofile(minetest.get_modpath("roadvalleys") .. "/nodes.lua")


-- Constants

local c_roadblack = minetest.get_content_id("roadvalleys:road_black")
local c_roadslab  = minetest.get_content_id("roadvalleys:road_black_slab")
local c_roadwhite = minetest.get_content_id("roadvalleys:road_white")
local c_concrete  = minetest.get_content_id("roadvalleys:concrete")

local c_air          = minetest.CONTENT_AIR
local c_ignore       = minetest.CONTENT_IGNORE
local c_stone        = minetest.get_content_id("default:stone")
local c_sastone      = minetest.get_content_id("default:sandstone")
local c_destone      = minetest.get_content_id("default:desert_stone")
local c_ice          = minetest.get_content_id("default:ice")
local c_tree         = minetest.get_content_id("default:tree")
local c_leaves       = minetest.get_content_id("default:leaves")
local c_apple        = minetest.get_content_id("default:apple")
local c_jungletree   = minetest.get_content_id("default:jungletree")
local c_jungleleaves = minetest.get_content_id("default:jungleleaves")
local c_pinetree     = minetest.get_content_id("default:pine_tree")
local c_pineneedles  = minetest.get_content_id("default:pine_needles")
local c_snow         = minetest.get_content_id("default:snow")
local c_acaciatree   = minetest.get_content_id("default:acacia_tree")
local c_acacialeaves = minetest.get_content_id("default:acacia_leaves")
local c_aspentree    = minetest.get_content_id("default:aspen_tree")
local c_aspenleaves  = minetest.get_content_id("default:aspen_leaves")
local c_meselamp     = minetest.get_content_id("default:meselamp")


-- Initialise noise objects to nil

local nobj_terrain_height = nil
local nobj_valley_depth = nil
local nobj_patha = nil
local nobj_pathb = nil
local nobj_pathc = nil
local nobj_pathd = nil


-- Localise noise buffers

local nbuf_terrain_height = {}
local nbuf_valley_depth = {}
local nbuf_patha = {}
local nbuf_pathb = {}
local nbuf_pathc = {}
local nbuf_pathd = {}


-- Localise data buffer

local dbuf = {}


-- On generated function

minetest.register_on_generated(function(minp, maxp, seed)
	if minp.y > 0 or maxp.y < 0 then
		return
	end

	local t1 = os.clock()

	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z
	
	local sidelen  = x1 - x0 + 1
	local emerlen  = sidelen + 32
	local overlen  = sidelen + 9
	local pmapdims = {x = overlen, y = overlen, z = 1}
	local pmapminp = {x = x0 - 5, y = z0 - 5}

	nobj_terrain_height = nobj_terrain_height or
			minetest.get_perlin_map(np_terrain_height, pmapdims)
	nobj_valley_depth = nobj_valley_depth or
			minetest.get_perlin_map(np_valley_depth, pmapdims)
	nobj_patha = nobj_patha or minetest.get_perlin_map(np_patha, pmapdims)
	nobj_pathb = nobj_pathb or minetest.get_perlin_map(np_pathb, pmapdims)
	nobj_pathc = nobj_pathc or minetest.get_perlin_map(np_pathc, pmapdims)
	nobj_pathd = nobj_pathd or minetest.get_perlin_map(np_pathd, pmapdims)
	
	local nvals_terrain_height =
			nobj_terrain_height:get2dMap_flat(pmapminp, nbuf_terrain_height)
	local nvals_valley_depth =
			nobj_valley_depth:get2dMap_flat(pmapminp, nbuf_valley_depth)
	local nvals_patha = nobj_patha:get2dMap_flat(pmapminp, nbuf_patha)
	local nvals_pathb = nobj_pathb:get2dMap_flat(pmapminp, nbuf_pathb)
	local nvals_pathc = nobj_pathc:get2dMap_flat(pmapminp, nbuf_pathc)
	local nvals_pathd = nobj_pathd:get2dMap_flat(pmapminp, nbuf_pathd)

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
	local data = vm:get_data(dbuf)

	local ni = 1
	for z = z0 - 5, z1 + 4 do
		local n_xprepatha = nil
		local n_xprepathb = nil
		local n_xprepathc = nil
		local n_xprepathd = nil
		-- x0 - 5, z0 - 5 is to setup initial values of 'xprepath_', 'zprepath_'
		for x = x0 - 5, x1 + 4 do
			local n_patha = nvals_patha[ni]
			local n_zprepatha = nvals_patha[(ni - overlen)]
			local n_pathb = nvals_pathb[ni]
			local n_zprepathb = nvals_pathb[(ni - overlen)]
			local n_pathc = nvals_pathc[ni]
			local n_zprepathc = nvals_pathc[(ni - overlen)]
			local n_pathd = nvals_pathd[ni]
			local n_zprepathd = nvals_pathd[(ni - overlen)]

			if x >= x0 - 4 and z >= z0 - 4 then
				local n_terrain_height = nvals_terrain_height[ni]
				local n_valley_depth = nvals_valley_depth[ni]
				-- *** math.floor() fixes scattered bridge elements bug ***
				local tlevel = math.floor(n_terrain_height +
						(n_valley_depth * n_valley_depth))
				-- Add 6 to terrain level so that bridges pass over rivers
				local pathy = math.min(math.max(tlevel + 6, 7), 42)

				if (n_patha >= 0 and n_xprepatha < 0) -- detect sign change of noise
						or (n_patha < 0 and n_xprepatha >= 0)
						or (n_patha >= 0 and n_zprepatha < 0)
						or (n_patha < 0 and n_zprepatha >= 0)

						or (n_pathb >= 0 and n_xprepathb < 0)
						or (n_pathb < 0 and n_xprepathb >= 0)
						or (n_pathb >= 0 and n_zprepathb < 0)
						or (n_pathb < 0 and n_zprepathb >= 0)

						or (n_pathc >= 0 and n_xprepathc < 0)
						or (n_pathc < 0 and n_xprepathc >= 0)
						or (n_pathc >= 0 and n_zprepathc < 0)
						or (n_pathc < 0 and n_zprepathc >= 0)

						or (n_pathd >= 0 and n_xprepathd < 0)
						or (n_pathd < 0 and n_xprepathd >= 0)
						or (n_pathd >= 0 and n_zprepathd < 0)
						or (n_pathd < 0 and n_zprepathd >= 0) then
					-- scan disk 5 nodes above path
					local tunnel = false
					local excatop

					for zz = z - 4, z + 4 do
						local vi = area:index(x - 4, pathy + 5, zz)
						for xx = x - 4, x + 4 do
							local nodid = data[vi]
							if nodid == c_stone
									or nodid == c_destone
									or nodid == c_sastone
									or nodid == c_ice then
								tunnel = true
							end
							vi = vi + 1
						end
					end

					if tunnel then
						excatop = pathy + 5
					else
						excatop = y1
					end
					-- place path node brush
					local vi = area:index(x, pathy, z)
					data[vi] = c_roadwhite

					for k = -4, 4 do
						local vi = area:index(x - 4, pathy, z + k)
						for i = -4, 4 do
							local radsq = (math.abs(i)) ^ 2 + (math.abs(k)) ^ 2
							if radsq <= 13 then
								local nodid = data[vi]
								if nodid ~= c_roadwhite then
									data[vi] = c_roadblack
								end
							elseif radsq <= 25 then
								local nodid = data[vi]
								if nodid ~= c_roadblack
										and nodid ~= c_roadwhite then
									data[vi] = c_roadslab
								end
							end
							vi = vi + 1
						end
					end
					-- foundations or bridge structure
					for k = -4, 4 do
						local vi = area:index(x - 4, pathy - 1, z + k)
						for i = -4, 4 do
							local radsq = (math.abs(i)) ^ 2 + (math.abs(k)) ^ 2
							if radsq <= 25 then
								local nodid = data[vi]
								if nodid ~= c_roadblack
										and nodid ~= c_roadwhite
										and nodid ~= c_roadslab then
									data[vi] = c_concrete
								end
							end
							if radsq <= 2 then
								local viu = vi - emerlen
								local nodid = data[viu]
								if nodid ~= c_roadblack
										and nodid ~= c_roadwhite
										and nodid ~= c_roadslab then
									data[viu] = c_concrete
								end
							end
							vi = vi + 1
						end
					end
					-- bridge columns
					if math.random() <= 0.0625 then
						for xx = x - 1, x + 1 do
						for zz = z - 1, z + 1 do
							local vi = area:index(xx, pathy - 3, zz)
							for y = pathy - 3, y0 - 16, -1 do
								local nodid = data[vi]
								if nodid == c_stone
										or nodid == c_destone
										or nodid == c_sastone then
									break
								else
									data[vi] = c_concrete
								end
								vi = vi - emerlen
							end
						end
						end
					end
					-- excavate above path
					for y = pathy + 1, excatop do
						for zz = z - 4, z + 4 do
							local vi = area:index(x - 4, y, zz)
							for xx = x - 4, x + 4 do
								local nodid = data[vi]
								if tunnel and y == excatop then -- tunnel ceiling
									if nodid ~= c_air
											and nodid ~= c_ignore
											and nodid ~= c_meselamp then
										if (math.abs(zz - z) == 4
												or math.abs(xx - x) == 4)
												and math.random() <= 0.2 then
											data[vi] = c_meselamp
										else
											data[vi] = c_concrete
										end
									end
								elseif y <= pathy + 5 then
									if nodid ~= c_roadblack
											and nodid ~= c_roadslab
											and nodid ~= c_roadwhite then
										data[vi] = c_air
									end
								elseif nodid == c_tree
										or nodid == c_leaves
										or nodid == c_apple
										or nodid == c_jungletree
										or nodid == c_jungleleaves
										or nodid == c_pinetree
										or nodid == c_pineneedles
										or nodid == c_snow
										or nodid == c_acaciatree
										or nodid == c_acacialeaves
										or nodid == c_aspentree
										or nodid == c_aspenleaves then
									data[vi] = c_air
								end
								vi = vi + 1
							end
						end
					end
				end
			end

			n_xprepatha = n_patha
			n_xprepathb = n_pathb
			n_xprepathc = n_pathc
			n_xprepathd = n_pathd
			ni = ni + 1
		end
	end
	
	vm:set_data(data)
	vm:set_lighting({day = 0, night = 0})
	vm:calc_lighting()
	vm:write_to_map(data)

	local chugent = math.ceil((os.clock() - t1) * 1000)
	if DEBUG then
		print ("[roadvalleys] "..chugent.." ms")
	end
end)
