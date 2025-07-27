return {
	-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
	-- used for completion, annotations and signatures of Neovim apis
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		library = {
			-- Load luvit types when the `vim.uv` word is found
			{ path = "luvit-meta/library", words = { "vim%.uv" } },
			{
				path = "~/repos/personal/noita_spell_sorter/api_documentation/noita_lua_ls_documentation.lua",
				words = { "noita" },
			},
		},
	},
}
