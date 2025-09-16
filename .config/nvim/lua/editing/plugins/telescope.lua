return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup({})
        local t = require("telescope.builtin")
        vim.keymap.set("n", "<Leader>ff", t.git_files)
        vim.keymap.set("n", "<Leader>fF", t.find_files)
        vim.keymap.set("n", "<Leader>fh", t.help_tags)
        vim.keymap.set("n", "<Leader>fg", t.live_grep)
        vim.keymap.set("n", "<Leader>fr", t.resume)
        vim.keymap.set("n", "<Leader>fk", t.keymaps)
        vim.keymap.set("n", "<Leader>ds", t.lsp_document_symbols)
        vim.keymap.set("n", "<Leader>ws", t.lsp_workspace_symbols)
    end,
}
