-- Formatting
local conform = require("conform")

conform.formatters.my_csharp = {
    command = "dotnet format",
    args = {
        "--include",
        "$FILENAME",
    },
    stdin = false,
}
conform.formatters_by_ft.cs = { "my_csharp" }

-- docstyle
-- make neogen use the xmldoc style (it seems like roslyn cannot parse doxygen, which is the default)
require("neogen").configuration.languages.cs.template.annotation_convention = "xmldoc"

-- lsp
vim.pack.add({ "https://github.com/seblyng/roslyn.nvim" })
require("roslyn").setup({
    filewatching = "roslyn",
    broad_search = true,
    silent = true,
    extensions = {
        razor = {
            enabled = false,
        },
    },
})

vim.lsp.config("roslyn", {
    settings = {
        ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
        },
        ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "solution",
        },
        ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
        },
        ["csharp|completion"] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
        },
    },
})

-- dap
vim.pack.add({ "https://github.com/NicholasMata/nvim-dap-cs" })
require("dap-cs").setup()

-- build
local function find_possible_build_targets(start_file_path, stop_marker)
    local start_directory = start_file_path
    if vim.fn.isdirectory(start_directory) then
        start_directory = vim.fs.dirname(start_file_path)
    end

    -- i might have to expand the root identifier
    -- to be a bit more sophisticated
    local solution_file_paths = Collect_files_upwards(start_directory, "%.sln$", stop_marker)
    local project_file_paths = Collect_files_upwards(start_directory, "%.csproj$", stop_marker)

    local possible_build_targets = {}
    for _, solution in pairs(solution_file_paths) do
        table.insert(possible_build_targets, solution)
    end
    for _, project in pairs(project_file_paths) do
        table.insert(possible_build_targets, project)
    end
    return possible_build_targets
end

-- build

local build_target_hint = nil

local function build_target(build_target_arg, clean)
    local make_command = "dotnet build -v q /clp:NoSummary"

    if clean then
        make_command = make_command .. " --no-incremental"
    end

    make_command = make_command .. " " .. build_target_arg
    vim.o.makeprg = make_command
    vim.print("Building target: " .. build_target_arg .. "Log output in register c")
    vim.cmd("redir @c")
    vim.cmd("silent make")
    vim.cmd("redir END")
    -- taken from: https://www.reddit.com/r/neovim/comments/1k70493/comment/mousoh3/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
    -- it checks if the quickfix window is open
    -- basically it check if any of the open windows
    -- identifies as quickfix. might cause issue if the qf
    -- window is open, but just not visible, but in that case you have
    -- to open the qf window by yourself
    local is_qfix_open = vim.iter(vim.fn.getwininfo()):any(function(wininf)
        return wininf.quickfix == 1
    end)
    if not is_qfix_open and 0 < #vim.fn.getqflist() then
        vim.cmd("cope")
    end
end

local function build(clean)
    require("core/util")

    -- this format is....not feeling well...
    vim.o.errorformat = "%f(%l\\,%c):\\ %t%.%#:\\ %m [%o]"
    vim.o.autowrite = true

    if build_target_hint ~= nil and File_exists(build_target_hint) then
        build_target(build_target_hint, clean)
        return
    end

    local current_file_path = vim.fn.expand("%:p")

    local possible_build_targets = find_possible_build_targets(current_file_path, ".git")

    if #possible_build_targets == 0 then
        vim.notify("No .net target to build found", vim.log.levels.ERROR)
        return
    end

    if #possible_build_targets == 1 then
        build_target_hint = possible_build_targets[1]
        build_target(build_target_hint, clean)
        return
    end

    if 1 < #possible_build_targets then
        vim.ui.select(possible_build_targets, { prompt = "Select the target to build: " }, function(selection)
            if selection == nil then
                return
            end
            build_target_hint = selection
            -- have to duplicate this, as this
            -- is being called as the callback
            -- of the picker
            build_target(build_target_hint, clean)
        end)
    end
end

vim.api.nvim_create_autocmd("BufEnter", {
    desc = "Setup dotnet build if we are in a csharp file",
    pattern = "*.cs",
    callback = function()
        vim.keymap.set("n", "<leader>bb", function()
            build(false)
        end)
        vim.keymap.set("n", "<leader>bB", function()
            build(true)
        end)
    end,
})
