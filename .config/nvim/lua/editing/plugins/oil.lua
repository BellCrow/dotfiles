return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
        require("oil").setup({
            keymaps = {
                -- unsetting some keybinds
                ["<C-l"] = false,
                ["<C-h"] = false,
                ["g?"] = { "actions.show_help", mode = "n" },
                ["<CR>"] = "actions.select",
                ["<leader>v"] = { "actions.select", opts = { vertical = true } },
                ["<leader>h"] = { "actions.select", opts = { horizontal = true } },
                ["<C-t>"] = { false },
                ["<C-p>"] = { "actions.preview" },
                ["<C-c>"] = { "actions.close", mode = "n" },
                ["<leader>r"] = "actions.refresh",
                ["-"] = { "actions.parent", mode = "n" },
                ["_"] = { "actions.open_cwd", mode = "n" },
                ["`"] = { "actions.cd", mode = "n" },
                ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
                ["gs"] = { "actions.change_sort", mode = "n" },
                ["gx"] = "actions.open_external",
                ["g."] = { "actions.toggle_hidden", mode = "n" },
                ["g\\"] = { "actions.toggle_trash", mode = "n" },
            },
            use_default_keymaps = false,
        })
        vim.keymap.set("n", "\\", "<cmd>Oil<CR>")
    end,
}
