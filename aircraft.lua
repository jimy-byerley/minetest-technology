
local function get_sign(i)
	if i == 0 then
		return 0
	else
		return i/math.abs(i)
	end
end

local function get_velocity(v, yaw, y)
	local x = math.cos(yaw)*v
	local z = math.sin(yaw)*v
	return {x=x, y=y, z=z}
end

local function get_v(v)
	return math.sqrt(v.x^2+v.z^2)
end
--[[
minetest.register_abm({
	nodenames = {"air"},
	interval = 10,
	chance  = 0.1,
	action = function(pos, timer)
		minetest.env:clear_objects()
	end,
})
]]

local hunter = {
	hp_max = 100,
	physical = true,
	collisionbox = {-2.5,-7,-2.5, 2.5,4,2.5},
	visual = "mesh",
	mesh = "patrouilleur.x",
	textures = {"patrouilleur.png"},
	automatic_rotate = true,
	makes_footstep_sound = true,
	spritediv = {x=1, y=1},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = true,
	
	driver = nil,
	v = 0,
	z = 0,
}

function hunter:on_rightclick(clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	if self.driver and clicker == self.driver then
		self.driver = nil
		self.object:set_animation({x=50, y=55}, 15, 1)
		local p = get_velocity(3, self.object:getyaw(), 3)
		local pos = self.object:getpos()
		pos.x = pos.x-p.x
		pos.y = pos.y-p.y
		pos.z = pos.z-p.z
		clicker:set_detach()
		clicker:setpos(pos)
		self.object:setvelocity({x=0, y=0, z=0})
	elseif not self.driver then
		self.driver = clicker
		clicker:set_attach(self.object, "", {x=0,y=0,z=0}, {x=0,y=0,z=0})
		self.object:set_animation({x=55, y=60}, 15, 1)
	end
end

function hunter:on_activate(staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	if staticdata then
		self.v = tonumber(staticdata)
	end
end

function hunter:get_staticdata()
	return tostring(v)
end

function hunter:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
	self.object:remove()
	if puncher and puncher:is_player() then
		puncher:get_inventory():add_item("main", "technology:hunter")
	end
end

function hunter:on_step(dtime)
	-- make fire if damages are over 50%
	if self.object:get_hp() < 50 then
		print("hunter is burning")
		local pos = self.object:getpos()
		pos.x = pos.x + math.random(-2,2)
		pos.y = pos.y + math.random(-2,2)
		pos.z = pos.z + math.random(-2,2)
		minetest.env:set_node(pos, {name="fire:basic_flame"})
		self.z = self.z - 0.1
	end
	-- explode when hp is under 5
	if self.object:get_hp() < 5 then
		explosion(self.object:getpos(), 30)
	end
	local velocity = self.object:getvelocity()
	-- have user commands
	self.v = get_v(velocity)*get_sign(self.v)
	if self.driver then
		local ctrl = self.driver:get_player_control()
		if ctrl.up then
			self.v = self.v+0.4
		end
		if ctrl.down then
			self.v = self.v-0.4
		end
		if ctrl.left then
			self.object:setyaw(self.object:getyaw()+math.pi/120+dtime*math.pi/120)
			--self.object:set_animation({x=5, y=5}, 1, 0)
		end
		if ctrl.right then
			self.object:setyaw(self.object:getyaw()-math.pi/120-dtime*math.pi/120)
			--self.object:set_animation({x=15, y=15}, 1, 0)
		end
		if ctrl.jump then
			self.z = self.z+0.15
		end
		if ctrl.sneak then
			self.z = self.z-0.15
		end
	end
	local z = get_sign(self.z)
	self.z = self.z - 0.02*z
	if z ~= get_sign(self.z) then
		self.object:setvelocity({x=0,y=0,z=0})
		self.z = 0
		return
	end
	if math.abs(self.z) > 4.5 then
		self.z = 4.5*get_sign(self.z)
	end
	
	local s = get_sign(self.v)
	self.v = self.v - 0.02*s
	if s ~= get_sign(self.v) then
		self.object:setvelocity({x=0, y=0, z=0})
		self.v = 0
		return
	end
	if math.abs(self.v) > 6 then
		self.v = 6*get_sign(self.v)
	end

	self.object:setacceleration({x=0, y=0, z=0})
	if math.abs(self.object:getvelocity().y) < 0.01 then
		local pos = self.object:getpos()
		pos.y = math.floor(pos.y)+0
		self.object:setpos(pos)
		self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.z))
	else
		self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.z))
	end
end

minetest.register_entity("technology:hunter", hunter)


minetest.register_craftitem("technology:hunter", {
	description = "hunter flying",
	inventory_image = "hunter_inv.png",
	wield_image = "hunter_inv.png",
	wield_scale = {x=2, y=2, z=1},
	liquids_pointable = true,
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		print("hunter added !!!")
		pointed_thing.under.y = pointed_thing.under.y+2
		minetest.env:add_entity(pointed_thing.under, "technology:hunter")
		itemstack:take_item()
		return itemstack
	end,
})

