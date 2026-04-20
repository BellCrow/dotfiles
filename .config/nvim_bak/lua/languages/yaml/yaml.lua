-- LSP
vim.lsp.config("yamlls", {

    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yml", "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
    root_markers = { ".git" },
    settings = {
        -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
        redhat = { telemetry = { enabled = false } },
        -- formatting disabled by default in yaml-language-server; enable it
        yaml = {
            format = { enable = true },

            schemas = {
                ["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"] = "conf/**/*catalog*",
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "**/pipeline/*",
            },
        },
    },
    on_init = function(client)
        --- https://github.com/neovim/nvim-lspconfig/pull/4016
        --- Since formatting is disabled by default if you check `client:supports_method('textDocument/formatting')`
        --- during `LspAttach` it will return `false`. This hack sets the capability to `true` to facilitate
        --- autocmd's which check this capability
        client.server_capabilities.documentFormattingProvider = true
    end,
})
vim.lsp.enable({ "yamlls" })
