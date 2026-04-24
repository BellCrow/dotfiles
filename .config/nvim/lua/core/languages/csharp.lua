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

local function d(arg)
    vim.print("Value: " .. arg)
end

-- build
local function find_possible_build_targets(start_file_path, stop_marker)
    local start_directory = start_file_path
    if vim.fn.isdirectory(start_directory) then
        start_directory = vim.fs.dirname(start_file_path)
    end

    local project_marker = "%.csproj$"
    local solution_marker = "%.sln$"
    -- we might have to expand the root identifier
    -- to be a bit more sophisticated
    local project_file_paths = Collect_files_upwards(start_directory, project_marker, stop_marker)
    local solution_file_paths = Collect_files_upwards(start_directory, solution_marker, stop_marker)

    local possible_build_targets = {}
    for _, solution in pairs(solution_file_paths) do
        table.insert(possible_build_targets, solution)
    end
    for _, project in pairs(project_file_paths) do
        table.insert(possible_build_targets, project)
    end
    return possible_build_targets
end

local function build()
    require("core/util")

    local current_file_path = vim.fn.expand("%:p")

    d("Current file path " .. current_file_path)

    local possible_build_targets = find_possible_build_targets(current_file_path, ".git")

    vim.ui.select(possible_build_targets, { prompt = "Select the target to build from" }, function(selection)
        vim.print("The idiot selected " .. selection)
    end)
end
-- build
vim.api.nvim_create_autocmd("BufEnter", {
    desc = "Setup dotnet build if we are in a csharp file",
    pattern = "*.cs",
    callback = function()
        vim.keymap.set("n", "<leader>bb", build)
    end,
})
