vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

-- lsp stuff
local buf = vim.lsp.buf
vim.keymap.set("n", "<leader>rn", buf.rename)
vim.keymap.set("n", "<leader>ca", buf.code_action)

-- so i can paste multiple times the same text
vim.keymap.set({ "n", "v" }, "<leader>p", '"_dP')

-- shortcut for selecting words
vim.keymap.set("v", "v", "iw")
