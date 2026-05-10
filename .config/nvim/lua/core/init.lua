-- first things first
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.leader = " "
vim.g.maplocalleader = " "

require("core/settings")
require("core/binds")
require("core/terminal")

require("core/theme")

-- mini is love, mini is life
-- mini icons is a dependency of other
-- plugins and should be loaded very early
require("core/plugins/mini-icons")
require("core/plugins/mini-surround")
require("core/plugins/mini-ai")
require("core/plugins/mini-statusline")
require("core/plugins/mini-pairs")

require("core/plugins/oil")
-- general purposes plugins
require("core/plugins/neogen")
require("core/plugins/blink-cmp")
require("core/plugins/nvim-treesitter")
require("core/plugins/conform")
require("core/plugins/fzf-lua")
require("core/plugins/harpoon")
require("core/plugins/tiny-inline-diagnostic")

require("core/plugins/dap")

-- languages
require("core/languages/lua")
require("core/languages/csharp")
require("core/languages/python")
require("core/languages/xml")
require("core/languages/yaml")

-- custom plugin
require("core/plugins/light-notes")
