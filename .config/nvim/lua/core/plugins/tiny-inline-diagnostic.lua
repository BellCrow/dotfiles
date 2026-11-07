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
    },
})
