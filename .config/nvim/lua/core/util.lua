function File_exists(path)
    assert(path ~= nil, "Path cannot be nil")
    return vim.uv.fs_stat(path) ~= nil
end

local function get_entries_in_path(path)
    assert(path ~= nil, "Path cannot be nil")
    local scan_dir_handle = vim.uv.fs_scandir(path)
    if scan_dir_handle == nil then
        error("Could not open directory " .. path .. " for enumeration of content")
    end

    local ret = {}
    local name, _ = vim.uv.fs_scandir_next(scan_dir_handle)

    while name ~= nil do
        table.insert(ret, vim.fs.joinpath(path, name))
        name, _ = vim.uv.fs_scandir_next(scan_dir_handle)
    end

    return ret
end

local function get_content_in_path_by_type(path, type_arg)
    assert(path ~= nil, "Path cannot be nil")
    local scan_dir_handle = vim.uv.fs_scandir(path)
    if scan_dir_handle == nil then
        error("Could not open directory " .. path .. " for enumeration of content")
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
    return get_content_in_path_by_type(path, "directory")
end

function Collect_files_upwards(start_path, file_name_pattern, stop_marker)
    assert(start_path ~= nil)
    assert(file_name_pattern ~= nil)

    -- if we are given a file path, we
    -- get the containing directory first
    -- so we can start iterating
    local start_directory = start_path
    if vim.fn.isdirectory(start_path) == 0 then
        start_directory = vim.fs.dirname(start_directory)
    end

    -- first we have to check the start directory
    local collected_file_paths = Get_entries_in_path_matching_pattern(start_directory, file_name_pattern)

    local stop_marker_found = false
    if stop_marker ~= nil then
        stop_marker_found = #Get_entries_in_path_matching_pattern(start_directory, stop_marker) ~= 0
    end

    -- then we will iterate upwards
    for dir in vim.fs.parents(start_directory) do
        -- vim.print("Inspecting " .. dir)
        -- print("Inspecting directory: " .. dir)
        local found_files_in_dir = Get_entries_in_path_matching_pattern(dir, file_name_pattern)
        for _, file in pairs(found_files_in_dir) do
            table.insert(collected_file_paths, file)
        end

        if stop_marker ~= nil then
            -- vim.print("Looking for stop marker")
            stop_marker_found = #Get_entries_in_path_matching_pattern(dir, stop_marker) ~= 0
            -- vim.print("Stop marker " .. tostring(stop_marker_found))
            if stop_marker_found then
                -- vim.print("Found stopmarker")
                -- vim.print(Get_entries_in_path_matching_pattern(dir, stop_marker))
                return collected_file_paths
            end
        end
    end
    return collected_file_paths
end

function Get_entries_in_path_matching_pattern(path, pattern)
    assert(path)
    assert(pattern)

    local scan_dir_handle = vim.uv.fs_scandir(path)
    if scan_dir_handle == nil then
        error("Could not open directory " .. path .. " for enumeration of content")
    end

    local ret = {}
    local name, _ = vim.uv.fs_scandir_next(scan_dir_handle)

    while name ~= nil do
        if name:match(pattern) then
            table.insert(ret, vim.fs.joinpath(path, name))
        end
        name, _ = vim.uv.fs_scandir_next(scan_dir_handle)
    end

    return ret
end

function Get_lua_files_in_path(path)
    local ret = {}
    local files_in_path = Get_files_in_path(path)
    for _, file_path in ipairs(files_in_path) do
        local file_name = vim.fs.basename(file_path)
        if file_name ~= nil then
            if string.match(file_name, ".lua$") ~= nil then
                table.insert(ret, file_path)
            end
        end
    end
    return ret
end

function Get_files_in_path(path)
    return get_content_in_path_by_type(path, "file")
end

-- function Get_config_lua_path()
--     return vim.fn.stdpath("config") .. "/lua/"
-- end

-- taken from https://gist.github.com/kgriffs/124aae3ac80eefe57199451b823c24ec
function String_starts_with(string_to_check, affix)
    assert(type(string_to_check) == "string", "first argument to check must be of type string")
    assert(type(affix) == "string", "Affix must be of type string")
    return string_to_check:sub(1, #affix) == affix
end
