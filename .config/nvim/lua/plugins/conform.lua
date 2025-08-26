return {
	"stevearc/conform.nvim",
	opts = {
		notify_on_error = false,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "autopep8" },
			rust = { "rustfmt" },
			xml = { "xmllint" },
			json = { "jq" }

		},
		formatters = {
			xmllint = {
				command = "xmllint",
				args = { "--format", "-" },
				stdin = true,
			},
			jq = {
				command = "jq",
				args = { "." },
				stdin = true,
			},
		},
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
