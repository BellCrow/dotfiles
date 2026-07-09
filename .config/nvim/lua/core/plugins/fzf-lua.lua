vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

require("fzf-lua").setup({
	keymap = {
		fzf = {
			["ctrl-q"] = "select-all+accept",
		},
	},
	winopts = {
		preview = {
			vertical = "up:65%",
			layout = "vertical",
		},
	},
})
-- replaces the default number selection
-- called with vim.ui.select with an fzf picker
require("fzf-lua").register_ui_select()

local fzf = require("fzf-lua")

vim.keymap.set("n", "<Leader>fq", fzf.builtin)
vim.keymap.set("n", "<Leader>fp", fzf.complete_path)

-- vim.keymap.set("n", "<Leader>ff", fzf.git_files)
vim.keymap.set("n", "<Leader>ff", function()
	-- this will always include hidden dotfile
	-- but also exlude the content of any .git folder
	fzf.files { fd_opts = "-H --exclude .git" }
end)

vim.keymap.set("n", "<Leader>fr", fzf.resume)
vim.keymap.set("n", "<Leader>dd", fzf.diagnostics_document)
vim.keymap.set("n", "<Leader>wd", fzf.diagnostics_workspace)

vim.keymap.set("n", "<Leader>fg", fzf.live_grep)
vim.keymap.set("n", "<Leader>fG", fzf.lgrep_curbuf)
vim.keymap.set("n", "<Leader>fv", fzf.grep_visual)

vim.keymap.set("n", "<Leader>ds", fzf.lsp_document_symbols)
vim.keymap.set("n", "<Leader>ws", fzf.lsp_live_workspace_symbols)
vim.keymap.set("n", "grr", fzf.lsp_references)
vim.keymap.set("n", "gd", fzf.lsp_definitions)

vim.keymap.set("n", "<Leader>fh", fzf.help_tags)
vim.keymap.set("n", "<Leader>fk", fzf.keymaps)
