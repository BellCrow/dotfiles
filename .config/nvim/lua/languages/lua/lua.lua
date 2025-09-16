vim.lsp.config("lua_ls",
{
	cmd = {"lua-language-server"},
	root_markers = {".git"},
	filetypes = {"lua"}
})

vim.lsp.enable({"lua_ls"})
