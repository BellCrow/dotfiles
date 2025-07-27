return {
	"stevearc/conform.nvim",
	opts = {
		notify_on_error = false,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "autopep8" },
			rust = { "rustfmt" },
		},
		-- formatters = {
		-- 	mine = {
		-- 		command = "myTestRustFormatter",
		-- 		args = {},
		-- 		stdin = true,
		-- 		condition = function(self, ctx)
		-- 			-- TODO: add here to only let csharpier run on windows
		-- 			return false
		-- 		end,
		-- 	},
		-- },
	},

	keys = {
		{
			"<leader>ec",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
}
