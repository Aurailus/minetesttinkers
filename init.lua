tinkers = {}

local path = minetest.get_modpath("tinkers")

local material_properties = {
	wood = {
		name = "Wooden",
		color = "#58350A"
	},
	stone = {
		name = "Cobblestone",
		color = "#6D6D6D"
	},
	iron = {
		color = "#C9C9C9"
	},
	gold = {
		name = "Golden",
		color = "#FFD100"
	},
	diamond = {
		color = "#75EEEA",
		-- omitted_parts = {
		-- 	"toolrod"
		-- }
	},
	obsidian = {
		color = "#1F2631"
	},
	mese = {
		color = "#D3D513"
	}
}

dofile(path .. "/part_reg_funcs.lua")

local tool_parts = {}

for reg_type, reg_func in pairs(tinkers.reg_funcs) do

	tool_parts[reg_type] = {}

	for mat_name, mat_props in pairs(material_properties) do
		repeat --Scope to allow breaks

			--Check if in omit list
			local omit = false
			if mat_props.omitted_parts then
				for i = 0, #mat_props.omitted_parts do
					if reg_type == mat_props.omitted_parts[i] then 
						omit = true 
						break
					end
				end
			end
			if omit then break end

			--Add tool
			table.insert(tool_parts[reg_type], {name = reg_func(mat_name, mat_props), material = mat_name})

		until true
	end
end

dofile(path .. "/tool_reg_funcs.lua")

tinkers.tools_registered = 0;
for reg_type, reg_func in pairs(tinkers.reg_funcs) do
	reg_func(tool_parts, material_properties)
end
print("[Tinkers] " .. tinkers.tools_registered .. " Tools Registered before modifiers.")

tinkers.reg_funcs = nil

-- minetest.register_craftitem("tinkers:broadsword_diamond", {
-- 	description = "Diamond Broadsword",
-- 	inventory_image = "(tinkers_part_broadsword.png^[multiply:#75EEEA)^(tinkers_part_broadhilt.png^[multiply:#1F2631)",
-- })