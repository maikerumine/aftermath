--Simple semi-protected asphalt mod for minetest
-- used parts of Oil Mod 1.1 By sfan5
OIL_VISC = 16
OIL_ALPHA = 210

minetest.register_node("asphalt:oil_source", {
	description = "Oil",
	inventory_image = minetest.inventorycube("oil_oil.png"),
	drawtype = "liquid",
	tiles = {"oil_oil.png"},
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "asphalt:oil_flowing",
	liquid_alternative_source = "asphalt:oil_source",
	liquid_viscosity = OIL_VISC,
	liquid_renewable = false,
	post_effect_color = {a=OIL_ALPHA, r=0, g=0, b=0},
	groups = {flammable = 3},
	special_tiles = {
		{image="oil_oil.png", backface_culling=false},
	},
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(24, 60));
	end,
	on_timer = function(pos)
		minetest.remove_node(pos);
	end,
})

minetest.register_node("asphalt:oil_flowing", {
	description = "Oil (flowing)",
	inventory_image = minetest.inventorycube("oil_oil.png"),
	drawtype = "flowingliquid",
	tiles = {"oil_oil.png"},
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "asphalt:oil_flowing",
	liquid_alternative_source = "asphalt:oil_source",
	liquid_renewable = false,
	liquid_viscosity = OIL_VISC,
	post_effect_color = {a=OIL_ALPHA, r=0, g=0, b=0},
	groups = {flammable = 2},
	special_tiles = {
		{image="oil_oil.png", backface_culling=false},
		{image="oil_oil.png", backface_culling=true},
	},
})

bucket.register_liquid(
	"asphalt:oil_source",
	"asphalt:oil_flowing",
	"asphalt:bucket_oil",
	"oil_oil_bucket.png",
	"Oil bucket"
)

minetest.register_craftitem("asphalt:bitumen_lump", {
	inventory_image = "bitumen_lump.png",
	description = "Bitumen",
})

minetest.register_craft({
    type = "cooking",
	output = "asphalt:bitumen_lump 9",
	recipe = "asphalt:bucket_oil",
	cooktime = 30.0,
})

minetest.register_node("asphalt:asphalt", {
	description = "Asphalt",
	paramtype2 = "facedir",
	tiles = {"asphalt.png", "asphalt_bottom.png", "asphalt.png", "asphalt.png", "asphalt_back.png", "asphalt_front.png"},
	is_ground_content = false,
	groups = {snappy = 1, choppy = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "asphalt:asphalt 8",
	recipe = {
		{"default:cobble", "default:cobble", "default:cobble"},
		{"default:cobble", "asphalt:bitumen_lump", "default:cobble"},
		{"default:cobble", "default:cobble", "default:cobble"}
	}
})


local function can_dig_asphalt(pos)
    local nx1 = minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z});
    local nx2 = minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z});
    if nx1.name == "asphalt:asphalt" and nx2.name == "asphalt:asphalt" then
        return false
    end
    if nx1.name == "ignore" or nx2.name == "ignore" then
        return false
    end
    local nz1 = minetest.get_node({x=pos.x, y=pos.y, z=pos.z-1});
    local nz2 = minetest.get_node({x=pos.x, y=pos.y, z=pos.z+1});
    if nz1.name == "asphalt:asphalt" and nz2.name == "asphalt:asphalt" then
        return false
    end
    if nz1.name == "ignore" or nz2.name == "ignore" then
        return false
    end
    return true
end


old_is_protected = minetest.is_protected
function minetest.is_protected(pos, player_name)
    local node = minetest.get_node(pos);
    --can dig asphalt only from corners
    if node.name == "asphalt:asphalt" then
        --tnt and other things also cannot destroy asphalt
        if player_name == nil then
            return true
        end
        -- Delprotect privilege (works only if declared by protection mod)
        if minetest.get_player_privs(player_name).delprotect then
            local player = minetest.get_player_by_name(player_name);
            if player:get_player_control().sneak then
                return false
            end
        end
        if not can_dig_asphalt(pos) then
            return true
        end
    end
    --Rails on asphalt are protected
    if minetest.get_item_group(node.name, "connect_to_raillike") > 0 then
        local node_under = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z});
        if node_under.name == "asphalt:asphalt" then
            return true
        end
    end
    --asphalt protects from placing nodes above it
    local node_def = minetest.registered_nodes[node.name]
    if node_def and node_def.buildable_to then
        local positions = minetest.find_nodes_in_area(
                        {x=pos.x-1, y=pos.y-4, z=pos.z-1},
                        {x=pos.x+1, y=pos.y-1, z=pos.z+1},
                        {"asphalt:asphalt", "ignore"});
        if #positions > 0 then
            return true
        end
    end
	return old_is_protected(pos, player_name)
end
--asphalt make exception for rail placing
local old_node_place = minetest.item_place
function minetest.item_place(itemstack, placer, pointed_thing)
    local item_name = itemstack:get_name();
	if minetest.get_item_group(item_name, "connect_to_raillike") > 0 then
		local pos = pointed_thing.above;
        local positions = minetest.find_nodes_in_area(
                        {x=pos.x-1, y=pos.y-1, z=pos.z-1},
                        {x=pos.x+1, y=pos.y-1, z=pos.z+1},
                        {"asphalt:asphalt"});
        if #positions > 0 then
            local player_name = placer:get_player_name();
            if not old_is_protected(pos, player_name) then
                --can only use set_node() because it dont use is_protected!
                minetest.set_node(pos, {name=item_name});
                itemstack:take_item(1)
                return itemstack
            end
        end
    end
	return old_node_place(itemstack, placer, pointed_thing)
end

--Oil burst up from the ground
minetest.register_abm({
	label = "Eruption",
	nodenames = {"asphalt:oil_source"},
	neighbors = {"default:stone"},
	interval = 1,
	chance = 2,
	catch_up = false,
	action = function(pos)
		local positions = minetest.find_nodes_in_area(
						{x=pos.x-1, y=pos.y, z=pos.z-1},
						{x=pos.x+1, y=pos.y, z=pos.z+1},
						{"default:stone", "default:stone_with_coal"})
		if #positions > 6 then
		    for _, i in pairs({1, 2, 3, 4, 5}) do
		        local pos_above = {x=pos.x, y=pos.y + i, z=pos.z};
		        local n = minetest.get_node(pos_above);
		        if n.name == "air" then
		            minetest.set_node(pos_above, {name = "asphalt:oil_flowing"});
		        end
		    end
		end
	end,
})
--Oil is found!
local old_node_dig = minetest.node_dig
function minetest.node_dig(pos, node, digger)
    if math.random(1, 50) == 1 then
	    if node.name == "default:stone" then
	        local positions = minetest.find_nodes_in_area(
				        {x=pos.x-2, y=pos.y-2, z=pos.z-2},
				        {x=pos.x+2, y=pos.y+3, z=pos.z+2},
				        {"air", "default:water_flowing"})
	        if #positions < 5 then
                local pos_under = {x=pos.x, y=pos.y-1, z=pos.z};
                local n = minetest.get_node(pos_under);
                if n.name == "default:stone" then
                    minetest.set_node(pos_under, {name = "asphalt:oil_source"});
                end
            end
	    end
	end
	return old_node_dig(pos, node, digger)
end
