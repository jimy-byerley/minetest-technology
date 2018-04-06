
minetest.register_craft({
	output = 'technology:wrench',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'', 'default:steel_ingot', ''},
		{'', 'default:steel_ingot', ''},
	}
})

minetest.register_tool("technology:wrench", {
	description = "Wrench",
	inventory_image = "steel_wrench.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			mechanic={times={[1]=1.00, [2]=2.60, [3]=4.00}, uses=0, maxlevel=3},
		}
	},
})

minetest.register_craft({
	output = 'technology:jackhammer',
	recipe = {
		{'', '', 'technology:plastic'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'', '', 'technology:plastic'},
	}
})
--[[
minetest.register_tool("technology:jackhammer", {
	description = "Jackhammer",
	inventory_image = "jackhammer.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			cracky={times={[1]=4.00, [2]=1.60, [3]=1.00}, uses=160, maxlevel=2}
		}
	},
})
]]
minetest.register_node("technology:jackhammer", {
    description = "Jackhammer",
    inventory_image = "jackhammer.png",
    wield_image = "jackhammer.png",
    stack_max = 1,
    node_placement_prediction = "",
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "nodebox",
    node_box = {type = "fixed", fixed = {
		{-0.2, -0.0, -0.2,    0.2, 0.5, 0.2},
		{-0.08, -0.7, -0.05,    0.08, -0.0, 0.05},
    }},
    selection_box = {type = "fixed", fixed = {
		{-0.2, -0.0, -0.2,    0.2, 0.5, 0.2},
		{-0.08, -0.7, -0.05,    0.08, -0.0, 0.05},
    }},
    tiles = {"jackhammer_top.png", "jackhammer_bottom.png", "jackhammer_side.png", "jackhammer_side.png", "jackhammer_side.png", "jackhammer_side.png"},
    walkable = true,
    groups = {dig_immediate=3},
    on_use = function(item, player, pointed_thing)
    	if pointed_thing.under and minetest.env:find_node_near(pointed_thing.under, 1, {"group:cracky"}) then
    		local node = minetest.env:get_node(pointed_thing.under)
    		minetest.env:dig_node(pointed_thing.under)
    		local inventory = player:get_inventory()
    		local nodename = minetest.registered_nodes[node.name].drop or node.name
    		inventory:add_item("main", nodename)
    	end
		local toplay = {
			gain = 2.0,
			pos = pointed_thing.above,
			max_hear_distance = 50,
			loop = false,
		}
		minetest.sound_play("jackhammer_sound", toplay)
    end,
})

