--[[
***part_reg_funcs.lua***
Defines the functions used to create different tool parts.

***Index***
1: Tool Heads
- Pick
- Axe
- Shovel

2: Weapons
- Broadsword
- Shortsword
- Scimitar

3: Rods and Hilts
- Tool Rod
- Broadsword Hilt
- Shortsword Hilt
- Scimitar Hilt
]]

tinkers.reg_funcs = {}

--------------------
--Helper Functions--
--------------------
local function firstToUpper(str)
  return (str:gsub("^%l", string.upper))
end

local function regBasicToolPart(part_id, part_name, texture_override)
	tinkers.reg_funcs[part_id] = function(mat_name, mat_props)
		local item_name = "tinkers:part_" .. part_id .. "_" .. mat_name
		minetest.register_craftitem(item_name, {
			description = firstToUpper(mat_props.name or mat_name) .. " " .. part_name,
			inventory_image = "tinkers_part_" .. (texture_override or part_id) .. ".png^[multiply:" .. mat_props.color,
		})
		return item_name
	end
end

-----------------
--1: Tool Heads--
-----------------

--Pickaxe Head
regBasicToolPart("pick", "Pickaxe Head")

--Axe Head
regBasicToolPart("axe", "Axe Head")

--Shovel Head
regBasicToolPart("shovel", "Shovel Head")

--------------
--2: Weapons--
--------------

--Broadsword
regBasicToolPart("broadsword", "Broadsword Blade", "broadsword_item")

--Shortsword
regBasicToolPart("shortsword", "Shortsword Blade", "shortsword_item")

--Scimitar
regBasicToolPart("scimitar", "Scimitar Blade", "scimitar_item")

------------------
--Rods and Hilts--
------------------

--Tool Rod
regBasicToolPart("toolrod", "Tool Rod", "toolrod_item")

--Broadsword Hilt
regBasicToolPart("broadhilt", "Broadsword Hilt")

--Shortsword Hilt
regBasicToolPart("shorthilt", "Shortsword Hilt")

--Scimitar Hilt
regBasicToolPart("scimitarhilt", "Scimitar Hilt")