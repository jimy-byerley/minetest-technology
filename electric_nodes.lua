
-- crafting

minetest.register_craft({
	output = 'technology:wire 10',
	recipe = {
		{'technology:plastic', 'moreores:copper_ingot'},
	}
})

minetest.register_craft({
	output = 'mesecons_extrawires:vertical_off',
	recipe = {{'mesecons:mesecon'}}
})

minetest.register_craft({
	output = 'mesecons:mesecon',
	recipe = {{'mesecons_extrawires:vertical_off'}}
})

minetest.register_craft({
	output = 'technology:resistor 2',
	recipe = {
		{'mesecons:mesecon', 'moreores:copper_lump', 'mesecons:mesecon'},
	}
})

minetest.register_craft({
	output = 'technology:12V_battery',
	recipe = {
		{'technology:plastic', 'technology:plastic', 'technology:plastic'},
		{'moreores:copper_ingot', '', 'moreores:copper_ingot'},
		{'technology:plastic', 'technology:plastic', 'technology:plastic'},
	}
})

minetest.register_craft({
	output = 'technology:electronic_card',
	recipe = {
		{'default:steel_ingot'},
		{'technology:plastic'},
	}
})

minetest.register_craft({
	output = 'technology:button 4',
	recipe = {
		{'technology:plastic'},
		{'default:steel_ingot'},
		{'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'technology:switch_off 2',
	recipe = {
		{'', 'moreores:copper_ingot', ''},
		{'', '', ''},
		{'mesecons:mesecon', '', 'mesecons:mesecon'},
	}
})

minetest.register_craft({
	output = 'technology:lamp_small 5',
	recipe = {
		{'glass:bottle_empty'},
		{'default:steel_ingot'},
		{'moreores:copper_ingot'},
	}
})

minetest.register_craft({
	output = 'technology:lamp_box 2',
	recipe = {
		{'default:glass', 'default:glass'},
		{'default:steel_ingot', 'default:steel_ingot'},
		{'moreores:copper_ingot', 'moreores:copper_ingot'},
	}
})

minetest.register_craft({
	output = 'technology:battery',
	recipe = {
		{'technology:plastic', 'technology:plastic', 'technology:plastic'},
		{'default:steel_ingot', 'moreores:copper_ingot', 'moreores:copper_ingot'},
		{'technology:plastic', 'technology:plastic', 'technology:plastic'},
	}
})

-- nodes defs

minetest.register_alias("technology:wire", "mesecons:mesecon")

minetest.register_node("technology:resistor", {
    description = "Electric resistor",
    inventory_image = "resistor_item.png",
    wield_image = "resistor_item.png",
    paramtype = "light",
    node_placement_prediction = "",
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = {type = "fixed", fixed = {
    	{0.05, -0.45, -1.1,    0.1, -0.4, 1.1},
    	{-0.1, -0.45, -1.1,    -0.05, -0.4, 1.1},
    	{0.025, -0.5, -0.2,    0.125, -0.35, 0.2},
    	{-0.125, -0.5, -0.2,    -0.025, -0.35, 0.2},
    }},
    selection_box = {type = "fixed", fixed = {
    	{-0.125, -0.5, -0.2,   0.125, -0.35, 0.2},
    }},
    tiles = {"wire_top.png", "wire_top.png", "wire_side.png", "wire_side.png", "wire_side.png", "wire_side.png"},
    --tiles = {"resistor_top.png", "resistor_top.png", "resistor_side.png", "resistor_side.png", "resistor_side.png", "resistor_side.png"},
    walkable = false,
    groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,pinch=1,conductor=1},
    electric = {conduction = 0.6},
})


minetest.register_node("technology:12V_battery", {
    description = "Electric Battery 12V",
    inventory_image = "battery_top.png",
    wield_image = "battery_top.png",
    stack_max = 20,
    paramtype = "light",
    node_placement_prediction = "",
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = {type = "fixed", fixed = {
    	{0.05, -0.45, -1.1,    0.1, -0.4, 0},
    	{-0.1, -0.45, -1.1,    -0.05, -0.4, 0},
    	{-0.4, -0.5, -0.5,     0.4, -0.1, 0.05},
    }},
    selection_box = {type = "fixed", fixed = {
    	{0.05, -0.45, -1.1,    0.1, -0.4, 0},
    	{-0.1, -0.45, -1.1,    -0.05, -0.4, 0},
    	{-0.4, -0.5, -0.5,     0.4, -0.1, 0.05},
    }},
    tiles = {"battery_top.png", "battery_top.png", "battery_side.png", "battery_side.png", "battery_side.png", "battery_back.png"},
    walkable = true,
    groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,pinch=1,generator=1},
    electric = {generated = 12.5},
    on_construct = function(pos)
    	local meta = minetest.env:get_meta(pos)
    	meta:set_string("infotext", "\"12.5V DC BATTERY\"")
    end,
})

minetest.register_node("technology:lamp_small", {
	description = "Electric lamp small",
	drawtype = "torchlike",
	tiles = {"lamp_small_floor.png", "lamp_small_ceiling.png", "lamp_small.png"},
	inventory_image = "lamp_small_only.png",
	wield_image = "lamp_small_only.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	--light_source = LIGHT_MAX-1,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	legacy_wallmounted = true,
	groups = {choppy=2,dig_immediate=3,flammable=1,attached_node=1,electric=1},
	electric = {
		action = function(pos, energy)
			if energy < 10 then
				return
			elseif energy > 80 then
				minetest.env:set_node(pos, {name="fire:basic_flame"})
			else
				local node = minetest.env:get_node(pos)
				node.name = "technology:lamp_small_on"
				minetest.env:set_node(pos, node)
			end
		end,
	}
})

minetest.register_node("technology:lamp_small_on", {
	description = "Electric lamp small",
	drawtype = "torchlike",
	tiles = {"lamp_small_on_floor.png", "lamp_small_on_ceiling.png", "lamp_small_on.png"},
	inventory_image = "lamp_small_only.png",
	wield_image = "lamp_small_only.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 10,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	legacy_wallmounted = true,
	drop = "technology:lamp_small",
	groups = {choppy=2,dig_immediate=3,flammable=1,attached_node=1,electric=1},
	electric = {
		action = function(pos, energy)
			if energy < 10 then
				local node = minetest.env:get_node(pos)
				node.name = "technology:lamp_small"
				minetest.env:set_node(pos, node)
			elseif energy > 80 then
				minetest.env:set_node(pos, {name="fire:basic_flame"})
			end
		end,
	}
})

minetest.register_alias("technology:lamp_box", "mesecons_lamp:mesecon_lamp_off")

minetest.register_alias("technology:lamp_box_on", "mesecons_lamp:mesecon_lamp_on")

minetest.register_craftitem("technology:button", {
	description = "electric button",
	inventory_image = "button_item.png",
})

minetest.register_alias("technology:switch_off", "mesecons_walllever:wall_lever_off")

minetest.register_alias("technology:switch_on", "mesecons_walllever:wall_lever_on")

minetest.register_craftitem("technology:electronic_card", {
	description = "electronic card with micro-processor",
	inventory_image = "electronic_card_item.png",
})

