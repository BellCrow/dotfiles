return {
    {
        "nvim-mini/mini.surround",
        config = function()
            require("mini.surround").setup({})
        end,
    },
    {
        "nvim-mini/mini.pairs",
        config = function()
            require("mini.pairs").setup({})
        end,
    },
    {
        "nvim-mini/mini.ai",
        config = function()
            local spec_treesitter = require("mini.ai").gen_spec.treesitter
            require("mini.ai").setup({
                -- todo: fix/add this
                -- custom_textobjects = {
                --     -- add function definition as textobjects
                --     ---@diagnostic disable-next-line: undefined-global
                --     F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
                --     c = spec_treesitter({ a = "@class.outer", i = "@class.inner" }),
                -- },
            })
        end,
    },
}
