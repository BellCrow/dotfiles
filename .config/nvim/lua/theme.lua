return {
	"rebelot/kanagawa.nvim",
	priority = 10000,
	config = function()
		require("kanagawa").setup({})
		vim.cmd("colorscheme kanagawa")
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
	end
}
