vim.pack.add({ "https://github.com/folke/tokyonight.nvim" })
require("tokyonight").setup({
    on_highlights = function(hl, colors)
        hl.WinSeparator = { fg = colors.blue2 }
    end,
})
vim.cmd([[colorscheme tokyonight-moon]])
