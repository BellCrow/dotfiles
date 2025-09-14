return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
	  require('tiny-inline-diagnostic').setup({
		transparent_bg = false,
		preset = "powerline",
		use_icons_from_diagnostic = true,
		show_all_diags_on_cursorline = true,
		enable_on_insert = true,
	})
    end
}
