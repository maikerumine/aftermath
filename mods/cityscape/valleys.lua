-- This code is taken largely from Valleys Mapgen by Gael De Sally,
-- and is distributed under the GPL3 license:
--   http://www.gnu.org/licenses/gpl.html

local get_cpp_setting_noise = cityscape.get_cpp_setting_noise

local river_size = 5 / 100

cityscape.noises = {
	{offset = -10, scale = 50, seed = 5202, spread = {x = 1024, y = 1024, z = 1024}, octaves = 6, persist = 0.4, lacunarity = 2},
	{offset = 0, scale = 1, seed = -6050, spread = {x = 256, y = 256, z = 256}, octaves = 5, persist = 0.6, lacunarity = 2},
	{offset = 5, scale = 4, seed = -1914, spread = {x = 512, y = 512, z = 512}, octaves = 1, persist = 1, lacunarity = 2},
	{offset = 0.6, scale = 0.5, seed = 777, spread = {x = 512, y = 512, z = 512}, octaves = 1, persist = 1, lacunarity = 2},
	{offset = 0.5, scale = 0.5, seed = 746, spread = {x = 128, y = 128, z = 128}, octaves = 1, persist = 1, lacunarity = 2},
	{offset = 0, scale = 1, seed = 1993, spread = {x = 256, y = 512, z = 256}, octaves = 6, persist = 0.8, lacunarity = 2},
}
local noises = cityscape.noises

noises[1] = get_cpp_setting_noise("mg_valleys_np_terrain_height", noises[1])
noises[2] = get_cpp_setting_noise("mg_valleys_np_rivers", noises[2])
noises[3] = get_cpp_setting_noise("mg_valleys_np_valley_depth", noises[3])
noises[4] = get_cpp_setting_noise("mg_valleys_np_valley_profile", noises[4])
noises[5] = get_cpp_setting_noise("mg_valleys_np_inter_valley_slope", noises[5])
noises[6] = get_cpp_setting_noise("mg_valleys_np_inter_valley_fill", noises[6])
noises[7] = table.copy(noises[1])
--noises[7].scale = 1
--noises[7].offset = -0.2
noises[7].octaves = noises[6].octaves - 1
--noises[7].persist = noises[6].persist - 0.1

local function get_noise(pos, i)
	local noise = minetest.get_perlin(noises[i])
	if i == 6 then
		return noise:get3d(pos)
	else
		return noise:get2d({x=pos.x, y=pos.z})
	end
end
cityscape.get_noise = get_noise

function cityscape.get_elevation(pos)
	local v1 = get_noise(pos, 1) -- base ground
	local v2 = math.abs(get_noise(pos, 2)) - river_size -- valleys
	local v3 = get_noise(pos, 3) ^ 2 -- valleys depth
	local base_ground = v1 + v3
	if v2 < 0 then -- river
		return math.ceil(base_ground), true, math.ceil(base_ground)
	end
	local v4 = get_noise(pos, 4) -- valleys profile
	local v5 = get_noise(pos, 5) -- inter-valleys slopes
	-- Same calculation than in cityscape.generate
	local base_ground = v1 + v3
	local valleys = v3 * (1 - math.exp(- (v2 / v4) ^ 2))
	local mountain_ground = base_ground + valleys
	local pos = {x=pos.x, y=math.floor(mountain_ground + 0.5), z=pos.z} -- For now we don't know the elevation. We will test some y values. Set the position to montain_ground which is the most probable value.
	local slopes = v5 * valleys
	if get_noise(pos, 6) * slopes > pos.y - mountain_ground then -- Position is in the ground, so look for air higher
		pos.y = pos.y + 1
		while get_noise(pos, 6) * slopes > pos.y - mountain_ground do
			pos.y = pos.y + 1
		end -- End of the loop when there is air
		return pos.y, false, mountain_ground -- Return position of the first air node, and false because that's not a river
	else -- Position is not in the ground, so look for dirt lower
		pos.y = pos.y - 1
		while get_noise(pos, 6) * slopes <= pos.y - mountain_ground do
			pos.y = pos.y - 1
		end -- End of the loop when there is dirt (or any ground)
		pos.y = pos.y + 1 -- We have the latest dirt node and we want the first air node that is just above
		return pos.y, false, mountain_ground -- Return position of the first air node, and false because that's not a river
	end
end
