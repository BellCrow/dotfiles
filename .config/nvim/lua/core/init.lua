-- first things first
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.leader = " "
vim.g.maplocalleader = " "

require("core/settings")
require("core/binds")
require("core/terminal")

require("core/theme")

-- mini icons is a dependency of other
-- plugins and should be loaded very early
require("core/plugins/mini-icons")

require("core/plugins/mini-files")
require("core/plugins/mini-surround")
require("core/plugins/mini-ai")
require("core/plugins/mini-statusline")
require("core/plugins/mini-pairs")

require("core/plugins/blink-cmp")
require("core/plugins/nvim-treesitter")
require("core/plugins/conform")
require("core/plugins/fzf-lua")
require("core/plugins/harpoon")
require("core/plugins/tiny-inline-diagnostic")

require("core/languages/lua")
