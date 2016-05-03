local file_name = minetest.get_worldpath() .. "/craft_table.lua.txt"

local file = io.open(file_name, "w")
file:write("craft_table = {\n")
io.close(file)

local old_register_craft = minetest.register_craft

function minetest.register_craft(craft_table)
	craft_table.source = minetest.get_current_modname()
	local craft_string = string.gsub(dump(craft_table), "\n", "\n\t")
	local file = io.open(file_name, "a")
	file:write("\t"..craft_string..",\n")
	io.close(file)
	return old_register_craft(craft_table)
end

minetest.after(1.0, function()
	local file = io.open(file_name, "a")
	file:write("}\n"..
		"for _, craft in ipairs(craft_table) do\n"..
		"\tminetest.register_craft(craft)\n"..
		"end")
	io.close(file)
end)
