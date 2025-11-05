local function setup_keybinds()
    local t = require("telescope.builtin")
    vim.keymap.set("n", "<Leader>fF", t.git_files)

    vim.keymap.set("n", "<Leader>fd", t.diagnostics)

    vim.keymap.set("n", "<Leader>ff", function()
        t.find_files({ hidden = true })
    end)

    vim.keymap.set("n", "<Leader>fh", t.help_tags)

    vim.keymap.set("n", "<Leader>fg", t.live_grep)

    vim.keymap.set("n", "<Leader>fw", t.grep_string)

    vim.keymap.set("n", "<Leader>fr", t.resume)

    vim.keymap.set("n", "<Leader>fk", t.keymaps)

    vim.keymap.set("n", "<Leader>ds", t.lsp_document_symbols)

    vim.keymap.set("n", "<Leader>ws", t.lsp_workspace_symbols)

    -- this overrides a default (n)vim binding !
    vim.keymap.set("n", "grr", t.lsp_references)
end

return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup({
            defaults = { layout_strategy = "vertical" },
        })
        setup_keybinds()
    end,
}
