minetest.register_craftitem("rangedweapons:javelint", {
	wield_scale = {x=2,y=2,z=1.0},
	inventory_image = "ranged_javelin.png",
})

minetest.register_craftitem("rangedweapons:javelin", {
	description = "javelin(ranged dammage 6|survives block hit|velocity 30|penetrates targets)",
	wield_scale = {x=2,y=2,z=1.0},
	range = 5,
	inventory_image = "ranged_javelin_inv.png",
	stack_max= 10,
	on_use = function(itemstack, user, pointed_thing)
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item()
		end
		if pointed_thing.type ~= "nothing" then
			local pointed = minetest.get_pointed_thing_position(pointed_thing)
			if vector.distance(user:getpos(), pointed) < 8 then
				return itemstack
			end
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir then
			pos.y = pos.y + 1.5
			local obj = minetest.add_entity(pos, "rangedweapons:javelin_entity")
			if obj then
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 30})
				obj:setacceleration({x=dir.x * -3, y=-10, z=dir.z * -3})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})
minetest.register_craft({
	output = 'rangedweapons:javelin 1',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', ''},
		{'default:steel_ingot', 'default:stick', ''},
		{'', '', 'default:stick'},
	}
})

local rangedweapons_javelin_ENTITY = {
	physical = false,
	timer = 0,
	visual = "wielditem",
	visual_size = {x=0.5, y=0.5},
	textures = {"rangedweapons:javelint"},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}

rangedweapons_javelin_ENTITY.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.1 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:javelin_entity" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 6
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("rangedweapons_arrow", {pos = self.lastpos, gain = 0.8})
				end
			else
				local damage = 16
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("rangedweapons_arrow", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "rangedweapons:javelin")
			end
			minetest.sound_play("", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:javelin_entity", rangedweapons_javelin_ENTITY)

minetest.override_item('default:clay_brick', {
	description = "brick(ranged damage 5|afected by gravity|survives block hit|velocity 20)",
	range = 0,
	on_use = function(itemstack, user, pointed_thing)
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item()
		end
		if pointed_thing.type ~= "nothing" then
			local pointed = minetest.get_pointed_thing_position(pointed_thing)
			if vector.distance(user:getpos(), pointed) < 8 then
				return itemstack
			end
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir then
			pos.y = pos.y + 1.5
			local obj = minetest.add_entity(pos, "rangedweapons:brick")
			if obj then
				obj:setvelocity({x=dir.x * 20, y=dir.y * 20, z=dir.z * 20})
				obj:setacceleration({x=dir.x * -3, y=-10, z=dir.z * -3})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})

local RANGEDWEAPONS_brick = {
	physical = false,
	timer = 0,
	visual = "sprite",
	visual_size = {x=0.5, y=0.5,},
	textures = {'default_clay_brick.png'},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
RANGEDWEAPONS_brick.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.12 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:brick" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 15
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			else
				local damage = 5
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "default:clay_brick")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:brick", RANGEDWEAPONS_brick)




minetest.register_craftitem("rangedweapons:handgunshot", {
	wield_scale = {x=1.0,y=1.0,z=1.0},
	inventory_image = "rangedweapons_handgunshot.png",
})
minetest.register_craftitem("rangedweapons:revolvershot", {
	wield_scale = {x=6.0,y=1.0,z=1.0},
	inventory_image = "rangedweapons_rifleshot.png",
})

minetest.register_craftitem("rangedweapons:lasershot", {
	wield_scale = {x=1.0,y=3,z=1.0},
	inventory_image = "rangedweapons_lasershot.png",
})

minetest.register_craftitem("rangedweapons:rifleshot", {
	wield_scale = {x=3.5,y=1.0,z=1.0},
	inventory_image = "rangedweapons_rifleshot.png",
})


minetest.register_craftitem("rangedweapons:wooden_shuriken", {
	description = "wooden shuriken(ranged damage 2|afected by gravity|velocity 35)",
	range = 0,
	stack_max= 200,
	inventory_image = "rangedweapons_wooden_shuriken.png",
	on_use = function(itemstack, user, pointed_thing)
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item()
		end
		if pointed_thing.type ~= "nothing" then
			local pointed = minetest.get_pointed_thing_position(pointed_thing)
			if vector.distance(user:getpos(), pointed) < 8 then
				return itemstack
			end
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir then
			pos.y = pos.y + 1.5
			local obj = minetest.add_entity(pos, "rangedweapons:woodsr")
			if obj then
				obj:setvelocity({x=dir.x * 35, y=dir.y * 35, z=dir.z * 35})
				obj:setacceleration({x=dir.x * -3, y=-10, z=dir.z * -3})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})

local RANGEDWEAPONS_WOODSR = {
	physical = false,
	timer = 0,
	visual = "cube",
	visual_size = {x=0.5, y=0.0,},
	textures = {'rangedweapons_wooden_shuriken.png','rangedweapons_wooden_shuriken.png','rangedweapons_wooden_shuriken.png','rangedweapons_wooden_shuriken.png','rangedweapons_wooden_shuriken.png','rangedweapons_wooden_shuriken.png'},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
RANGEDWEAPONS_WOODSR.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.07 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:woodsr" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 2
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			else
				local damage = 12
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:woodsr", RANGEDWEAPONS_WOODSR)

minetest.register_craft({
	output = 'rangedweapons:wooden_shuriken 32',
	recipe = {
		{'', 'group:wood', ''},
		{'group:wood', '', 'group:wood'},
		{'', 'group:wood', ''},
	}
})


minetest.register_craftitem("rangedweapons:stone_shuriken", {
	description = "stone shuriken(ranged damage 4|afected by gravity|velocity 20)",
	range = 0,
	stack_max= 200,
	inventory_image = "rangedweapons_stone_shuriken.png",
	on_use = function(itemstack, user, pointed_thing)
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item()
		end
		if pointed_thing.type ~= "nothing" then
			local pointed = minetest.get_pointed_thing_position(pointed_thing)
			if vector.distance(user:getpos(), pointed) < 8 then
				return itemstack
			end
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir then
			pos.y = pos.y + 1.5
			local obj = minetest.add_entity(pos, "rangedweapons:stonesr")
			if obj then
				obj:setvelocity({x=dir.x * 20, y=dir.y * 20, z=dir.z * 20})
				obj:setacceleration({x=dir.x * -3, y=-10, z=dir.z * -3})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})

local RANGEDWEAPONS_STONESR = {
	physical = false,
	timer = 0,
	visual = "cube",
	visual_size = {x=0.5, y=0.0,},
	textures = {'rangedweapons_stone_shuriken.png','rangedweapons_stone_shuriken.png','rangedweapons_stone_shuriken.png','rangedweapons_stone_shuriken.png','rangedweapons_stone_shuriken.png','rangedweapons_stone_shuriken.png'},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
RANGEDWEAPONS_STONESR.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.12 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:stonesr" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 14
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			else
				local damage = 14
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:stonesr", RANGEDWEAPONS_STONESR)

minetest.register_craft({
	output = 'rangedweapons:stone_shuriken 32',
	recipe = {
		{'', 'default:cobble', ''},
		{'default:cobble', '', 'default:cobble'},
		{'', 'default:cobble', ''},
	}
})


minetest.register_craftitem("rangedweapons:steel_shuriken", {
	description = "steel shuriken(ranged damage 6|afected by gravity|survives block hit|velocity 45)",
	range = 0,
	stack_max= 200,
	inventory_image = "rangedweapons_steel_shuriken.png",
	on_use = function(itemstack, user, pointed_thing)
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item()
		end
		if pointed_thing.type ~= "nothing" then
			local pointed = minetest.get_pointed_thing_position(pointed_thing)
			if vector.distance(user:getpos(), pointed) < 8 then
				return itemstack
			end
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir then
			pos.y = pos.y + 1.5
			local obj = minetest.add_entity(pos, "rangedweapons:steelsr")
			if obj then
				obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 45})
				obj:setacceleration({x=dir.x * -3, y=-10, z=dir.z * -3})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})

local RANGEDWEAPONS_STEELSR = {
	physical = false,
	timer = 0,
	visual = "cube",
	visual_size = {x=0.5, y=0.0,},
	textures = {'rangedweapons_steel_shuriken.png','rangedweapons_steel_shuriken.png','rangedweapons_steel_shuriken.png','rangedweapons_steel_shuriken.png','rangedweapons_steel_shuriken.png','rangedweapons_steel_shuriken.png'},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
RANGEDWEAPONS_STEELSR.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.06 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:steelsr" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 26
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			else
				local damage = 26
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "rangedweapons:steel_shuriken")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:steelsr", RANGEDWEAPONS_STEELSR)

minetest.register_craft({
	output = 'rangedweapons:steel_shuriken 32',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'', 'default:steel_ingot', ''},
	}
})


minetest.register_craftitem("rangedweapons:bronze_shuriken", {
	description = "bronze shuriken(ranged damage 6|afected by gravity|survives block hit|velocity 50)",
	range = 0,
	stack_max= 200,
	inventory_image = "rangedweapons_bronze_shuriken.png",
	on_use = function(itemstack, user, pointed_thing)
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item()
		end
		if pointed_thing.type ~= "nothing" then
			local pointed = minetest.get_pointed_thing_position(pointed_thing)
			if vector.distance(user:getpos(), pointed) < 8 then
				return itemstack
			end
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir then
			pos.y = pos.y + 1.5
			local obj = minetest.add_entity(pos, "rangedweapons:bronzesr")
			if obj then
				obj:setvelocity({x=dir.x * 50, y=dir.y * 50, z=dir.z * 50})
				obj:setacceleration({x=dir.x * -3, y=-10, z=dir.z * -3})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})

local RANGEDWEAPONS_BRONZESR = {
	physical = false,
	timer = 0,
	visual = "cube",
	visual_size = {x=0.5, y=0.0,},
	textures = {'rangedweapons_bronze_shuriken.png','rangedweapons_bronze_shuriken.png','rangedweapons_bronze_shuriken.png','rangedweapons_bronze_shuriken.png','rangedweapons_bronze_shuriken.png','rangedweapons_bronze_shuriken.png'},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
RANGEDWEAPONS_BRONZESR.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.055 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:bronzesr" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 36
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			else
				local damage = 36
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "rangedweapons:bronze_shuriken")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:bronzesr", RANGEDWEAPONS_BRONZESR)

minetest.register_craft({
	output = 'rangedweapons:bronze_shuriken 32',
	recipe = {
		{'', 'default:bronze_ingot', ''},
		{'default:bronze_ingot', '', 'default:bronze_ingot'},
		{'', 'default:bronze_ingot', ''},
	}
})

minetest.register_craftitem("rangedweapons:gold_shuriken", {
	description = "golden shuriken(ranged damage 7|afected by gravity|survives block hit|velocity 35)",
	range = 0,
	stack_max= 200,
	inventory_image = "rangedweapons_golden_shuriken.png",
	on_use = function(itemstack, user, pointed_thing)
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item()
		end
		if pointed_thing.type ~= "nothing" then
			local pointed = minetest.get_pointed_thing_position(pointed_thing)
			if vector.distance(user:getpos(), pointed) < 8 then
				return itemstack
			end
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir then
			pos.y = pos.y + 1.5
			local obj = minetest.add_entity(pos, "rangedweapons:goldsr")
			if obj then
				obj:setvelocity({x=dir.x * 35, y=dir.y * 35, z=dir.z * 35})
				obj:setacceleration({x=dir.x * -3, y=-10, z=dir.z * -3})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})

local RANGEDWEAPONS_GOLDSR = {
	physical = false,
	timer = 0,
	visual = "cube",
	visual_size = {x=0.5, y=0.0,},
	textures = {'rangedweapons_golden_shuriken.png','rangedweapons_golden_shuriken.png','rangedweapons_golden_shuriken.png','rangedweapons_golden_shuriken.png','rangedweapons_golden_shuriken.png','rangedweapons_golden_shuriken.png'},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
RANGEDWEAPONS_GOLDSR.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.07 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:goldsr" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 17
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			else
				local damage = 17
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "rangedweapons:gold_shuriken")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:goldsr", RANGEDWEAPONS_GOLDSR)

minetest.register_craft({
	output = 'rangedweapons:gold_shuriken 32',
	recipe = {
		{'', 'default:gold_ingot', ''},
		{'default:gold_ingot', '', 'default:gold_ingot'},
		{'', 'default:gold_ingot', ''},
	}
})

minetest.register_craftitem("rangedweapons:mese_shuriken", {
	description = "mese shuriken(ranged damage 7|afected by gravity|survives block hit|velocity 50)",
	range = 0,
	stack_max= 200,
	inventory_image = "rangedweapons_mese_shuriken.png",
	on_use = function(itemstack, user, pointed_thing)
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item()
		end
		if pointed_thing.type ~= "nothing" then
			local pointed = minetest.get_pointed_thing_position(pointed_thing)
			if vector.distance(user:getpos(), pointed) < 8 then
				return itemstack
			end
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir then
			pos.y = pos.y + 1.5
			local obj = minetest.add_entity(pos, "rangedweapons:mesesr")
			if obj then
				obj:setvelocity({x=dir.x * 50, y=dir.y * 50, z=dir.z * 50})
				obj:setacceleration({x=dir.x * -3, y=-10, z=dir.z * -3})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})

local RANGEDWEAPONS_MESESR = {
	physical = false,
	timer = 0,
	visual = "cube",
	visual_size = {x=0.5, y=0.0,},
	textures = {'rangedweapons_mese_shuriken.png','rangedweapons_mese_shuriken.png','rangedweapons_mese_shuriken.png','rangedweapons_mese_shuriken.png','rangedweapons_mese_shuriken.png','rangedweapons_mese_shuriken.png'},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
RANGEDWEAPONS_MESESR.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.055 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:mesesr" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 37
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			else
				local damage = 37
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "rangedweapons:mese_shuriken")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:mesesr", RANGEDWEAPONS_MESESR)

minetest.register_craft({
	output = 'rangedweapons:mese_shuriken 32',
	recipe = {
		{'', 'default:mese_crystal', ''},
		{'default:mese_crystal', '', 'default:mese_crystal'},
		{'', 'default:mese_crystal', ''},
	}
})


minetest.register_craftitem("rangedweapons:diamond_shuriken", {
	description = "diamond shuriken(ranged damage 8|afected by gravity|survives block hit|velocity 50)",
	range = 0,
	stack_max= 200,
	inventory_image = "rangedweapons_diamond_shuriken.png",
	on_use = function(itemstack, user, pointed_thing)
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item()
		end
		if pointed_thing.type ~= "nothing" then
			local pointed = minetest.get_pointed_thing_position(pointed_thing)
			if vector.distance(user:getpos(), pointed) < 8 then
				return itemstack
			end
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir then
			pos.y = pos.y + 1.5
			local obj = minetest.add_entity(pos, "rangedweapons:diamondsr")
			if obj then
				obj:setvelocity({x=dir.x * 50, y=dir.y * 50, z=dir.z * 50})
				obj:setacceleration({x=dir.x * -3, y=-10, z=dir.z * -3})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})

local RANGEDWEAPONS_DIAMONDSR = {
	physical = false,
	timer = 0,
	visual = "cube",
	visual_size = {x=0.5, y=0.0,},
	textures = {'rangedweapons_diamond_shuriken.png','rangedweapons_diamond_shuriken.png','rangedweapons_diamond_shuriken.png','rangedweapons_diamond_shuriken.png','rangedweapons_diamond_shuriken.png','rangedweapons_diamond_shuriken.png'},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
RANGEDWEAPONS_DIAMONDSR.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.055 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:diamondsr" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 38
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			else
				local damage = 38
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "rangedweapons:diamond_shuriken")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:diamondsr", RANGEDWEAPONS_DIAMONDSR)

minetest.register_craft({
	output = 'rangedweapons:diamond_shuriken 32',
	recipe = {
		{'', 'default:diamond', ''},
		{'default:diamond', '', 'default:diamond'},
		{'', 'default:diamond', ''},
	}
})

minetest.register_tool("rangedweapons:jackhammer", {
	description = "jackhammer(ranged damage 10|pellets 9|uses shotgun shells to shoot|velocity 45)",
	wield_scale = {x=3.0,y=3.0,z=2.5},
	inventory_image = "rangedweapons_jackhammer.png",
	on_use = function(itemstack, user, pointed_thing)
		local inv = user:get_inventory()
		if not inv:contains_item("main", "rangedweapons:shell 1") then
			minetest.sound_play("empty", {object=user})
			return itemstack
		end
		if not minetest.setting_getbool("creative_mode") then
			inv:remove_item("main", "rangedweapons:shell")
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir and yaw then
			pos.y = pos.y + 1.6
			local obj = minetest.add_entity(pos, "rangedweapons:jackhammershot")
			if obj then
				minetest.sound_play("shotgun_shoot", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 30})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:jackhammershot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 33})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:jackhammershot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 36})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})
			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:jackhammershot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 39})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:jackhammershot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 42})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:jackhammershot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 27})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:jackhammershot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 24})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})
			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:jackhammershot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 21})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})
			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:jackhammershot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 18})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})
minetest.register_craft({
	output = 'rangedweapons:jackhammer',
	recipe = {
		{'', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steelblock', 'default:steelblock'},
		{'', 'default:diamond', 'default:steel_ingot'},
	}
})

local rangedweapons_jackhammershot = {
	physical = false,
	timer = 0,
	visual = "sprite",
	visual_size = {x=0.25, y=0.25,},
	textures = {'shot.png'},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
rangedweapons_jackhammershot.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.11 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:jackhammershot" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 60
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			else
				local damage = 60
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:jackhammershot", rangedweapons_jackhammershot )

minetest.register_tool("rangedweapons:boomstick", {
	description = "boomstick(ranged damage 4|pellets 11|uses shotgun shells to shoot|velocity 40)",
	wield_scale = {x=1.0,y=1.0,z=2.0},
	inventory_image = "rangedweapons_boomstick.png",
	on_use = function(itemstack, user, pointed_thing)
		local inv = user:get_inventory()
		if not inv:contains_item("main", "rangedweapons:shell 1") then
			minetest.sound_play("empty", {object=user})
			return itemstack
		end
		if not minetest.setting_getbool("creative_mode") then
			inv:remove_item("main", "rangedweapons:shell")
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir and yaw then
			pos.y = pos.y + 1.6
			local obj = minetest.add_entity(pos, "rangedweapons:boomstickshot")
			if obj then
				minetest.sound_play("shotgun_shoot", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 30})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:boomstickshot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 33})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:boomstickshot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 36})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})
			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:boomstickshot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 39})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:boomstickshot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 42})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})
			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:boomstickshot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 45})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})
			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:boomstickshot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 27})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:boomstickshot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 24})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})
			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:boomstickshot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 21})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})
			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:boomstickshot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 18})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})
			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:boomstickshot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 15})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})
minetest.register_craft({
	output = 'rangedweapons:boomstick',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:tree'},
		{'default:tree', 'default:diamond', 'default:tree'},
	}
})

local rangedweapons_boomstickshot = {
	physical = false,
	timer = 0,
	visual = "sprite",
	visual_size = {x=0.25, y=0.25,},
	textures = {'shot.png'},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
rangedweapons_boomstickshot.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.11 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:boomstickshot" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 54
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			else
				local damage = 54
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:boomstickshot", rangedweapons_boomstickshot )


minetest.register_tool("rangedweapons:sawedoff", {
	description = "sawedoff shotgun(ranged damage 5|pellets 7|uses shotgun shells to shoots)",
	wield_scale = {x=1.5,y=1.5,z=2.0},
	inventory_image = "rangedweapons_sawedoff.png",
	on_use = function(itemstack, user, pointed_thing)
		local inv = user:get_inventory()
		if not inv:contains_item("main", "rangedweapons:shell 1") then
			minetest.sound_play("empty", {object=user})
			return itemstack
		end
		if not minetest.setting_getbool("creative_mode") then
			inv:remove_item("main", "rangedweapons:shell")
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir and yaw then
			pos.y = pos.y + 1.6
			local obj = minetest.add_entity(pos, "rangedweapons:sawedoffshot")
			if obj then
				minetest.sound_play("shotgun_shoot", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 30})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:sawedoffshot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 33})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:sawedoffshot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 36})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})
			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:sawedoffshot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 39})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:sawedoffshot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 27})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:sawedoffshot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 24})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})
			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:sawedoffshot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 21})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})
minetest.register_craft({
	output = 'rangedweapons:sawedoff',
	recipe = {
		{'default:tree', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'default:diamond', 'default:tree'},
	}
})

local rangedweapons_sawedoffshot = {
	physical = false,
	timer = 0,
	visual = "sprite",
	visual_size = {x=0.25, y=0.25,},
	textures = {'shot.png'},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
rangedweapons_sawedoffshot.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.10 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:sawedoffshot" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 45
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			else
				local damage = 45
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:sawedoffshot", rangedweapons_sawedoffshot )


minetest.register_tool("rangedweapons:spas12", {
	description = "spas-12(ranged damage 8|pellets 5|uses shotgun shells to shoot)",
	wield_scale = {x=1.5,y=1.5,z=1.5},
	inventory_image = "rangedweapons_spas12.png",
	on_use = function(itemstack, user, pointed_thing)
		local inv = user:get_inventory()
		if not inv:contains_item("main", "rangedweapons:shell 1") then
			minetest.sound_play("empty", {object=user})
			return itemstack
		end
		if not minetest.setting_getbool("creative_mode") then
			inv:remove_item("main", "rangedweapons:shell")
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir and yaw then
			pos.y = pos.y + 1.6
			local obj = minetest.add_entity(pos, "rangedweapons:spas12shot")
			if obj then
				minetest.sound_play("shotgun_shoot", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 30})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:spas12shot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 35})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:spas12shot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 40})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:spas12shot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 25})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

			pos.y = pos.y + 0
			local obj = minetest.add_entity(pos, "rangedweapons:spas12shot")
				minetest.sound_play("", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 20})
				obj:setacceleration({x=dir.x * 0, y= 0, z=dir.z * 0})

				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})
minetest.register_craft({
	output = 'rangedweapons:spas12',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'dye:black', 'default:diamond', 'default:steel_ingot'},
	}
})
local rangedweapons_spas12shot = {
	physical = false,
	timer = 0,
	visual = "sprite",
	visual_size = {x=0.25, y=0.25,},
	textures = {'shot.png'},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
rangedweapons_spas12shot.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.1 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:spas12shot" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 68
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			else
				local damage = 68
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:spas12shot", rangedweapons_spas12shot )

minetest.register_craftitem("rangedweapons:shell", {
	wield_scale = {x=0.2,y=0.2,z=0.75},
	stack_max= 500,
	description = "shotgun shell(ammunition for shotguns)",
	inventory_image = "rangedweapons_shell.png",
})
minetest.register_craft({
	output = 'rangedweapons:shell 25',
	recipe = {
		{'default:steel_ingot', 'dye:red', 'default:steel_ingot'},
		{'tnt:gunpowder', 'tnt:gunpowder', 'tnt:gunpowder'},
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
	}
})

minetest.register_tool("rangedweapons:makarov", {
	description = "makarov(ranged damage 5|uses 9mm bullets to shoot|velocity 45)",
	wield_scale = {x=0.75,y=0.75,z=0.85},
	inventory_image = "rangedweapons_makarov.png",
	on_use = function(itemstack, user, pointed_thing)
		local inv = user:get_inventory()
		if not inv:contains_item("main", "rangedweapons:9mm 1") then
			minetest.sound_play("rangedweapons_empty", {object=user})
			return itemstack
		end
		if not minetest.setting_getbool("creative_mode") then
			inv:remove_item("main", "rangedweapons:9mm")
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir and yaw then
			pos.y = pos.y + 1.6
			local obj = minetest.add_entity(pos, "rangedweapons:makarovshot")
			if obj then
				minetest.sound_play("handgun_shoot", {object=obj})
				obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 45})
				obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})
minetest.register_craft({
	output = 'rangedweapons:makarov',
	recipe = {
		{'', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'default:mese_crystal_fragment', 'default:tree'},
		{'', '', 'dye:black'},
	}
})

local rangedweapons_makarovshot = {
	physical = false,
	timer = 0,
	visual = "wielditem",
	visual_size = {x=0.3, y=0.3},
	textures = {"rangedweapons:handgunshot"},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
rangedweapons_makarovshot.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.065 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:makarovshot" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 75
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			else
				local damage = 75
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:makarovshot", rangedweapons_makarovshot )

minetest.register_tool("rangedweapons:bereta", {
	description = "bereta 98(ranged damage 6|uses 9mm bullets to shoot|velocity 50)",
	wield_scale = {x=1.0,y=1.0,z=1.0},
	inventory_image = "rangedweapons_bereta.png",
	on_use = function(itemstack, user, pointed_thing)
		local inv = user:get_inventory()
		if not inv:contains_item("main", "rangedweapons:9mm 1") then
			minetest.sound_play("rangedweapons_empty", {object=user})
			return itemstack
		end
		if not minetest.setting_getbool("creative_mode") then
			inv:remove_item("main", "rangedweapons:9mm")
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir and yaw then
			pos.y = pos.y + 1.6
			local obj = minetest.add_entity(pos, "rangedweapons:beretashot")
			if obj then
				minetest.sound_play("handgun_shoot", {object=obj})
				obj:setvelocity({x=dir.x * 50, y=dir.y * 50, z=dir.z * 50})
				obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})
minetest.register_craft({
	output = 'rangedweapons:bereta',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'default:mese_crystal_fragment', 'default:steel_ingot'},
		{'', '', 'dye:black'},
	}
})

local rangedweapons_beretashot = {
	physical = false,
	timer = 0,
	visual = "wielditem",
	visual_size = {x=0.3, y=0.3},
	textures = {"rangedweapons:handgunshot"},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
rangedweapons_beretashot.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.055 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:beretashot" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 46
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			else
				local damage = 46
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:beretashot", rangedweapons_beretashot )


minetest.register_tool("rangedweapons:deagle", {
	description = "desert eagle(ranged damage 9|uses 375 bullets to shoot|velocity 55)",
	wield_scale = {x=1.0,y=1.0,z=1.0},
	inventory_image = "rangedweapons_deagle.png",
	on_use = function(itemstack, user, pointed_thing)
		local inv = user:get_inventory()
		if not inv:contains_item("main", "rangedweapons:375 1") then
			minetest.sound_play("rangedweapons_empty", {object=user})
			return itemstack
		end
		if not minetest.setting_getbool("creative_mode") then
			inv:remove_item("main", "rangedweapons:375")
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir and yaw then
			pos.y = pos.y + 1.6
			local obj = minetest.add_entity(pos, "rangedweapons:deagleshot")
			if obj then
				minetest.sound_play("handgun_shoot", {object=obj})
				obj:setvelocity({x=dir.x * 55, y=dir.y * 55, z=dir.z * 55})
				obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})
minetest.register_craft({
	output = 'rangedweapons:deagle',
	recipe = {
		{'default:silver_ingot', 'default:silver_ingot', 'default:silver_ingot'},
		{'', 'default:mese_crystal_fragment', 'default:silver_ingot'},
		{'', '', 'dye:black'},
	}
})

local rangedweapons_deagleshot = {
	physical = false,
	timer = 0,
	visual = "wielditem",
	visual_size = {x=0.3, y=0.3},
	textures = {"rangedweapons:revolvershot"},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
rangedweapons_deagleshot.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.05 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:deagleshot" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 69
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			else
				local damage = 69
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:deagleshot", rangedweapons_deagleshot )

minetest.register_craftitem("rangedweapons:9mm", {
	stack_max= 500,
	wield_scale = {x=0.2,y=0.2,z=0.75},
	description = "9mm bullet(ammunition for handguns)",
	inventory_image = "rangedweapons_9mm.png",
})

minetest.register_craft({
	output = 'rangedweapons:9mm 30',
	recipe = {
		{'default:steel_ingot', '', ''},
		{'tnt:gunpowder', '', ''},
		{'default:copper_ingot', '', ''},
	}
})

minetest.register_tool("rangedweapons:python", {
	description = "python(ranged damage 11|uses 375 bullets to shoot|velocity 90)",
	wield_scale = {x=1.0,y=1.0,z=1.0},
	inventory_image = "rangedweapons_python.png",
	on_use = function(itemstack, user, pointed_thing)
		local inv = user:get_inventory()
		if not inv:contains_item("main", "rangedweapons:375 1") then
			minetest.sound_play("rangedweapons_empty", {object=user})
			return itemstack
		end
		if not minetest.setting_getbool("creative_mode") then
			inv:remove_item("main", "rangedweapons:375")
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir and yaw then
			pos.y = pos.y + 1.6
			local obj = minetest.add_entity(pos, "rangedweapons:pythonshot")
			if obj then
				minetest.sound_play("handgun_shoot", {object=obj})
				obj:setvelocity({x=dir.x * 90, y=dir.y * 90, z=dir.z * 90})
				obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})
minetest.register_craft({
	output = 'rangedweapons:python',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'default:mese_crystal', 'default:tree'},
		{'', '', 'default:tree'},
	}
})

local rangedweapons_pythonshot = {
	physical = false,
	timer = 0,
	visual = "wielditem",
	visual_size = {x=0.3, y=0.3},
	textures = {"rangedweapons:revolvershot"},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
rangedweapons_pythonshot.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.02 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:pythonshot" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 71
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			else
				local damage = 71
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:pythonshot", rangedweapons_pythonshot )


minetest.register_tool("rangedweapons:taurus", {
	description = "taurus(ranged damage 10|uses 375 bullets to shoot|velocity 100)",
	wield_scale = {x=0.9,y=0.9,z=0.9},
	inventory_image = "rangedweapons_taurus.png",
	on_use = function(itemstack, user, pointed_thing)
		local inv = user:get_inventory()
		if not inv:contains_item("main", "rangedweapons:375 1") then
			minetest.sound_play("rangedweapons_empty", {object=user})
			return itemstack
		end
		if not minetest.setting_getbool("creative_mode") then
			inv:remove_item("main", "rangedweapons:375")
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir and yaw then
			pos.y = pos.y + 1.6
			local obj = minetest.add_entity(pos, "rangedweapons:taurusshot")
			if obj then
				minetest.sound_play("handgun_shoot", {object=obj})
				obj:setvelocity({x=dir.x * 100, y=dir.y * 100, z=dir.z * 100})
				obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})
minetest.register_craft({
	output = 'rangedweapons:taurus',
	recipe = {
		{'', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'default:mese_crystal', 'default:tree'},
		{'', '', 'dye:black'},
	}
})

local rangedweapons_taurusshot = {
	physical = false,
	timer = 0,
	visual = "wielditem",
	visual_size = {x=0.3, y=0.3},
	textures = {"rangedweapons:revolvershot"},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
rangedweapons_taurusshot.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.018 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:taurusshot" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 40
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			else
				local damage = 40
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:taurusshot", rangedweapons_taurusshot )


minetest.register_tool("rangedweapons:colt45", {
	description = "colt45(ranged damage 12|uses 375 bullets to shoot|velocity 80)",
	wield_scale = {x=1.0,y=1.0,z=1.0},
	inventory_image = "rangedweapons_colt45.png",
	on_use = function(itemstack, user, pointed_thing)
		local inv = user:get_inventory()
		if not inv:contains_item("main", "rangedweapons:375 1") then
			minetest.sound_play("rangedweapons_empty", {object=user})
			return itemstack
		end
		if not minetest.setting_getbool("creative_mode") then
			inv:remove_item("main", "rangedweapons:375")
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir and yaw then
			pos.y = pos.y + 1.6
			local obj = minetest.add_entity(pos, "rangedweapons:colt45shot")
			if obj then
				minetest.sound_play("handgun_shoot", {object=obj})
				obj:setvelocity({x=dir.x * 80, y=dir.y * 80, z=dir.z * 80})
				obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})
minetest.register_craft({
	output = 'rangedweapons:colt45',
	recipe = {
		{'', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'default:mese_crystal', 'default:tree'},
		{'', '', 'dye:black'},
	}
})

local rangedweapons_colt45shot = {
	physical = false,
	timer = 0,
	visual = "wielditem",
	visual_size = {x=0.3, y=0.3},
	textures = {"rangedweapons:revolvershot"},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
rangedweapons_colt45shot.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.022 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:colt45shot" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 42
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			else
				local damage = 42
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:colt45shot", rangedweapons_colt45shot )


minetest.register_craftitem("rangedweapons:375", {
	stack_max= 500,
	description = "375 bullet(ammunition for revolvers and magnums)",
	wield_scale = {x=0.2,y=0.2,z=0.75},
	inventory_image = "rangedweapons_375.png",
})

minetest.register_craft({
	output = 'rangedweapons:375 20',
	recipe = {
		{'default:copper_ingot', '', ''},
		{'default:copper_ingot', '', ''},
		{'tnt:gunpowder', '', ''},
	}
})

minetest.register_tool("rangedweapons:leenfield", {
	description = "le enfield(ranged damage 15|uses 10mm bullets to shoot|velocity 75|penetrates targets)",
	wield_scale = {x=1.75,y=1.75,z=1.0},
	inventory_image = "rangedweapons_leenfield.png",
	on_use = function(itemstack, user, pointed_thing)
		local inv = user:get_inventory()
		if not inv:contains_item("main", "rangedweapons:10mm 1") then
			minetest.sound_play("rangedweapons_empty", {object=user})
			return itemstack
		end
		if not minetest.setting_getbool("creative_mode") then
			inv:remove_item("main", "rangedweapons:10mm")
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir and yaw then
			pos.y = pos.y + 1.6
			local obj = minetest.add_entity(pos, "rangedweapons:leenfieldshot")
			if obj then
				minetest.sound_play("rifle_shoot", {object=obj})
				obj:setvelocity({x=dir.x * 75, y=dir.y * 75, z=dir.z * 75})
				obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})
minetest.register_craft({
	output = 'rangedweapons:leenfield',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:tree', 'default:tree', 'default:tree'},
		{'default:steel_ingot', 'default:diamond', 'dye:red'},
	}
})

local rangedweapons_leenfieldshot = {
	physical = false,
	timer = 0,
	visual = "wielditem",
	visual_size = {x=0.3, y=0.3},
	textures = {"rangedweapons:rifleshot"},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
rangedweapons_leenfieldshot.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.04 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:leenfieldshot" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 85
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				end
			else
				local damage = 85
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:leenfieldshot", rangedweapons_leenfieldshot )

minetest.register_tool("rangedweapons:mosinnagant", {
	description = "mosin nagant(ranged damage 15|uses 10mm bullets to shoot|velocity 70|penetrates targets)",
	wield_scale = {x=1.75,y=1.75,z=1.0},
	inventory_image = "rangedweapons_mosinnagant.png",
	on_use = function(itemstack, user, pointed_thing)
		local inv = user:get_inventory()
		if not inv:contains_item("main", "rangedweapons:10mm 1") then
			minetest.sound_play("rangedweapons_empty", {object=user})
			return itemstack
		end
		if not minetest.setting_getbool("creative_mode") then
			inv:remove_item("main", "rangedweapons:10mm")
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir and yaw then
			pos.y = pos.y + 1.6
			local obj = minetest.add_entity(pos, "rangedweapons:mosinnagantshot")
			if obj then
				minetest.sound_play("rifle_shoot", {object=obj})
				obj:setvelocity({x=dir.x * 70, y=dir.y * 70, z=dir.z * 70})
				obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})
minetest.register_craft({
	output = 'rangedweapons:mosinnagant',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:tree', 'default:tree', 'default:tree'},
		{'default:steel_ingot', 'default:diamond', ''},
	}
})

local rangedweapons_mosinnagantshot = {
	physical = false,
	timer = 0,
	visual = "wielditem",
	visual_size = {x=0.3, y=0.3},
	textures = {"rangedweapons:rifleshot"},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
rangedweapons_mosinnagantshot.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.04 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:mosinnagantshot" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 65
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				end
			else
				local damage = 65
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:mosinnagantshot", rangedweapons_mosinnagantshot )


minetest.register_tool("rangedweapons:scout", {
	description = "scout(ranged damage 18|uses 10mm bullets to shoot|velocity 80|penetrates targets)",
	wield_scale = {x=1.75,y=1.75,z=1.0},
	inventory_image = "rangedweapons_scout.png",
	on_use = function(itemstack, user, pointed_thing)
		local inv = user:get_inventory()
		if not inv:contains_item("main", "rangedweapons:10mm 1") then
			minetest.sound_play("rangedweapons_empty", {object=user})
			return itemstack
		end
		if not minetest.setting_getbool("creative_mode") then
			inv:remove_item("main", "rangedweapons:10mm")
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir and yaw then
			pos.y = pos.y + 1.6
			local obj = minetest.add_entity(pos, "rangedweapons:scoutshot")
			if obj then
				minetest.sound_play("rifle_shoot", {object=obj})
				obj:setvelocity({x=dir.x * 80, y=dir.y * 80, z=dir.z * 80})
				obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})
minetest.register_craft({
	output = 'rangedweapons:scout',
	recipe = {
		{'default:diamond', 'default:steel_ingot', ''},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'dye:cyan', 'default:diamond', 'default:steel_ingot'},

	}
})

local rangedweapons_scoutshot = {
	physical = false,
	timer = 0,
	visual = "wielditem",
	visual_size = {x=0.3, y=0.3},
	textures = {"rangedweapons:rifleshot"},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
rangedweapons_scoutshot.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.04 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:scoutshot" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 88
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				end
			else
				local damage = 88
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:scoutshot", rangedweapons_scoutshot )


minetest.register_tool("rangedweapons:awp", {
	description = "awp(ranged damage 20|uses 10mm bullets to shoot|velocity 90|penetrates targets)",
	wield_scale = {x=1.75,y=1.75,z=1.0},
	inventory_image = "rangedweapons_awp.png",
	on_use = function(itemstack, user, pointed_thing)
		local inv = user:get_inventory()
		if not inv:contains_item("main", "rangedweapons:10mm 1") then
			minetest.sound_play("rangedweapons_empty", {object=user})
			return itemstack
		end
		if not minetest.setting_getbool("creative_mode") then
			inv:remove_item("main", "rangedweapons:10mm")
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir and yaw then
			pos.y = pos.y + 1.6
			local obj = minetest.add_entity(pos, "rangedweapons:awpshot")
			if obj then
				minetest.sound_play("rifle_shoot", {object=obj})
				obj:setvelocity({x=dir.x * 90, y=dir.y * 90, z=dir.z * 90})
				obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})
minetest.register_craft({
	output = 'rangedweapons:awp',
	recipe = {
		{'default:diamond', 'default:steel_ingot', 'default:diamond'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'dye:green', 'default:diamond', 'default:steel_ingot'},

	}
})

local rangedweapons_awpshot = {
	physical = false,
	timer = 0,
	visual = "wielditem",
	visual_size = {x=0.3, y=0.3},
	textures = {"rangedweapons:revolvershot"},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
rangedweapons_awpshot.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.04 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:awpshot" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 90
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				end
			else
				local damage = 90
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:awpshot", rangedweapons_awpshot )



minetest.register_craftitem("rangedweapons:10mm", {
	stack_max= 500,
	description = "10mm bullet(ammunition for rifles)",
	wield_scale = {x=0.2,y=0.2,z=0.75},
	inventory_image = "rangedweapons_10mm.png",
})


minetest.register_craft({
	output = 'rangedweapons:10mm 25',
	recipe = {
		{'', 'default:copper_ingot', ''},
		{'default:copper_ingot', 'tnt:gunpowder', 'default:copper_ingot'},
		{'default:copper_ingot', 'tnt:gunpowder', 'default:copper_ingot'},
	}
})


minetest.register_tool("rangedweapons:electrogun", {
	description = "electrogun(ranged damage 4|uses energy charges to shoot|velocity 2|shoots slow moving electro balls that contonously hurts and penetrates targets)",
	wield_scale = {x=3.50,y=3.5,z=2.0},
	inventory_image = "rangedweapons_electrogun.png",
	on_use = function(itemstack, user, pointed_thing)
		local inv = user:get_inventory()
		if not inv:contains_item("main", "rangedweapons:energycharge 1") then
			minetest.sound_play("rangedweapons_empty", {object=user})
			return itemstack
		end
		if not minetest.setting_getbool("creative_mode") then
			inv:remove_item("main", "rangedweapons:energycharge")
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir and yaw then
			pos.y = pos.y + 1.6
			local obj = minetest.add_entity(pos, "rangedweapons:electrogunshot")
			if obj then
				minetest.sound_play("rifle_shoot", {object=obj})
				obj:setvelocity({x=dir.x * 2, y=dir.y * 2, z=dir.z * 2})
				obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})
minetest.register_craft({
	output = 'rangedweapons:electrogun',
	recipe = {
		{'default:goldblock', 'default:mithrilblock', 'default:goldblock'},
		{'default:diamondblock', 'default:diamondblock', 'default:steelblock'},
		{'default:mese', 'default:steelblock', 'default:mese'},
	}
})

local rangedweapons_electrogunshot = {
	physical = false,
	timer = 0,
	visual = "sprite",
	visual_size = {x=3, y=3},
	textures = {"rangedweapons_electroball.png"},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
rangedweapons_electrogunshot.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 1.5 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 3)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:electrogunshot" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 34
					obj:punch(self.object, 0.1, {
						full_punch_interval = 0.1,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				end
			else
				local damage = 34
				obj:punch(self.object, 0.1, {
					full_punch_interval = 0.1,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:electrogunshot", rangedweapons_electrogunshot )


minetest.register_tool("rangedweapons:laser", {
	description = "laser rifle(ranged damage 15|uses energy charges to shoot|velocity 30|penetrates targets and blocks)",
	wield_scale = {x=2.0,y=2.0,z=2.0},
	inventory_image = "rangedweapons_laser.png",
	on_use = function(itemstack, user, pointed_thing)
		local inv = user:get_inventory()
		if not inv:contains_item("main", "rangedweapons:energycharge 1") then
			minetest.sound_play("rangedweapons_empty", {object=user})
			return itemstack
		end
		if not minetest.setting_getbool("creative_mode") then
			inv:remove_item("main", "rangedweapons:energycharge")
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir and yaw then
			pos.y = pos.y + 1.6
			local obj = minetest.add_entity(pos, "rangedweapons:lasershot")
			if obj then
				minetest.sound_play("rifle_shoot", {object=obj})
				obj:setvelocity({x=dir.x * 30, y=dir.y * 30, z=dir.z * 30})
				obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})
minetest.register_craft({
	output = 'rangedweapons:laser',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:goldblock'},
		{'default:mithrilblock', 'default:diamondblock', 'default:goldblock'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:gold_ingot'},
	}
})

local rangedweapons_lasershot = {
	physical = false,
	timer = 0,
	visual = "wielditem",
	visual_size = {x=1, y=1},
	textures = {"rangedweapons:lasershot"},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
rangedweapons_lasershot.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.1 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "rangedweapons:lasershot" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 75
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
				end
			else
				local damage = 75
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.9})
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "")
			end
			minetest.sound_play("default_dig_cracky", {pos = self.lastpos, gain = 0.8})
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("rangedweapons:lasershot", rangedweapons_lasershot )


minetest.register_craftitem("rangedweapons:energycharge", {
	stack_max= 500,
	description = "energy charge(ammunition for special guns)",
	wield_scale = {x=0.2,y=0.2,z=0.75},
	inventory_image = "rangedweapons_energycharge.png",
})


minetest.register_craft({
	output = 'rangedweapons:energycharge 20',
	recipe = {
		{'', 'default:gold_ingot', ''},
		{'', 'default:mithril_ingot', ''},
		{'', 'default:diamond', ''},
	}
})
