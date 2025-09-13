return {
	"rebelot/kanagawa.nvim",
	priority = 10000,
	config = function()
		require("kanagawa").setup({})
		vim.cmd("colorscheme kanagawa")
	end
}
