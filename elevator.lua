local elevator = {
	hp_max = 400,
	can_punch = true,
	physical = true,
	collisionbox = {-0.95, -0.5, -0.95, 0.95, 2.5, 0.95},
	visual = "mesh",
	mesh = "elevator.x",
	textures = {"technology_elevator.png"},
	
	item = "technology:elevator",
	
	marks = {},			-- list of floors to stop to
	passengers = {},	-- list of current passengers
	direction = 0,
	direction_change = false, -- enable for step to take the direction change in count
	target = 0,	-- altitude to reach
}

local elevator_radius = 1
local elevator_speed = 3
local elevator_rail = "technology:elevator_rail"
local elevator_mark = "default:sign_wall_steel"
local elevator_entity = "technology:elevator_entity"


function yaw(object)
	if object:is_player() then return object:get_look_horizontal()
	else	return object:getyaw()
	end
end

function elevator:is_player_inside(player)
	print(player:get_player_name().." enter an elevator as passenger n°"..#self.passengers.."")
	for i,passenger in pairs(self.passengers) do
		if player == passenger then return true end
	end
	return false
end

function elevator:set_direction(direction)
	print("elevator take direction "..direction.." to target "..self.target)
	self.direction = direction
	self.direction_change = true
	if self.sound_loop then minetest.sound_stop(self.sound_loop) end
	if direction==0 then 
		self.sound_loop = minetest.sound_play("elevator_close", {object=self.object, max_hear_distance = 10, loop=false})
		self.target = 0
	else
		if self.sound_loop then minetest.sound_stop(self.sound_loop) end
		self.sound_loop = minetest.sound_play("elevator_loop", {object=self.object, max_hear_distance = 10, loop=true})
	end
end

function elevator:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
	if self:is_player_inside(puncher) then -- punch an elevator to go up or down
		if self.direction == 0 then
			local look = puncher:get_look_vertical()
			local p = self.object:getpos()
			self:regenerate_marks() -- search for a mark, that can haven't been already searched
			if #self.marks == 0 then return	end
			if look < 0 then -- look up
				local i=1
				while i<#self.marks and self.marks[i]<=p.y do i = i+1 end
				if self.marks[i] <= p.y then return end
				self.target = self.marks[i]
				self:set_direction(1)
			else  -- look down
				local i=#self.marks
				while i>1 and self.marks[i]>=p.y do i = i-1 end
				if self.marks[i] >= p.y then return end
				self.target = self.marks[i]
				self:set_direction(-1)
			end
		else	self:set_direction(0)  -- uncomment it if elevators mustn't be stopped from the interior
		end
	elseif puncher:get_wielded_item():get_name() == "technology:wrench" then
		puncher:get_inventory():add_item("technology:elevator", 1)
		self.object:remove()
	end
end


function elevator:on_rightclick(clicker)
	if self:is_player_inside(clicker) then -- the passenger exits
		local y = yaw(clicker)
		local pos = self.object:getpos()
		local p = {
			x=pos.x + -(elevator_radius+0.5)*math.sin(y), 
			y=pos.y+0.5, 
			z=pos.z + -(elevator_radius+0.5)*-math.cos(y)
		}
		if	(not minetest.get_node({x=p.x, y=pos.y,   z=p.z}).walkable) and 
			(not minetest.get_node({x=p.x, y=pos.y+1, z=p.z}).walkable)	then
			
			clicker:setpos(p)
			clicker:set_detach(self.object)
			for i,passenger in pairs(self.passengers) do if passenger==clicker then break end end
			table.remove(self.passengers, i)
			minetest.after(0.2, function()
					clicker:setpos(p)
				end)
		else
			minetest.chat_send_player(clicker:get_player_name(), "area is too small to bail out")
		end
	else -- the player enter the elevator
		-- the program comes here if the clicker is not a passenger
		-- make it become one
		table.insert(self.passengers, clicker)
		clicker:set_attach(self.object, "", {x=0,y=0,z=10}, {x=0,y=0,z=-10})
	end
end

function elevator:on_step(dtime)	
	-- check up for direction change
	if self.direction_change then
		self.object:set_velocity({x=0,y=self.direction*elevator_speed,z=0})
		self.direction_change = false
	else
		-- wait for a stop
		local p = self.object:getpos()
		if self.direction > 0 and p.y+elevator_speed*dtime >= self.target then
			self.object:setpos({x=p.x, y=self.target, z=p.z})
			self.object:set_velocity({x=0, y=0, z=0})
			self:set_direction(0)
		elseif self.direction < 0 and p.y-elevator_speed*dtime <= self.target then
			self.object:setpos({x=p.x, y=self.target, z=p.z})
			self.object:set_velocity({x=0, y=0, z=0})
			self:set_direction(0)
		end
	end
	
	if self.object:get_hp() <= 5 then
		self.object:remove()
		return
	end
end


local r = elevator_radius+0.7
local elevator_marks_slots = { {r,-0.5},{r,0.5},  {-0.5,r},{0.5,r},  {-r,-0.5},{-r,0.5},  {-0.5,-r},{0.5,-r} }
local elevator_mark_height = 1.5

function elevator:regenerate_marks()
	local y = self.object:getyaw()
	local p = self.object:getpos()
	self.marks = {}
	rail_x = p.x + (elevator_radius+0.5) * math.cos(y)	-- rail on the side
	rail_z = p.z + (elevator_radius+0.5) * math.sin(y)
	rail_y = p.y+elevator_mark_height+1
	print("regen marks")
	print("start from "..rail_x..", "..rail_y..", "..rail_z)
	print("here we got "..minetest.get_node({x=rail_x, y=rail_y, z=rail_z}).name)
	while minetest.get_node({x=rail_x, y=rail_y, z=rail_z}).name == elevator_rail do
		print("look at "..rail_y)
		for i,place in pairs(elevator_marks_slots) do
			if minetest.get_node({x=p.x + place[1], y=rail_y, z=p.z + place[2]}).name == elevator_mark then
				table.insert(self.marks, math.floor(rail_y - elevator_mark_height) + 0.5)
				print("insert mark at "..rail_y-elevator_mark_height)
				break
			end
		end
		rail_y = rail_y+1
	end
	rail_y = p.y+elevator_mark_height-1
	while minetest.get_node({x=rail_x, y=rail_y, z=rail_z}).name == elevator_rail do
		print("look at "..rail_y)
		for i,place in pairs(elevator_marks_slots) do
			if minetest.get_node({x=p.x + place[1], y=rail_y, z=p.z + place[2]}).name == elevator_mark then
				table.insert(self.marks, 1, math.floor(rail_y - elevator_mark_height) + 0.5)
				print("insert mark at "..rail_y-elevator_mark_height)
				break
			end
		end
		rail_y = rail_y-1
	end
end

minetest.register_entity(elevator_entity, elevator)

minetest.register_craftitem("technology:elevator", {
	description = "Elevator",
	inventory_image="technology_elevator_item.png",
	wield_image = "technology_elevator_item.png",
	wield_scale = {x=6, y=6, z=2},
	
	on_place = function(itemstack, placer, pointed_thing)
		local p = pointed_thing.under
		local y = yaw(placer)
		-- select direction to place to
		print(y)
		local o = 0
		if 		7*math.pi/4 < y or y <= math.pi/4 then o = 0
		elseif  math.pi/4 < y and y <= 3*math.pi/4 then o = math.pi/2
		elseif  3*math.pi/4 < y and y <= 5*math.pi/4 then o = math.pi
		else	o = 3*math.pi/2
		end
		p.y = p.y + 0.5
		p.x = p.x + 1.5*math.sin(o) + 0.5*math.cos(o)
		p.z = p.z - 1.5*math.cos(o) + 0.5*math.sin(o)
		local obj = minetest.add_entity(p, elevator_entity)
		obj:setyaw(o)
		
		if not minetest.setting_getbool("creative_mode") then
			itemstack:take_item()
		end
		return itemstack
	end,
})



local ec = 0.05	-- size of electric cables
local sc = 0.1	-- size of support cables
local zmin = -0.5
local zmax = 0.5
minetest.register_node("technology:elevator_rail", {
    description = "Vertical rail for elevator",
    node_placement_prediction = "",
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = {type = "fixed", fixed = {
    	{	-0.05,	zmin,	0.2,  	0.05,	zmax,	0.5	},	-- guidance rail
		{	-0.1,	zmin,	0.45,  	0.1,	zmax,	0.5	},	-- guidance rail part 2
		{	0.4,	zmin,	-0.1,  	0.4+sc,	zmax,	-0.1+sc	},	-- support cable
		{	-0.3,	zmin,	0.4,  	-0.3+ec,	zmax,	0.4+ec	},	-- electric cable
		{	-0.4,	zmin,	0.4,  	-0.4+ec,	zmax,	0.4+ec	},	-- electric cable
    }},
    selection_box = {type = "fixed", fixed = {
    	{-0.5, zmin, 0.2,    0.5, zmax, 0.5},
    }},
    tiles = {
		"technology_elevator_rail_front.png",	--top
		"technology_elevator_rail_front.png",	--bottom
		"technology_elevator_rail_right.png",	--right
		"technology_elevator_rail_left.png",	--left
		"technology_elevator_rail_back.png",	--back
		"technology_elevator_rail_front.png" --front
	},
    walkable = true,
    groups = {mechanic=1, oddly_breakable_by_hand=1},
    on_punch = metal_punch,
    sounds = metal_footstep,
})

technology.register_plan("ELEVATOR", "technology:elevator", nil, {
	"technic:hv_transformer 1",
	"technic:motor 1",
	"technology:wire 2",
	"default:bronze_ingot 6",
})

technology.register_plan("ELEVATOR_RAIL", "technology:elevator_rail", nil, {
	"technology:wire 1",
	"default:steel_ingot 1",
})
