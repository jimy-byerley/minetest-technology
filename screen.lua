
local screens = {
	"technology:flat_screen_on",
	"technology:flat_screen_text",
	"technology:flat_screen_compiling",
}

-- crafting

minetest.register_craft({
	output = "technology:flat_screen_off",
	recipe = {
		{"technology:plastic", "", ""},
		{"technology:plastic", "technology:electronic_card", "default:glass"},
		{"technology:plastic", "", ""},
	}
})

--node defs

minetest.register_node("technology:flat_screen_off", {
    description = "modern screen",
    node_placement_prediction = "",
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = {type = "fixed", fixed = {
    	{-0.45, -0.4, 0.3,   0.45, 0.3, 0.25},
    	{-0.35, -0.35, 0.3,   0.35, 0.25, 0.4},
    }},
    selection_box = {type = "fixed", fixed = {
    	{-0.45, -0.4, 0.3,   0.45, 0.3, 0.25},
    	{-0.35, -0.35, 0.3,   0.35, 0.25, 0.4},
    }},
    tiles = {"screen_flat_top.png", "screen_flat_bottom.png", "screen_flat_left.png", 
    		"screen_flat_right.png", "screen_flat_back.png", "screen_flat_front_off.png"},
    walkable = true,
    groups = {choppy=2, dig_immediate=2},
    on_punch = function(pos, node, puncher)
    	local node = minetest.env:get_node(pos)
    	--node.name = "technology:flat_screen_on"
		node.name = screens[math.random(1,#screens)]
    	minetest.set_node(pos, node)
    end,
	drop = 'technology:flat_screen_off',
})

minetest.register_node("technology:flat_screen_on", {
    description = "modern screen",
    node_placement_prediction = "",
    paramtype = "light",
	light_source = 3,
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = {type = "fixed", fixed = {
    	{-0.45, -0.4, 0.3,   0.45, 0.3, 0.25},
    	{-0.35, -0.35, 0.3,   0.35, 0.25, 0.4},
    }},
    selection_box = {type = "fixed", fixed = {
    	{-0.45, -0.4, 0.3,   0.45, 0.3, 0.25},
    	{-0.35, -0.35, 0.3,   0.35, 0.25, 0.4},
    }},
    tiles = {"screen_flat_top.png", "screen_flat_bottom.png", "screen_flat_left.png", 
		"screen_flat_right.png", "screen_flat_back.png", {
			image="screen_flat_animated_cursor_blink.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=128, aspect_h=128, length=4.6}
		}},
    walkable = true,
    groups = {choppy=2, dig_immediate=2},
    on_punch = function(pos, node, puncher)
    	node.name = "technology:flat_screen_off"
    	minetest.set_node(pos, node)
    end,
	drop = 'technology:flat_screen_off',
})

minetest.register_node("technology:flat_screen_text", {
	description = "modern screen",
	node_placement_prediction = "",
	paramtype = "light",
	light_source = 3,
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {type = "fixed", fixed = {
		{-0.45, -0.4, 0.3,   0.45, 0.3, 0.25},
		{-0.35, -0.35, 0.3,   0.35, 0.25, 0.4},
	}},
	selection_box = {type = "fixed", fixed = {
		{-0.45, -0.4, 0.3,   0.45, 0.3, 0.25},
		{-0.35, -0.35, 0.3,   0.35, 0.25, 0.4},
	}},
	tiles = {"screen_flat_top.png", "screen_flat_bottom.png", "screen_flat_left.png",
		"screen_flat_right.png", "screen_flat_back.png", {
			image="screen_flat_animated_text.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=128, aspect_h=128, length=4.6}
	}},
	walkable = true,
	groups = {choppy=2, dig_immediate=2},
	on_punch = function(pos, node, puncher)
		node.name = "technology:flat_screen_off"
		minetest.set_node(pos, node)
	end,
	drop = 'technology:flat_screen_off',
})

minetest.register_node("technology:flat_screen_compiling", {
	description = "modern screen",
	node_placement_prediction = "",
	paramtype = "light",
	light_source = 3,
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {type = "fixed", fixed = {
		{-0.45, -0.4, 0.3,   0.45, 0.3, 0.25},
		{-0.35, -0.35, 0.3,   0.35, 0.25, 0.4},
	}},
	selection_box = {type = "fixed", fixed = {
		{-0.45, -0.4, 0.3,   0.45, 0.3, 0.25},
		{-0.35, -0.35, 0.3,   0.35, 0.25, 0.4},
	}},
	tiles = {"screen_flat_top.png", "screen_flat_bottom.png", "screen_flat_left.png",
		"screen_flat_right.png", "screen_flat_back.png", {
			image="screen_flat_animated_compiling.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=128, aspect_h=128, length=4.6}
	}},
	walkable = true,
	groups = {choppy=2, dig_immediate=2},
	on_punch = function(pos, node, puncher)
		node.name = "technology:flat_screen_off"
		minetest.set_node(pos, node)
	end,
	drop = 'technology:flat_screen_off',
})


local old_screens = {"technology:flat_screen_smalltext", 
		"technology:flat_screen_bigtext", "technology:flat_screen_2columns", "technology:flat_screen_map",
		"technology:flat_screen_screensaver"}


minetest.register_abm({
	nodenames = old_screens,
	interval = 1,
	chance = 2,
	action = function(pos, node, _, _)
		if math.random(1,2) == 1 then return end
		local new_name = screens[math.random(1,#screens)]
		node.name = new_name
		minetest.add_node(pos, node)
	end,
})
--[[
minetest.register_abm({
	nodenames = screens,
	interval = 2,
	chance = 2,
	action = function(pos, node, _, _)
		if math.random(1,2) == 1 then return end
		local new_name = screens[math.random(1,#screens)]
		node.name = new_name
		minetest.set_node(pos, node)
	end,
})
]]

minetest.register_alias("technology:flat_screen", "technology:flat_screen_off")

