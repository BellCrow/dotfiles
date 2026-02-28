require("terminal")
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
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.type_definition)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("i", "<C-s>", function()
    vim.lsp.buf.signature_help({ anchor_bias = "above" })
end)

-- so i can paste multiple times the same text
vim.keymap.set({ "n", "v" }, "<leader>p", '"_dP')

-- shortcut for selecting words
vim.keymap.set("v", "v", "iw")

-- copy absolute path of current file(or buffer) to clipboard
vim.keymap.set({ "n", "v" }, "<leader>l", function()
    vim.fn.setreg("+", vim.fn.expand("%:p"))
-- terminal help
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", "<leader>th", function()
    Create_floating_term_in_path_of_current_file()
end)
vim.keymap.set("n", "<leader>tt", function()
    Create_floating_term_in_cwd()
end)
