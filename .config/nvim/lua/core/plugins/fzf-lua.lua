vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

require("fzf-lua").setup({})

local fzf = require("fzf-lua")

vim.keymap.set("n", "<Leader>fb", fzf.builtin)

-- vim.keymap.set("n", "<Leader>ff", fzf.git_files)
vim.keymap.set("n", "<Leader>ff", function()
    fzf.files()
end)

vim.keymap.set("n", "<Leader>fr", fzf.resume)

vim.keymap.set("n", "<Leader>fd", fzf.diagnostics_document)
vim.keymap.set("n", "<Leader>fD", fzf.diagnostics_workspace)

vim.keymap.set("n", "<Leader>fg", fzf.live_grep)

vim.keymap.set("n", "<Leader>ds", fzf.lsp_document_symbols)
vim.keymap.set("n", "<Leader>ws", fzf.lsp_live_workspace_symbols)
vim.keymap.set("n", "grr", fzf.lsp_references)
vim.keymap.set("n", "gd", fzf.lsp_definitions)

vim.keymap.set("n", "<Leader>fh", fzf.help_tags)
vim.keymap.set("n", "<Leader>fk", fzf.keymaps)
