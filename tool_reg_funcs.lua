--[[
***tool_reg_funcs.lua***
Defines the functions used to create different tools.

***Index***
1: Tools
- Pick
- Axe
- Shovel

2: Weapons
- Broadsword
- Shortsword
- Scimitar
]]

tinkers.reg_funcs = {}

--------------------
--Helper Functions--
--------------------
local function firstToUpper(str)
  return (str:gsub("^%l", string.upper))
end

local function regRecursion(current_materials, defs, reg_parts, mat_props)
	local ind = #current_materials + 1
	
	for i = 1, #reg_parts[defs.components[ind]] do --Cycle through tool parts for components
		current_materials[ind] = reg_parts[defs.components[ind]][i].material
		
		if #current_materials == #defs.components then
			local image = ""
			for i = 1, 2 do
				local ind = i
				if defs.draw_order then ind = defs.draw_order[ind] end

				local drawpart = defs.components[ind]
				if defs.draw_parts then drawpart = defs.draw_parts[ind] end

				image = image .. "(tinkers_part_" .. drawpart .. ".png^" ..
					"[multiply:" .. mat_props[current_materials[ind]].color .. ")"
				if i ~= #defs.components then image = image .. "^" end
			end

			minetest.register_tool("tinkers:tool_" .. defs.id .. current_materials[1] .. "_" .. current_materials[2], {
				description = firstToUpper(current_materials[1]) .. " " .. defs.name,
				tool_capabilities = {
	    		max_drop_level=3,
	    			groupcaps= {
	      			cracky={times={[1]=4.00, [2]=1.50, [3]=1.00}, uses=70, maxlevel=1}
	 		  		}
					},
					inventory_image = image
				})
		else
			regRecursion(current_materials, defs, reg_parts, mat_props)
		end
	end
end

local function regBasicTool(defs)
	tinkers.reg_funcs[defs.id] = function(reg_parts, mat_props)
		local current_materials = {}
		regRecursion(current_materials, defs, reg_parts, mat_props)
	end
end

------------
--1: Tools--
------------

--Pickaxe
regBasicTool({
	id = "pick",
	name = "Pickaxe",
	components = {"pick", "toolrod"},
	draw_order = {2, 1},
	capabilities = {

	}
})

--Axe
regBasicTool({
	id = "axe",
	name = "Axe",
	components = {"axe", "toolrod"},
	draw_order = {2, 1},
	capabilities = {

	}
})

--Shovel
regBasicTool({
	id = "shovel",
	name = "Shovel",
	components = {"shovel", "toolrod"},
	draw_order = {2, 1},
	capabilities = {

	}
})

--Mattock
regBasicTool({
	id = "mattock",
	name = "Mattock",
	components = {"shovel", "axe", "toolrod"},
	draw_parts = {"shovel", "axe", "toolrod"},
	-- draw_parts = {"axe", "mattock", "toolrod"},
	draw_order = {2, 1, 2},
	capabilities = {

	}
})

--------------
--2: Weapons--
--------------

--Broadsword
regBasicTool({
	id = "broadsword",
	name = "Broadsword",
	components = {"broadsword", "broadhilt"},
	capabilities = {

	}
})

--Shortsword
regBasicTool({
	id = "shortsword",
	name = "Shortsword",
	components = {"shortsword", "shorthilt"},
	capabilities = {

	}
})

--Scimitar
regBasicTool({
	id = "scimitar",
	name = "Scimitar",
	components = {"scimitar", "scimitarhilt"},
	capabilities = {

	}
})
