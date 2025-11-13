vim.lsp.config("marksman", {
    cmd = { "marksman", "server" },
    root_markers = { ".git" },
    filetypes = { "markdown" },
})
vim.lsp.enable("marksman")
