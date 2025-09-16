vim.lsp.config("pyrefly", {
    cmd = { "pyrefly", "lsp" },
    root_markers = { ".git" },
    filetypes = { "python" },
})

vim.lsp.enable({ "pyrefly" })
