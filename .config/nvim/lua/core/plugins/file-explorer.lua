vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/stevearc/oil.nvim" },
})

require("oil").setup({
	default_file_explorer = true,
	use_default_keymaps = false,
	keymaps = {
		["<C-l>"] = false,
		["<C-h>"] = false,
		["g?"] = { "actions.show_help", mode = "n" },
		["<CR>"] = "actions.select",
		["<leader>v"] = { "actions.select", opts = { vertical = true } },
		["<leader>h"] = { "actions.select", opts = { horizontal = true } },
		["<C-t>"] = false,
		["<C-p>"] = "actions.preview",
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
	view_options = {
		is_hidden_file = function(name, bufnr)
			local file_rules = {
				[".gitignore"] = true,
			}

			local file_rule = file_rules[name]
			if file_rule ~= nil and file_rule then
				return false
			end

			return name:match("^%.") ~= nil
		end,
	},
})

local nvim_tree = require("nvim-tree")
nvim_tree.setup({
	disable_netrw = true,
	-- hijack_netrw = true,
	view = {
		relativenumber = true,
	},
	-- filters = {
	-- 	git_ignored = false
	-- },
	renderer = {
		icons = {
			glyphs = {
				git = {
					unstaged = "[u]",
					staged = "[s]",
					unmerged = "[m]",
					renamed = "[r]",
					untracked = "[?]",
					deleted = "[d]",
					ignored = "[i]",
				},
				folder = {
					arrow_closed = ">",
					arrow_open = "v",
				},
			},
			git_placement = "after",
			show = {
				git = true,
				modified = true,
				diagnostics = true,
				bookmarks = false,
			},
		},
	},
})

local api = require("nvim-tree.api")
api.tree.toggle_gitignore_filter()


vim.keymap.set("n", "<leader>\\", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "\\", "<cmd>Oil<CR>")
