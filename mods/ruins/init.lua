local function can_replace(pos)
	local n = minetest.get_node_or_nil(pos)
	if n and n.name and minetest.registered_nodes[n.name] and not minetest.registered_nodes[n.name].walkable then
		return true
	elseif not n then
		return true
	else
		return false
	end
end


local function ground(pos)
	local p2 = pos
	local cnt = 0
	local mat = "dirt"
	p2.y = p2.y-1
	while can_replace(p2)==true do--minetest.get_node(p2).name == "air" do
		cnt = cnt+1
		if cnt > 200 then break end
		if cnt>math.random(2,4) then mat = "stone"end
		minetest.set_node(p2, {name="default:"..mat})
		p2.y = p2.y-1
	end
end

local function door(pos)
	pos.y = pos.y+1
	if math.random(0,1) > 0 then
		if math.random(0,1)>0 then pos.x=pos.x+6 end
		pos.z = pos.z + 3
	else
		if math.random(0,1)>0 then pos.z=pos.z+6 end
		pos.x = pos.x + 3
	end
	minetest.remove_node(pos)
	pos.y = pos.y+1
	minetest.remove_node(pos)
end

local function make(pos)
local material = "mossycobble"
if math.random(1,10) > 8 then material = "wood" end
 for yi = 0,4 do
	for xi = 0,6 do
		for zi = 0,6 do
			if yi == 0 then
				local p = {x=pos.x+xi, y=pos.y, z=pos.z+zi}
				minetest.set_node(p, {name="default:cobble"})
				minetest.after(1,ground,p)--(p)
			else
				if xi < 1 or xi > 5 or zi<1 or zi>5 then
					if math.random(1,yi) == 1 then
						local new = material
						if yi == 2 and math.random(1,10) == 3 then new = "glass" end
						local n = minetest.get_node_or_nil({x=pos.x+xi, y=pos.y+yi-1, z=pos.z+zi})
						if n and n.name ~= "air" then
							minetest.set_node({x=pos.x+xi, y=pos.y+yi, z=pos.z+zi}, {name="default:"..new})
						end
					end
				else
					minetest.remove_node({x=pos.x+xi, y=pos.y+yi, z=pos.z+zi})
				end
			end
		end
	end
 end
 door(pos)
end



local perl1 = {
	SEED1 = 9130, -- Values should match minetest mapgen V6 desert noise.
	OCTA1 = 3,
	PERS1 = 0.5,
	SCAL1 = 250,
}

local is_set = false
local function set_seed(seed)
	if not is_set then
		math.randomseed(seed)
		is_set = true
	end
end

minetest.register_on_generated(function(minp, maxp, seed)

	if maxp.y < 0 then return end
	if math.random(0,30)<28 then return end
	set_seed(seed)

	local perlin1 = minetest.get_perlin(perl1.SEED1, perl1.OCTA1, perl1.PERS1, perl1.SCAL1)
	local noise1 = perlin1:get2d({x=minp.x,y=minp.y})--,z=minp.z})
	if noise1 < 0.36 or noise1 > -0.36 then
		local mpos = {x=math.random(minp.x,maxp.x), y=math.random(minp.y,maxp.y), z=math.random(minp.z,maxp.z)}
		minetest.after(0.5, function()
		 local p2 = minetest.find_node_near(mpos, 25, {"default:dry_dirt"})
		 if not p2 or p2 == nil or p2.y < 0 then return end
		 minetest.log("action", "Created ruins at ("..p2.x..","..p2.y..","..p2.z..")")
		 make(p2)
		end)
	end
end)
