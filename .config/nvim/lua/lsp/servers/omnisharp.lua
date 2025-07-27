if not vim.fn.has("win32") then
	return
end

local lspconfig = require("lspconfig")
local pid = vim.fn.getpid()
local omnisharp_bin = '~\\tools\\omnisharp\\OmniSharp.exe'
lspconfig.omnisharp.setup({ cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) } })
