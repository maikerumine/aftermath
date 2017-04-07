-- Parameters

local HSAMP = 0.025 -- Height select amplitude.
					-- Controls maximum steepness of paths.
local DEBUG = false -- Print generation time

-- Mapgen v7 noises

-- 2D noise for base terrain

local np_base = {
	offset = 4,
	scale = 70,
	spread = {x = 600, y = 600, z = 600},
	seed = 82341,
	octaves = 5,
	persist = 0.6
}

-- 2D noise for alt terrain

local np_alt = {
	offset = 4,
	scale = 25,
	spread = {x = 600, y = 600, z = 600},
	seed = 5934,
	octaves = 5,
	persist = 0.6
}

-- 2D noise for height select

local np_select = {
	offset = -8,
	scale = 16,
	spread = {x = 500, y = 500, z = 500},
	seed = 4213,
	octaves = 6, -- default 6
	persist = 0.7 -- default 0.7
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
	seed = -8017,
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
	seed = -80033,
	octaves = 6,
	persist = 0.4
}

-- 2D noise for columns

local np_column = {
	offset = 0,
	scale = 1,
	spread = {x = 8, y = 8, z = 8},
	seed = 1728833,
	octaves = 3,
	persist = 2
}


-- Do files

dofile(minetest.get_modpath("pathv7") .. "/nodes.lua")


-- Constants

local c_wood    = minetest.get_content_id("pathv7:junglewood")
local c_column  = minetest.get_content_id("pathv7:bridgewood")
local c_stairn  = minetest.get_content_id("pathv7:stairn")
local c_stairs  = minetest.get_content_id("pathv7:stairs")
local c_staire  = minetest.get_content_id("pathv7:staire")
local c_stairw  = minetest.get_content_id("pathv7:stairw")
local c_stairne = minetest.get_content_id("pathv7:stairne")
local c_stairnw = minetest.get_content_id("pathv7:stairnw")
local c_stairse = minetest.get_content_id("pathv7:stairse")
local c_stairsw = minetest.get_content_id("pathv7:stairsw")

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

local nobj_base = nil
local nobj_alt = nil
local nobj_select = nil
local nobj_patha = nil
local nobj_pathb = nil
local nobj_pathc = nil
local nobj_pathd = nil
local nobj_column = nil


-- Localise noise buffers

local nbuf_base
local nbuf_alt
local nbuf_select
local nbuf_patha
local nbuf_pathb
local nbuf_pathc
local nbuf_pathd
local nbuf_column


-- Localise data buffer

local dbuf


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

	local sidelen = x1 - x0 + 1
	local emerlen = sidelen + 32
	local overlen = sidelen + 5
	local chulens = {x = overlen, y = overlen, z = 1}
	local minpos  = {x = x0 - 3, y = z0 - 3}

	nobj_base   = nobj_base   or minetest.get_perlin_map(np_base,   chulens)
	nobj_alt    = nobj_alt    or minetest.get_perlin_map(np_alt,    chulens)
	nobj_select = nobj_select or minetest.get_perlin_map(np_select, chulens)
	nobj_patha  = nobj_patha  or minetest.get_perlin_map(np_patha,  chulens)
	nobj_pathb  = nobj_pathb  or minetest.get_perlin_map(np_pathb,  chulens)
	nobj_pathc  = nobj_pathc  or minetest.get_perlin_map(np_pathc,  chulens)
	nobj_pathd  = nobj_pathd  or minetest.get_perlin_map(np_pathd,  chulens)
	nobj_column = nobj_column or minetest.get_perlin_map(np_column, chulens)
	
	local nvals_base   = nobj_base  :get2dMap_flat(minpos, nbuf_base)
	local nvals_alt    = nobj_alt   :get2dMap_flat(minpos, nbuf_alt)
	local nvals_select = nobj_select:get2dMap_flat(minpos, nbuf_select)
	local nvals_patha  = nobj_patha :get2dMap_flat(minpos, nbuf_patha)
	local nvals_pathb  = nobj_pathb :get2dMap_flat(minpos, nbuf_pathb)
	local nvals_pathc  = nobj_pathc :get2dMap_flat(minpos, nbuf_pathc)
	local nvals_pathd  = nobj_pathd :get2dMap_flat(minpos, nbuf_pathd)
	local nvals_column = nobj_column:get2dMap_flat(minpos, nbuf_column)
	
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
	local data = vm:get_data(dbuf)

	local ni = 1
	for z = z0 - 3, z1 + 2 do
		local n_xprepatha = false
		local n_xprepathb = false
		local n_xprepathc = false
		local n_xprepathd = false
		-- x0 - 3, z0 - 3 is to setup initial values of 'xprepath_', 'zprepath_'
		for x = x0 - 3, x1 + 2 do
			local n_patha = nvals_patha[ni]
			local n_zprepatha = nvals_patha[(ni - overlen)]
			local n_pathb = nvals_pathb[ni]
			local n_zprepathb = nvals_pathb[(ni - overlen)]
			local n_pathc = nvals_pathc[ni]
			local n_zprepathc = nvals_pathc[(ni - overlen)]
			local n_pathd = nvals_pathd[ni]
			local n_zprepathd = nvals_pathd[(ni - overlen)]

			if x >= x0 - 2 and z >= z0 - 2 then
				local abscol = math.abs(nvals_column[ni])
				local base = nvals_base[ni]
				local alt = nvals_alt[ni]
				local select = nvals_select[ni]
				if base < alt then
					base = alt
				end
				local tblend = 0.5 + HSAMP * (select - 0.5)
				tblend = math.min(math.max(tblend, 0), 1)
				local tlevel = math.floor(base * tblend + alt * (1 - tblend))
				local pathy = math.min(math.max(tlevel, 7), 42)

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
					for zz = z - 2, z + 2 do
						local vi = area:index(x - 2, pathy + 5, zz)
						for xx = x - 2, x + 2 do
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
					local vi = area:index(x - 2, pathy, z - 2)
					if data[vi] ~= c_wood then
						data[vi] = c_stairne
					end
					for iter = 1, 3 do
						vi = vi + 1
						if data[vi] ~= c_wood then
							data[vi] = c_stairn
						end
					end
					vi = vi + 1
					if data[vi] ~= c_wood then
						data[vi] = c_stairnw
					end
					for zz = z - 1, z + 1 do
						local vi = area:index(x - 2, pathy, zz)
						if data[vi] ~= c_wood then
							data[vi] = c_staire
						end
						for iter = 1, 3 do
							vi = vi + 1
							data[vi] = c_wood
						end
						vi = vi + 1
						if data[vi] ~= c_wood then
							data[vi] = c_stairw
						end
					end
					local vi = area:index(x - 2, pathy, z + 2)
					if data[vi] ~= c_wood then
						data[vi] = c_stairse
					end
					for iter = 1, 3 do
						vi = vi + 1
						if data[vi] ~= c_wood then
							data[vi] = c_stairs
						end
					end
					vi = vi + 1
					if data[vi] ~= c_wood then
						data[vi] = c_stairsw
					end
					-- bridge understructure
					for zz = z - 1, z + 1 do
						local vi = area:index(x - 1, pathy - 1, zz)
						for xx = x - 1, x + 1 do
							local nodid = data[vi]
							if nodid ~= c_stone
									and nodid ~= c_destone
									and nodid ~= c_sastone then		
								data[vi] = c_column
							end
							vi = vi + 1
						end
					end
					local vi = area:index(x, pathy - 2, z)
					data[vi] = c_column
					-- bridge columns
					if abscol < 0.3 then
						for xx = x - 1, x + 1, 2 do
						for zz = z - 1, z + 1, 2 do
							local vi = area:index(xx, pathy - 2, zz)
							for y = pathy - 2, y0, -1 do
								local nodid = data[vi]
								if nodid == c_stone
										or nodid == c_destone
										or nodid == c_sastone then
									break
								else
									data[vi] = c_column
								end
								vi = vi - emerlen
							end
						end
						end
					end
					-- excavate above path
					local det_destone = false
					local det_sastone = false
					local det_ice = false
					for y = pathy + 1, excatop do
						for zz = z - 2, z + 2 do
							local vi = area:index(x - 2, y, zz)
							for xx = x - 2, x + 2 do
								local nodid = data[vi]
								if nodid == c_destone then
									det_destone = true
								elseif nodid == c_sastone then
									det_sastone = true
								elseif nodid == c_ice then
									det_ice = true
								end
								if tunnel and y == excatop then -- tunnel ceiling
									if nodid ~= c_air
											and nodid ~= c_ignore
											and nodid ~= c_meselamp then
										if (math.abs(zz - z) == 2
												or math.abs(xx - x) == 2)
												and math.random() <= 0.2 then
											data[vi] = c_meselamp
										elseif det_destone then
											data[vi] = c_destone
										elseif det_sastone then
											data[vi] = c_sastone
										elseif det_ice then
											data[vi] = c_ice
										else
											data[vi] = c_stone
										end
									end
								elseif y <= pathy + 5 then
									if nodid ~= c_wood
											and nodid ~= c_stairn
											and nodid ~= c_stairs
											and nodid ~= c_staire
											and nodid ~= c_stairw
											and nodid ~= c_stairne
											and nodid ~= c_stairnw
											and nodid ~= c_stairse
											and nodid ~= c_stairsw then
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
		print ("[pathv7] Generate chunk " .. chugent .. " ms")
	end
end)
