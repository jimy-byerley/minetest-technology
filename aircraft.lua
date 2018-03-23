

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


--[[
Exportation des animations depuis blender:
il faut avoir la config suivante:
+ export normals
+ flip normals
+ export UV coords
+ export skin weight
- apply modifier
+ export armature bones
+ export rest animation
+ export animations
+ include frame rate
]]

local patroller = {
	hp_max = 400,
	physical = true,
	collisionbox = {-2.5,-7,-2.5, 2.5,4,2.5},
	visual = "mesh",
	mesh = "patroller.x",
	textures = {"technology_patroller.png"},
	--automatic_rotate = true,
	--makes_footstep_sound = true,
	--spritediv = {x=1, y=1},
	--initial_sprite_basepos = {x=0, y=0},
	--is_visible = true,
	can_punch = true,
	
	driver = nil,
	front_vel_target = 0,  -- 0 is no speed, 1 is maximum speed
	vert_vel_target = 0,
	
	max_front_vel = 10,
	max_vert_vel = 7,	
}

local FPS = 15    -- frame per second for animations
local WEAPONS = minetest.get_modpath("firearms_guns") or false -- auto enable weapon support

function patroller:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
	if self.driver and puncher == self.driver then
		self:fire(self.driver:get_look_dir())
	end
	--[[
	self.object:remove()
	if puncher and puncher:is_player() then
		puncher:get_inventory():add_item("main", "technology:patroller")
	end
	]]
end

function patroller:fire(direction)
	if WEAPONS then
		local p = self.object:getpos()
		p.y = p.y-7
		firearmslib.fire("technology:air_canon", p, direction)
	end
end

if WEAPONS then
	--[[
	firearmslib.register_bullet("technology:air_canon_ammo", {
		description = "5mm  air canon amunition";
		inventory_image = "firearms_bullet_556.png";
		damage = 12;
		power = 5;
		gravity = 0;
	});
	
	firearmslib.register_firearm("technology:air_canon", {
		description = "5mm air canon";
		inventory_image = "firearms_m4.png";
		bullets = "technology:air_canon_ammo";
		clip_size = 42;
		spread = 0.035;
		burst = 3;
		burst_interval = 0.15;
		wield_scale = {x=2,y=2,z=2};
		crosshair_image = "firearms_crosshair_rifle.png";
		hud_image = "firearms_m4_hud.png";
		sounds = {
			shoot = "firearms_m4_shot";
			empty = "firearms_default_empty";
			reload = "firearms_rifle_reload";
		};
	});
	]]
	
	firearmslib.register_bullet("technology:air_canon_ammo", {
		description = "Rocket";
		inventory_image = "firearms_rocket.png";
		texture = "firearms_rocket_entity.png";
		damage = 10;
		power = 5;
		speed = 25;
		gravity = 0;
		explosion_range = 2.5;
		explosion_damage = 6;
		leaves_smoke = true;
		on_destroy = firearmslib.on_destroy_explode;
	});

	firearmslib.register_firearm("technology:air_canon", {
		description = "Bazooka";
		inventory_image = "firearms_bazooka.png";
		bullets = "technology:air_canon_ammo";
		clip_size = 5;
		spread = 0.035;
		wield_scale = {x=3,y=3,z=3};
		crosshair_image = "firearms_crosshair_rlauncher.png";
		hud_image = "firearms_bazooka_hud.png";
		sounds = {
			shoot = "firearms_m79_shot"; -- TODO: Find a better sound
			empty = "firearms_default_empty";
			--reload = "firearms_default_reload";
		};
	});
end

function patroller:on_rightclick(clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	if self.driver and clicker == self.driver then
		self.driver = nil
		self.object:set_animation({x=54, y=54}, FPS, 0)
		local pos = self.object:getpos()
		local yaw = self.object:getyaw()
		pos.x = pos.x - 4*math.cos(yaw)
		pos.y = pos.y - 3
		pos.z = pos.z - 4*math.sin(yaw)
		clicker:set_detach()
		default.player_set_animation(clicker, "stand" , 30)
		minetest.after(0.2, function()
				clicker:setpos(pos)
			end)
		--self.object:setvelocity({x=0, y=0, z=0})
		self.front_vel_target = 0
		self.vert_vel_target = 0
	elseif not self.driver then
		self.driver = clicker
		clicker:set_attach(self.object, "", {x=0,y=0,z=10}, {x=0,y=0,z=-10})
		default.player_set_animation(clicker, "sit" , 30)
		self.object:set_animation({x=60, y=60}, FPS, 0)
	end
end

function patroller:on_activate(staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	--[[
	if staticdata then
		self.v = tonumber(staticdata)
	end
	]]
end


function patroller:get_staticdata()
	return "" --tostring(v)
end



local command_increment = 0.05
hunter_step_tick = 0

function patroller:on_step(dtime)
	-- make fire if damages are over 50%
	-- explode when hp is under 5
	hunter_step_tick = hunter_step_tick+dtime
	if self.object:get_hp() < 5 then
		explosion(self.object:getpos(), 30)
	end
	
	local command = false
	--[[
	if math.random(1,10) == 1 then
		local yaw = self.object:getyaw()
		local dir = {
			x = math.cos(yaw),
			y = 0,
			z = math.sin(yaw),
		}
		self:fire(dir)
	end
	]]
	
	if self.driver then
		local ctrl = self.driver:get_player_control()
		if hunter_step_tick > 0.1 then
			hunter_step_tick = 0
			-- have user commands
			if ctrl.up and self.front_vel_target < 1 then
				self.front_vel_target = self.front_vel_target + command_increment
				command = true
			elseif ctrl.down and self.front_vel_target > -0.05 then
				self.front_vel_target = self.front_vel_target - command_increment
				command = true
			end
			if ctrl.jump and self.vert_vel_target < 1 then
				self.vert_vel_target = self.vert_vel_target + command_increment
				command = true
			elseif ctrl.sneak and self.vert_vel_target > -1 then
				self.vert_vel_target = self.vert_vel_target - command_increment
				command = true
			end
		end
		if ctrl.left then
			self.object:setyaw(self.object:getyaw()+math.pi/120+dtime*math.pi/120)
			self.object:set_animation({x=5, y=5}, FPS, 0)
			command = true
		elseif ctrl.right then
			self.object:setyaw(self.object:getyaw()-math.pi/120-dtime*math.pi/120)
			self.object:set_animation({x=10, y=10}, FPS, 0)
			command = true
		else
			--self.object:set_animation({x=60, y=60}, FPS, 0)
		end
	else
		self.front_vel_target = 0
		self.vert_vel_target = 0
		--command = true
		self.object:setvelocity({x=0, y=0, z=0})
		self.object:set_animation({x=54, y=54}, FPS, 0)
	end
	
	if command then
		local yaw = self.object:getyaw()
		self.object:setvelocity({
			x = self.front_vel_target * self.max_front_vel * math.cos(yaw),
			y = self.vert_vel_target * self.max_vert_vel,
			z = self.front_vel_target * self.max_front_vel * math.sin(yaw),
		})
		if self.vert_vel_target < 0 then
			local frame = 40-5*self.vert_vel_target + 0.5
			self.object:set_animation({x=frame, y=frame}, FPS, 0)
		else
			local frame = 30+5*self.vert_vel_target - 0.5
			self.object:set_animation({x=frame, y=frame}, FPS, 0)
		end
	end
	--[[
	local Kf = 3.1
	local Kv = 3.1
	local v = self.object:getvelocity()
	local yaw = self.object:getyaw()
	local front_vel = v.x * -math.sin(yaw) + v.z * math.cos(yaw)
	local vert_vel = v.y
	local front_acc = Kf*(self.max_front_vel*self.front_vel_target - front_vel)
	local vert_acc = Kv*(self.max_vert_vel*self.vert_vel_target - vert_vel)
	self.object:setacceleration({x=-front_acc*math.sin(yaw), y=vert_acc, z=front_acc*math.cos(yaw)})
	]]
	--print("command "..self.front_vel_target.."  "..self.vert_vel_target)
	--print("command "..front_acc.."  "..vert_acc)
	
end

minetest.register_entity("technology:patroller", patroller)


minetest.register_craftitem("technology:patroller", {
	description = "patroller flying",
	inventory_image = "hunter_inv.png",
	wield_image = "hunter_inv.png",
	wield_scale = {x=2, y=2, z=1},
	liquids_pointable = true,
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		print("patroller added !!!")
		pointed_thing.under.y = pointed_thing.under.y+2
		minetest.env:add_entity(pointed_thing.under, "technology:patroller")
		itemstack:take_item()
		return itemstack
	end,
})

technology.register_plan("PATROLLER", "technology:patroller", "technology_plan_patroller.png", {
	"technic:hv_transformer",
	"technic:mv_transformer",
	"technic:motor 8",
	"technology:wire 10",
	"default:steel_ingot 6",
	"default:silver_ingot 1",
	"default:mese 1",
	"firearms:shell_12 1",
})

