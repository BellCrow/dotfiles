vim.pack.add({ { src = "https://github.com/saghen/blink.cmp", version = "v1" } })

-- vim.pack.add({
--     {
--         src = "https://github.com/ThePrimeagen/harpoon",
--         version = "harpoon2",
--     },
-- })

require("blink.cmp").setup({
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = "default" },

    completion = { menu = { direction_priority = { "s", "n" } } },
    appearance = {
        nerd_font_variant = "mono",
    },

    sources = {
        default = { "lsp", "path", "snippets" },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },
    -- Experimental signature help support
    signature = { enabled = true },
})
