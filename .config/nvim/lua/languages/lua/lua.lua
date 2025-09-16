-- LSP
vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    root_markers = { ".git" },
    filetypes = { "lua" },
})
vim.lsp.enable({ "lua_ls" })

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
