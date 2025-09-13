return {
	"seblyng/roslyn.nvim",
	---@module 'roslyn.config'
	---@type RoslynNvimConfig
	config = function()
		vim.lsp.config("roslyn", {
			on_attach = function()
				print("This will print on server start")
			end,
			settings = {
				["csharp|completion"] = {
					dotnet_provide_regex_completions = true,
					dotnet_show_completion_items_from_unimported_namespaces = true,
					dotnet_show_name_completion_suggestions = true
				}
			}

		})
	end,
	opts = {
		-- your configuration comes here; leave empty for default settings
	},
}
