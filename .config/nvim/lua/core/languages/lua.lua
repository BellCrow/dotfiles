local function is_nvim_config()
    local config_path = ".config/nvim"
    local buf_path = vim.api.nvim_buf_get_name(0)
    local path_match = buf_path:find(config_path, 1, true)
    return path_match ~= nil
end

local lua_ls_config = {
    cmd = { "lua-language-server" },
    root_markers = { ".git" },
    filetypes = { "lua" },
}

if is_nvim_config() then
    vim.print("Adding vim types to lua ls")
    lua_ls_config.settings = {
        Lua = {
            workspace = {
                library = {
                    vim.fn.expand("$VIMRUNTIME/lua"),
                    vim.fn.stdpath("config") .. "/lua",
                },
            },
        },
    }
end

vim.lsp.config("lua_ls", lua_ls_config)
vim.lsp.enable("lua_ls")

-- Formatting
local conform = require("conform")

conform.formatters.my_stylua = {
    command = "stylua",
    args = {
        "--call-parentheses",
        "Always",

        "--collapse-simple-statement",
        "Never",

        "--indent-type",
        "Spaces",

        "--line-endings",
        "Unix",

        "--quote-style",
        "AutoPreferDouble",

        "--sort-requires",

        "--space-after-function-names",
        "Never",
        -- means, that stylua takes
        -- input from the stdin
        "-",
    },
}
conform.formatters_by_ft.lua = { "my_stylua" }
