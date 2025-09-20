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

            view_options = {
                -- This function defines what is considered a "hidden" file
                is_hidden_file = function(name, bufnr)
                    -- add a true or false entry, to have a file hidden or shown.
                    -- by default all files starting with a "." are hidden
                    local file_rules = {}
                    -- this line for instance shows .gitignore files
                    -- mind, that other dotfiles will still be hidden
                    file_rules[".gitignore"] = true

                    local file_rule = file_rules[name]
                    if file_rule ~= nil and file_rule then
                        return false
                    end
                    -- this is the default handler for all files, that
                    -- do not have an explicit handler
                    local m = name:match("^%.")
                    return m ~= nil
                end,
            },
        })
        vim.keymap.set("n", "\\", "<cmd>Oil<CR>")
    end,
}
