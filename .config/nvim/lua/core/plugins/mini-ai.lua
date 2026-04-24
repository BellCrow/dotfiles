vim.pack.add({
    "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    "https://github.com/nvim-mini/mini.ai",
})

require("mini.ai").setup({})

local spec_treesitter = require("mini.ai").gen_spec.treesitter
require("mini.ai").setup({
    custom_textobjects = {
        f = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
        c = spec_treesitter({ a = "@class.outer", i = "@class.inner" }),
    },
})
