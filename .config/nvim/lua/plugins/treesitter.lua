return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"yaml",
				"go",
			},
			-- Autoinstall languages that are not installed
			highlight = { enable = true },
			indent = { enable = true },
			sync_install = false,
			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,
		})

	end,
}
