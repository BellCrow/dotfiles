-- Disclaimer some of these are taken from: https://github.dev/nvim-lua/kickstart.nvim
-- 
-- Settings
--

-- first things first
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- because im a vimposter ;)
vim.o.mouse = 'a'
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.o.signcolumn = "yes"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.updatetime = 250
vim.o.cursorline = true
vim.o.scrolloff = 5
-- ask for confirmation instead of closing file with :q if there are unsaved changes
vim.o.confirm = true

vim.opt.termguicolors = true

-- timeout for combo completion etc.
vim.o.timeoutlen = 20000

-- have copied text be highlighted on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})


vim.o.winborder = 'rounded'
--
-- Binds
--
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

-- so i can paste multiple times the same text
vim.keymap.set({"n", "v"}, "<leader>p", '"_dP')

vim.keymap.set("v", "v", "iw")

vim.keymap.set({"n","v"}, "<leader><leader>", "<cmd>:lua print('test')<CR>")
