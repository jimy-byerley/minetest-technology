--[[
 including : concrete, steel armature, grid, bridge, support, flat
]]

local bronze_ingot = "default:bronze_ingot"
if minetest.registered_nodes[bronze_ingot] == nil then
	bronze_ingot = "moreores:bronze_ingot"
end

minetest.register_craft({
	output = 'technology:concrete',
	type = "shapeless",
	recipe = {"group:sand", "default:gravel", "bucket:bucket_water"},
	replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}}
})

minetest.register_craft({
	output = 'technology:armature_h 5',
	recipe = {
		{bronze_ingot, bronze_ingot, bronze_ingot},
		{'', bronze_ingot, ''},
		{bronze_ingot, bronze_ingot, bronze_ingot},
	}
})

minetest.register_craft({
	output = 'technology:armature_v',
	recipe = {
		{'technology:armature_h'},
	}
})

minetest.register_craft({
	output = 'technology:armature_h',
	recipe = {
		{'technology:armature_v'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = 'moreores:bronze_ingot 7',
	recipe = 'technology:armature_v',
})

minetest.register_craft({
	type = "cooking",
	output = 'moreores:bronze_ingot 7',
	recipe = 'technology:armature_h',
})


minetest.register_node("technology:concrete", {
	description = "Concrete block",
	tiles = {"structures_concrete.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=2},
	sounds = default.node_sound_stone_defaults(),
})

local metal_punch = function(pos, puncher)
	local table = {
		name = "metal_footstep",
		gain = 1.0,
		max_hear_distance = 200,
		loop = false,
		pos = pos
	}
	minetest.sound_play(table.name, table)
end

local metal_footstep = {
	footstep = {name="metal_footstep", gain=0.8},
	dug = {name="", gain = 0.8},
}

minetest.register_node("technology:armature_h", {
    description = "Steel armature horizontal",
    inventory_image = "steel_armature_h_side.png",
    wield_image = "steel_armature_h_side.png",
    stack_max = 20,
    node_placement_prediction = "",
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = {type = "fixed", fixed = {
    	{-0.5, -0.5, -0.5,    0.5, -0.4, 0.5},
    	{-0.5, 0.4,  -0.5,    0.5, 0.5,  0.5},
    	{-0.5, -0.4, -0.2,    0.5, 0.4,  0.2},
    }},
    selection_box = {type = "fixed", fixed = {
    	{-0.5, -0.5, -0.5,    0.5, 0.5, 0.5},
    }},
    tiles = {"steel_armature_top.png", "steel_armature_top.png", "steel_armature_top.png", "steel_armature_top.png", "steel_armature_h_side.png", "steel_armature_h_side.png"},
    walkable = true,
    groups = {mechanic=1, oddly_breakable_by_hand=1},
    on_punch = metal_punch,
    sounds = metal_footstep,
})

minetest.register_node("technology:armature_v", {
    description = "Steel armature vertical",
    inventory_image = "steel_armature_v_side.png",
    wield_image = "steel_armature_v_side.png",
    stack_max = 20,
    node_placement_prediction = "",
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = {type = "fixed", fixed = {
    	{-0.5, -0.5, -0.5,    -0.4, 0.5, 0.5},
    	{0.4,  -0.5, -0.5,    0.5,  0.5, 0.5},
    	{-0.4, -0.5, -0.2,    0.4,  0.5, 0.2},
    }},
    selection_box = {type = "fixed", fixed = {
    	{-0.5, -0.5, -0.5,    0.5, 0.5, 0.5},
    }},
    tiles = {"steel_armature_top.png", "steel_armature_top.png", "steel_armature_top.png", "steel_armature_top.png", "steel_armature_v_side.png", "steel_armature_v_side.png"},
    walkable = true,
    groups = {mechanic=1, oddly_breakable_by_hand=1},
    on_punch = metal_punch,
    sounds = metal_footstep,
})

minetest.register_node("technology:grid_v", {
    description = "Bronze grid vertical",
    inventory_image = "bronze_grid_front.png",
    wield_image = "bronze_grid_front.png",
    stack_max = 20,
    node_placement_prediction = "",
    paramtype = "light",
	light_source = 3,
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = {type = "fixed", fixed = {
    	{-0.5, -0.5, 0.3,    0.5, 0.5, 0.4}
    }},
    selection_box = {type = "fixed", fixed = {
    	{-0.5, -0.5, 0.3,    0.5, 0.5, 0.4}
    }},
    tiles = {"bronze_grid_side.png", "bronze_grid_side.png", "bronze_grid_side.png", "bronze_grid_side.png", "bronze_grid_front.png", "steel_grid_front.png"},
    walkable = true,
    groups = {mechanic=1, oddly_breakable_by_hand=1},
    on_punch = metal_punch,
    sounds = metal_footstep,
})

minetest.register_node("technology:grid_h", {
    description = "Bronze grid horizontal",
    inventory_image = "bronze_grid_front.png",
    wield_image = "bronze_grid_front.png",
    stack_max = 20,
    node_placement_prediction = "",
    paramtype = "light",
	light_source = 3,
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = {type = "fixed", fixed = {
    	{-0.5, 0.4, -0.5,    0.5, 0.5, 0.5}
    }},
    selection_box = {type = "fixed", fixed = {
    	{-0.5, 0.4, -0.5,    0.5, 0.5, 0.5}
    }},
    tiles = {"bronze_grid_side.png", "bronze_grid_front.png", "bronze_grid_side.png", "bronze_grid_front.png", "bronze_grid_side.png", "steel_grid_side.png"},
    walkable = true,
    groups = {mechanic=1, oddly_breakable_by_hand=1},
    on_punch = metal_punch,
    sounds = metal_footstep,
})

minetest.register_craft({
	output = 'technology:grid_v 10',
	recipe = {
		{'', bronze_ingot, ''},
		{bronze_ingot, bronze_ingot, bronze_ingot},
		{'', bronze_ingot, ''},
	}
})

minetest.register_craft({
	output = 'technology:grid_v',
	recipe = {{'technology:grid_h'}},
})

minetest.register_craft({
	output = 'gird:grid_h',
	recipe = {{'technology:grid_v'}},
})

minetest.register_craft({
	output = 'technology:floor 2',
	recipe = {
		{bronze_ingot, bronze_ingot},
	}
})

minetest.register_craft({
	output = 'technology:edge 10',
	recipe = {
		{bronze_ingot, bronze_ingot},
		{bronze_ingot, bronze_ingot},
	}
})

minetest.register_craft({
	output = 'technology:edge',
	recipe = {
		{'technology:edge_angle'},
	}
})

minetest.register_craft({
	output = 'technology:edge_angle',
	recipe = {
		{'technology:edge'},
	}
})

minetest.register_craft({
	output = 'technology:triangle 4',
	recipe = {
		{bronze_ingot, bronze_ingot},
		{'', bronze_ingot},
	}
})

minetest.register_node("technology:floor", {
    description = "Bridge floor",
    inventory_image = "floor_top.png",
    wield_image = "floor_top.png",
    stack_max = 20,
    node_placement_prediction = "",
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = {type = "fixed", fixed = {
			{-0.5, 0.4, -0.5,    0.5, 0.42, 0.5},
			{-0.3, 0.3, -0.5,    -0.2, 0.4, 0.5},
			{0.2, 0.3, -0.5,     0.3, 0.4, 0.5},
    }},
    selection_box = {type = "fixed", fixed = {
			{-0.5, 0, -0.5,    0.5, 0.5, 0.5},
    }},
    tiles = {"floor_top.png", "floor_bottom.png", "floor_side.png", "floor_side.png", "floor_side.png", "floor_side.png"},
    walkable = true,
    groups = {paffly=2, mechanic=1, oddly_breakable_by_hand=1},
    on_punch = metal_punch,
    sounds = metal_footstep,
})

minetest.register_craft({
	output = 'technology:stairs 4',
	recipe = {
		{'', '', bronze_ingot},
		{'', bronze_ingot, ''},
		{bronze_ingot, '', ''},
	}
})


minetest.register_node("technology:stairs", {
    description = "Bridge stairs",
    stack_max = 20,
    node_placement_prediction = "",
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = {type = "fixed", fixed = {
			{-0.5, -0.5, -0.5,    0.5,  -0.38, 0},
			{-0.5,  -0.1,    0,      0.5, 0.02, 0.5},
    }},
    selection_box = {type = "fixed", fixed = {
			{-0.5, 0, -0.5,    0.5, 0.5, 0.5},
    }},
    tiles = {"floor_top.png", "floor_bottom.png", "floor_side.png", "floor_side.png", "floor_side.png", "floor_side.png"},
    walkable = true,
    groups = {paffly=2, mechanic=1, oddly_breakable_by_hand=1},
    on_punch = metal_punch,
    sounds = metal_footstep,
})

minetest.register_node("technology:edge", {
    description = "Bridge edge",
    stack_max = 20,
    node_placement_prediction = "",
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = {type = "fixed", fixed = {
			{-0.5, 0.2, -0.5,    0.5, 0.3, -0.4},
			{-0.3, -0.6, -0.5,   -0.2, 0.2, -0.4},
			{0.2, -0.6, -0.5,    0.3, 0.2, -0.4},
    }},
    selection_box = {type = "fixed", fixed = {
			{-0.5, -0.5, -0.5,    0.5, 0.5, -0.3},
    }},
    tiles = {"edge_side.png", "edge_side.png", "edge_side.png", "edge_side.png", "edge_side.png", "edge_side.png"},
    walkable = true,
    groups = {paffly=2, mechanic=1, oddly_breakable_by_hand=1},
    on_punch = metal_punch,
    sounds = metal_footstep,
})

minetest.register_node("technology:edge_angle", {
    description = "Bridge edge",
    stack_max = 20,
    node_placement_prediction = "",
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = {type = "fixed", fixed = {
		{-0.5, 0.2, -0.5,    0.5, 0.3, -0.4},
		{-0.3, -0.6, -0.5,   -0.2, 0.2, -0.4},
		{0.2, -0.6, -0.5,    0.3, 0.2, -0.4},
		
		{-0.5, 0.2, -0.5,    -0.4, 0.3, 0.5},
		{-0.5, -0.6, -0.3,   -0.4, 0.2, -0.2},
		{-0.5, -0.6, 0.2,    -0.4, 0.2, 0.3},
    }},
    selection_box = {type = "fixed", fixed = {
			{-0.5, -0.5, -0.5,    0.5, 0.5, -0.3},
    }},
    tiles = {"edge_side.png", "edge_side.png", "edge_side.png", "edge_side.png", "edge_side.png", "edge_side.png"},
    walkable = true,
    groups = {paffly=2, mechanic=1, oddly_breakable_by_hand=1},
    on_punch = metal_punch,
    sounds = metal_footstep,
    drop = "technology:edge",
})

minetest.register_node("technology:triangle", {
    description = "Bridge triangle",
    inventory_image = "triangle_right.png",
    wield_image = "triangle_right.png",
    node_placement_prediction = "",
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = {type = "fixed", fixed = {
		{-0.01, 0.5, -0.5,    0.01, 1.5, 0.5},
    }},
    selection_box = {type = "fixed", fixed = {
		{-0.01, 0.5, -0.5,    0.01, 1.5, 0.5},
    }},
    tiles = {"triangle_side.png", "triangle_side.png", "triangle_right.png", "triangle_left.png", "triangle_side.png", "triangle_side.png"},
    walkable = true,
    groups = {paffly=2, mechanic=1, oddly_breakable_by_hand=1},
    on_punch = metal_punch,
    sounds = metal_footstep,
})


minetest.register_craft({
	output = 'technology:ladder 16',
	recipe = {
		{bronze_ingot,           '', bronze_ingot},
		{bronze_ingot, bronze_ingot, bronze_ingot},
		{bronze_ingot,           '', bronze_ingot},
	}
})

minetest.register_node("technology:ladder", {
  description = "bronze ladder",
  node_placement_prediction = "",
  paramtype = "light",
  paramtype2 = "facedir",
  drawtype = "nodebox",
  node_box = {type = "fixed", fixed = {
		{-0.3, -0.5, 0.4,    -0.2, 0.5,  0.5},
		{ 0.3, -0.5, 0.4,     0.2, 0.5,  0.5},
		
		{ -0.2, -0.36, 0.42,   0.2, -0.3,  0.48},
		{ -0.2,  0.36, 0.42,   0.2,  0.3,  0.48},
		{ -0.2, -0.03, 0.42,   0.2,  0.03, 0.48},
  }},
  selection_box = {type = "fixed", fixed = {
		{-0.3, -0.5, 0.4,     0.3, 0.5, 0.5},
  }},
  tiles = {"technology_ladder.png", "technology_ladder.png", "technology_ladder.png", "technology_ladder.png", "technology_ladder.png", "technology_ladder.png"},
  walkable = true,
	climbable = true,
  groups = {paffly=2, mechanic=1, oddly_breakable_by_hand=1},
  on_punch = metal_punch,
  sounds = metal_footstep,
})


minetest.register_craft({
	output = 'technology:ladder_closed',
	recipe = {
		{'technology:ladder'},
		{bronze_ingot},
	}
})

minetest.register_node("technology:ladder_closed", {
  description = "bronze ladder closed",
  node_placement_prediction = "",
  paramtype = "light",
  paramtype2 = "facedir",
  drawtype = "nodebox",
  node_box = {type = "fixed", fixed = {
  	-- barre verticales latérales
		{-0.3, -0.5, 0.4,    -0.2, 0.5,  0.5},
		{ 0.3, -0.5, 0.4,     0.2, 0.5,  0.5},
		-- barres horizontales
		{ -0.2, -0.36, 0.42,   0.2, -0.3,  0.48},
		{ -0.2,  0.36, 0.42,   0.2,  0.3,  0.48},
		{ -0.2, -0.03, 0.42,   0.2,  0.03, 0.48},
		-- garde-corps lateraux
		{-0.45, -0.5, -0.35,    -0.4,  -0.4,  0.5},
		{ 0.4,  -0.5, -0.35,     0.45, -0.4,  0.5},
		{-0.4,  -0.5, -0.3,      0.4,  -0.4, -0.35},
		-- tige entre garde corps
		{-0.05, -0.5, -0.35,     0.05,  0.5, -0.3},
		{-0.45, -0.5, -0.1,     -0.4,   0.5, -0.15},
		{ 0.45, -0.5, -0.1,      0.4,   0.5, -0.15},
  }},
  selection_box = {type = "fixed", fixed = {
		{-0.5, -0.5, -0.5,     0.5, 0.5, 0.5},
  }},
  tiles = {"technology_ladder.png", "technology_ladder.png", "technology_ladder.png", "technology_ladder.png", "technology_ladder.png", "technology_ladder.png"},
  walkable = true,
	climbable = true,
  groups = {paffly=2, mechanic=1, oddly_breakable_by_hand=1},
  on_punch = metal_punch,
  sounds = metal_footstep,
})

