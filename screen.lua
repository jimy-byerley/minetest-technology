
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
    stack_max = 1,
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
    	node.name = "technology:flat_screen_smalltext"
    	minetest.env:set_node(pos, node)
    end,
	drop = 'technology:flat_screen_off',
})

minetest.register_node("technology:flat_screen_smalltext", {
    description = "modern screen",
    stack_max = 1,
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
    		"screen_flat_right.png", "screen_flat_back.png", "screen_flat_front_smalltext.png"},
    walkable = true,
    groups = {choppy=2, dig_immediate=2},
    on_punch = function(pos, node, puncher)
    	node.name = "technology:flat_screen_off"
    	minetest.env:set_node(pos, node)
    end,
	drop = 'technology:flat_screen_off',
})

minetest.register_node("technology:flat_screen_bigtext", {
    description = "modern screen",
    stack_max = 1,
    node_placement_prediction = "",
    paramtype = "light",
	light_source = 5,
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
    		"screen_flat_right.png", "screen_flat_back.png", "screen_flat_front_bigtext.png"},
    walkable = true,
    groups = {choppy=2, dig_immediate=2},
    on_punch = function(pos, node, puncher)
    	node.name = "technology:flat_screen_off"
    	minetest.env:set_node(pos, node)
    end,
	drop = 'technology:flat_screen_off',
})

minetest.register_node("technology:flat_screen_2columns", {
    description = "modern screen",
    stack_max = 1,
    node_placement_prediction = "",
    paramtype = "light",
	light_source = 4,
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
    		"screen_flat_right.png", "screen_flat_back.png", "screen_flat_front_2columns.png"},
    walkable = true,
    groups = {choppy=2, dig_immediate=2},
    on_punch = function(pos, node, puncher)
    	node.name = "technology:flat_screen_off"
    	minetest.env:set_node(pos, node)
    end,
	drop = 'technology:flat_screen_off',
})

minetest.register_node("technology:flat_screen_map", {
    description = "modern screen",
    stack_max = 1,
    node_placement_prediction = "",
    paramtype = "light",
	light_source = 6,
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
    		"screen_flat_right.png", "screen_flat_back.png", "screen_flat_front_map.png"},
    walkable = true,
    groups = {choppy=2, dig_immediate=2},
    on_punch = function(pos, node, puncher)
    	node.name = "technology:flat_screen_off"
    	minetest.env:set_node(pos, node)
    end,
	drop = 'technology:flat_screen_off',
})

minetest.register_node("technology:flat_screen_screensaver", {
    description = "modern screen",
    stack_max = 1,
    node_placement_prediction = "",
    paramtype = "light",
	light_source = 4,
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
    		"screen_flat_right.png", "screen_flat_back.png", "screen_flat_front_cybertronic.png"},
    walkable = true,
    groups = {choppy=2, dig_immediate=2},
    on_punch = function(pos, node, puncher)
    	node.name = "technology:flat_screen_off"
    	minetest.env:set_node(pos, node)
    end,
	drop = 'technology:flat_screen_off',
})

local screens = {"technology:flat_screen_smalltext", 
		"technology:flat_screen_bigtext", "technology:flat_screen_2columns", "technology:flat_screen_map",
		"technology:flat_screen_screensaver"}

minetest.register_abm({
	nodenames = screens,
	interval = 1,
	chance = 2,
	action = function(pos, node, _, _)
		if math.random(1,2) == 1 then return end
		local newname = screens[math.random(1,5)]
		local node = minetest.env:get_node(pos)
		node.name = newname
		minetest.env:set_node(pos, node)
	end,
})

minetest.register_alias("technology:flat_screen", "technology:flat_screen_off")

