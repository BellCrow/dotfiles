vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = " ", nbsp = " " }
vim.opt.scrolloff = 7
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.o.winborder = "none"
vim.o.cursorline = true

-- im old so i have to have vim wait for me :(
vim.o.timeout = false
vim.o.wrap = false
vim.o.laststatus = 3

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- split window navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- make half page scrolling always have
-- cursor in the middle of the page if possible
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move half page up and center view around cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move half page down and center view around cursor" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- make v->v select the current word
vim.keymap.set("v", "v", "iw")

-- make yank more smorter
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
--experimental lol
vim.api.nvim_create_user_command("SprichDeutsch", function()
	vim.keymap.set("i", "ue", "ü")
	vim.keymap.set("i", "UE", "Ü")

	vim.keymap.set("i", "ae", "ä")
	vim.keymap.set("i", "AE", "Ä")

	vim.keymap.set("i", "oe", "ö")
	vim.keymap.set("i", "OE", "Ö")

	vim.keymap.set("i", "sz", "ß")
end, {})

local white_space_visible = false
vim.api.nvim_create_user_command("ToggleWs", function()
	if not white_space_visible then
		vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
		white_space_visible = true
	else

		vim.opt.listchars = {  tab = "  ", trail = " ", nbsp = " "}
		white_space_visible = false
	end
end, {})
