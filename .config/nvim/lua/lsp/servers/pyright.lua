local lspconfig = require("lspconfig")
lspconfig.pyright.setup({
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
})
