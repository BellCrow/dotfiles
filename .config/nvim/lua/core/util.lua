function File_exists(path)
    assert(path ~= nil, "Path cannot be nil")
    return vim.uv.fs_stat(path) ~= nil
end

-- it checks if the quickfix window is open
-- basically it check if any of the open windows
-- identifies as quickfix. might cause issue if the qf
-- window is open, but just not visible, but in that case you have
-- to open the qf window by yourself
---@return boolean
function Is_quickfix_open()
    -- taken from:
    -- https://www.reddit.com/r/neovim/comments/1k70493/comment/mousoh3/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
    return vim.iter(vim.fn.getwininfo()):any(function(wininf)
        return wininf.quickfix == 1
    end)
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
        local found_files_in_dir = Get_entries_in_path_matching_pattern(dir, file_name_pattern)
        for _, file in pairs(found_files_in_dir) do
            table.insert(collected_file_paths, file)
        end

        if stop_marker ~= nil then
            stop_marker_found = #Get_entries_in_path_matching_pattern(dir, stop_marker) ~= 0
            if stop_marker_found then
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

-- taken from https://gist.github.com/kgriffs/124aae3ac80eefe57199451b823c24ec
function String_starts_with(string_to_check, affix)
    assert(type(string_to_check) == "string", "first argument to check must be of type string")
    assert(type(affix) == "string", "Affix must be of type string")
    return string_to_check:sub(1, #affix) == affix
end
