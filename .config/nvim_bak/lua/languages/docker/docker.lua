-- LSP
vim.lsp.config("docker_lsp", {
    cmd = { "docker-langserver", "--stdio" },
    root_markers = { ".git" },
    filetypes = { "docker-compose.yaml", "dockerfile" },
    config = function()
        print("Starting docker lsp...")
    end,
})
vim.lsp.enable({ "docker_lsp" })
