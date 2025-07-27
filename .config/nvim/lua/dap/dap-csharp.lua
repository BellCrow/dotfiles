if not vim.fn.has("win32") then
	return
end

return {
	"NicholasMata/nvim-dap-cs",
	config = function()
		require("dap-cs").setup()
	end,
	netcoredbg = {
		-- the path to the executable netcoredbg which will be used for debugging.
		-- by default, this is the "netcoredbg" executable on your PATH.
		path = "C:\\Users\\jkrieger\\AppData\\Local\\nvim-data\\mason\\packages\\netcoredbg\\netcoredbg\\netcoredbg.exe",
	},
}
