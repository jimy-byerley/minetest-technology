

technology.registered_plans = {}

technology.register_plan = function (machine_name, machine_item, sketch_image, components)
	local item_name = "technology:plan_"..machine_name
	local sketch = sketch_image or "technology_plan_default.png"
	
	minetest.register_node(":"..item_name, {
		description = "overall plan for "..machine_name,
		drawtype = "signlike",
		tile_images = {sketch},
		inventory_image = sketch,
		wield_image = sketch,
		paramtype = "light",
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		walkable = false,
		metadata_name = "sign",
		selection_box = {
			type = "wallmounted",
			--wall_top = <default>
			--wall_bottom = <default>
			--wall_side = <default>
		},
		groups = {choppy=2,dig_immediate=2,flammable=2},
		legacy_wallmounted = true,
		--sounds = default.node_sound_defaults(),
		on_construct = function(pos)
			local meta = minetest.env:get_meta(pos)
			meta:set_string("formspec", "field[text;;${text}]")
			meta:set_string("infotext", machine_name)
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			local meta = minetest.env:get_meta(pos)
			fields.text = fields.text or ""
			meta:set_string("text", fields.text)
			meta:set_string("infotext", machine_name..' ['..fields.text..']')
		end,
	})
	
	components[#components+1] = item_name
	minetest.register_craft({
		output = machine_item,
		type = "shapeless",
		recipe = components,
	})
	
	technology.registered_plans[machine_name] = {item_name, machine_item, components}
end

