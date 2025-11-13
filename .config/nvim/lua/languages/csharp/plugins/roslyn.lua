return {
    "seblyng/roslyn.nvim",
    opts = {},
    setup = function()
        print("Loading roslyn lsp...")
        vim.lsp.config("roslyn", {
            settings = {
                ["csharp|inlay_hints"] = {
                    csharp_enable_inlay_hints_for_implicit_object_creation = true,
                    csharp_enable_inlay_hints_for_implicit_variable_types = true,
                },
                ["csharp|background_analysis"] = {
                    dotnet_analyzer_diagnostics_scope = "solution",
                },
                ["csharp|code_lens"] = {
                    dotnet_enable_references_code_lens = true,
                },
            },
        })
    end,
}
