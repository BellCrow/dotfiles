return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			'folke/lazydev.nvim',
			ft = 'lua',
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
		},
	},
	config = function()
		--print("Loading lsps....")
		-- snippet of code to iterate the servers folder and load all lsp server init code files
		local lualspRelativePath = "lua/lsp/servers"
		local lualspLoadPath = "lsp/servers"
		for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/" .. lualspRelativePath)) do
			local lspServerFile = string.match(file, "(%g*)%.%g")
			local fileToLoad = lualspLoadPath .. "/" .. lspServerFile
			require(fileToLoad)
		end
	end,
}
