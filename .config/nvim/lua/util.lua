function File_exists(path)
	assert(path ~= nil,"Path cannot be nil")
	return vim.uv.fs_stat(path) ~= nil
end

local function get_content_in_path(path, type_arg)
	assert(path ~= nil,"Path cannot be nil")
	local scan_dir_handle = vim.uv.fs_scandir(path)
	if (scan_dir_handle == nil) then
		error("Could not open folder " .. path .. " for enumeration of content")
	end

	local ret = {}
	local name, type = vim.uv.fs_scandir_next(scan_dir_handle)

	while name ~= nil do
		if type == type_arg then
			table.insert(ret, vim.fs.joinpath(path, name))
		end
		name, type = vim.uv.fs_scandir_next(scan_dir_handle)
	end

	return ret
end

function Get_directories_in_path(path)
	return get_content_in_path(path, "directory")
end

function Get_lua_files_in_path(path)
	local ret = {}
	local files_in_path = Get_files_in_path(path)
	for _, file_path in ipairs(files_in_path) do
		local file_name = vim.fs.basename(file_path)
		if file_name ~= nil then
			if string.match(file_name,".lua$") ~= nil then
				table.insert(ret, file_path)
			end
		end
	end
	return ret
end

function Get_files_in_path(path)
	return get_content_in_path(path, "file")
end

function Get_config_lua_path()
	return vim.fn.stdpath("config").. "/lua/"
end

function Generate_folder_spec(path)
	assert(path ~= nil,"Path cannot be nil")
	local lua_files = Get_lua_files_in_path(path)
	local lua_modules_path = {}

	for _, lua_path in ipairs(lua_files) do
		local lua_module_path = Convert_lua_path_to_module_path(lua_path)
		table.insert(lua_modules_path, lua_module_path)
	end
	local plugin_path = path .. "/plugins/"

	return {
		requires = lua_modules_path,
		import = Convert_path_to_plugin_path(plugin_path)

	}
end

--- Converts a path to a lua file from the ../lua folder, into 
--- a module name, that can be required with the "require(xyz)" function
---@param lua_file_path string
function Convert_lua_path_to_module_path(lua_file_path)
	local config_lua_folder_path = Get_config_lua_path()
	local lua_module_path = string.gsub(lua_file_path, config_lua_folder_path, "")
	lua_module_path = string.gsub(lua_module_path, ".lua$", "")
	lua_module_path = string.gsub(lua_module_path, "/",".")
	return lua_module_path
end

--- Converts a path to a module path, that can be loaded with lazy
---@param folder_path string
function Convert_path_to_plugin_path(folder_path)
	-- vim.print("Trying to convert to plugin spec " .. folder_path)
	if not File_exists(folder_path) then
		return {}
	end
	local config_lua_folder_path = Get_config_lua_path()
	local module_path = string.gsub(folder_path, config_lua_folder_path, "")
	-- removing the trailing slash
	module_path = string.sub(module_path, 0, string.len(module_path)-1)
	module_path = string.gsub(module_path, "/",".")
	return { module_path }
end

function Add_spec_to_other_spec(spec_to_add_to, to_add)
	for _, require in ipairs(to_add.requires) do
		table.insert(spec_to_add_to.requires, require)
	end
	for _, import in ipairs(to_add.import) do
		table.insert(spec_to_add_to.import, import)
	end
end
---Creates a spec for requiring of all the lua files in a folder and the tables, that can be loaded with lazy
---@param path string
function generate_folder_spec(path)

end
