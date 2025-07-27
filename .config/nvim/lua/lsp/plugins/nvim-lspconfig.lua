return {
	"neovim/nvim-lspconfig",
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
