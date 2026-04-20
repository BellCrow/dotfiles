vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

local conform = require("conform")

conform.setup({
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})

vim.keymap.set("n", "<leader>ec", function()
    vim.print("formatting buffer")
    conform.format()
end)
