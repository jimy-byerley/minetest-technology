
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

dofile(minetest.get_modpath("technology").."/tools.lua")

dofile(minetest.get_modpath("technology").."/structures.lua")

dofile(minetest.get_modpath("technology").."/electric_nodes.lua")

dofile(minetest.get_modpath("technology").."/aircraft.lua")

dofile(minetest.get_modpath("technology").."/screen.lua")
