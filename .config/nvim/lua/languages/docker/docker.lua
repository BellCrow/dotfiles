-- LSP
vim.lsp.config("docker_lsp", {
    cmd = { "docker_lsp", "start" },
    root_markers = { ".git" },
    filetypes = { "docker-compose.yaml" },
    config = function()
        print("Starting docker lsp...")
    end,
})
vim.lsp.enable({ "docker_lsp" })
