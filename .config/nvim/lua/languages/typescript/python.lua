vim.lsp.config("typescript_lsp", {
    cmd = { "vtsls", "--stdio" },
    filetypes = { "typescript" },
    root_markers = {
        "package.json",
        ".git",
    },
})

vim.lsp.enable({ "typescript_lsp" })
