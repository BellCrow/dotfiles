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
}
