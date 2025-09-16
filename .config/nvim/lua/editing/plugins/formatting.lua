return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup({
            -- log_level = vim.log.levels.DEBUG,
            format_on_save = {
                -- I recommend these options. See :help conform.format for details.
                lsp_format = "fallback",
                timeout_m = 500,
            },
        })
        print("in init")
        vim.keymap.set("n", "<leader>ec", function()
            require("conform").format({ async = true, lsp_format = "fallback" })
        end)
    end,
}
