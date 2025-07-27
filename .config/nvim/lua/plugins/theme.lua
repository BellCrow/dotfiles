return {
	"folke/tokyonight.nvim",
	init = function()
		vim.cmd.colorscheme("tokyonight-storm")
	end,
	opts = {
		transparent = true,
		on_highlights = function(highlights, colors)
			-- this makes the current line a bit more bright
			highlights.CursorLine = { bg = "#333952" }
		end,
	},
}
