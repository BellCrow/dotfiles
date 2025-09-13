return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 10000,
	init = function()
		vim.cmd.colorscheme("tokyonight-moon")
	end,
	-- if there are issure with getting undercurls going, 
	-- you might need to add functionality to your terminfo:
	-- https://dev.to/anurag_pramanik/how-to-enable-undercurl-in-neovim-terminal-and-tmux-setup-guide-2ld7
	opts = {
		transparent = false,
		on_highlights = function(highlights, colors)
			-- this makes the current line a bit more bright
			highlights.CursorLine = { bg = "#333952" }
		end,
		on_colors = function(colors)
			-- makes the borders around panes more visible (will most likely not look good in light mode)
			colors.border = "#565f89"
		end
	},
}
