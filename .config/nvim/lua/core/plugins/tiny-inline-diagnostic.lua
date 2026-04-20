vim.pack.add({ "https://github.com/rachartier/tiny-inline-diagnostic.nvim" })

require("tiny-inline-diagnostic").setup({
    preset = "amongus",
    options = {
        add_messages = {
            display_count = true,
            use_max_severity = true,
        },
        multilines = {
            enabled = true,
        },
        severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            -- vim.diagnostic.severity.INFO,
            -- vim.diagnostic.severity.HINT,
        },
    },
})
