
vim.pack.add({{ src = "https://github.com/saghen/blink.cmp", version = "v1"}})
vim.pack.add({"https://github.com/saghen/blink.compat"})
vim.pack.add({"https://github.com/micangl/cmp-vimtex"})

require("blink.cmp").setup({
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = "default" },

    completion = 
	{
		menu = { direction_priority = { "s", "n" } },
		trigger = { show_on_blocked_trigger_characters = { ":", "{", "\\" } },
	},
    appearance = {
        nerd_font_variant = "mono",
    },

    sources = {
		-- Add "vimtex" to your default providers
        default = { "lsp", "path", "snippets", "vimtex" },
        -- Define the vimtex provider using the blink.compat bridge
        providers = {
            vimtex = {
                name = "vimtex",
                module = "blink.compat.source",
                score_offset = 10, -- Give vimtex suggestions higher priority
            },
        },
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


