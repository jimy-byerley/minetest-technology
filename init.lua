
technology ={}

-- crafting

minetest.register_craft({
	type = "cooking",
	output = "technology:plastic",
	recipe = "farming:string",
})

--node defs

minetest.register_craftitem("technology:plastic", {
	description = "plastic",
	inventory_image = "plastic_item.png",
})

local technology_path = minetest.get_modpath("technology")
dofile(technology_path.."/plans.lua")
dofile(technology_path.."/tools.lua")
dofile(technology_path.."/structures.lua")
dofile(technology_path.."/electric_nodes.lua")
dofile(technology_path.."/aircraft.lua")
dofile(technology_path.."/elevator.lua")
dofile(technology_path.."/screen.lua")
