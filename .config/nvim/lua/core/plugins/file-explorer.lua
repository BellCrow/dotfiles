vim.pack.add({
	-- { src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/stevearc/oil.nvim" },
})


-- smart oil view taken 
-- from: https://github.com/stevearc/oil.nvim/blob/master/doc/recipes.md#hide-gitignored-files-and-show-git-tracked-hidden-files
-- helper function to parse output
local function parse_output(proc)
  local result = proc:wait()
  local ret = {}
  if result.code == 0 then
    for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
      -- Remove trailing slash
      line = line:gsub("/$", "")
      ret[line] = true
    end
  end
  return ret
end

-- build git status cache
local function new_git_status()
  return setmetatable({}, {
    __index = function(self, key)
      local ignore_proc = vim.system(
        { "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
        {
          cwd = key,
          text = true,
        }
      )
      local tracked_proc = vim.system({ "git", "ls-tree", "HEAD", "--name-only" }, {
        cwd = key,
        text = true,
      })
      local ret = {
        ignored = parse_output(ignore_proc),
        tracked = parse_output(tracked_proc),
      }

      rawset(self, key, ret)
      return ret
    end,
  })
end
local git_status = new_git_status()

-- Clear git status cache on refresh
local refresh = require("oil.actions").refresh
local orig_refresh = refresh.callback
refresh.callback = function(...)
  git_status = new_git_status()
  orig_refresh(...)
end

-- end
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
		  local dir = require("oil").get_current_dir(bufnr)
		  local is_dotfile = vim.startswith(name, ".") and name ~= ".."
		  -- if no local directory (e.g. for ssh connections), just hide dotfiles
		  if not dir then
			return is_dotfile
		  end
		  -- dotfiles are considered hidden unless tracked
		  if is_dotfile then
			return not git_status[dir].tracked[name]
		  else
			-- Check if file is gitignored
			return git_status[dir].ignored[name]
		  end
		end,
	},
})

-- local nvim_tree = require("nvim-tree")
-- nvim_tree.setup({
-- 	disable_netrw = true,
-- 	-- hijack_netrw = true,
-- 	view = {
-- 		relativenumber = true,
-- 	},
-- 	-- filters = {
-- 	-- 	git_ignored = false
-- 	-- },
-- 	renderer = {
-- 		icons = {
-- 			glyphs = {
-- 				git = {
-- 					unstaged = "[u]",
-- 					staged = "[s]",
-- 					unmerged = "[m]",
-- 					renamed = "[r]",
-- 					untracked = "[?]",
-- 					deleted = "[d]",
-- 					ignored = "[i]",
-- 				},
-- 				folder = {
-- 					arrow_closed = ">",
-- 					arrow_open = "v",
-- 				},
-- 			},
-- 			git_placement = "after",
-- 			show = {
-- 				git = true,
-- 				modified = true,
-- 				diagnostics = true,
-- 				bookmarks = false,
-- 			},
-- 		},
-- 	},
-- })
--
-- local api = require("nvim-tree.api")
-- api.tree.toggle_gitignore_filter()
--

-- vim.keymap.set("n", "<leader>\\", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "\\", "<cmd>Oil<CR>")
