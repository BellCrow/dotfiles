-- Formatting
local conform = require("conform")

conform.formatters.my_csharp = {
    command = "dotnet format",
    args = {
        "--include",
        "$FILENAME",
    },
    stdin = false,
}
conform.formatters_by_ft.cs = { "my_csharp" }

-- make neogen use the xmldoc style (it seems like roslyn cannot parse doxygen, which is the default)
require("neogen").configuration.languages.cs.template.annotation_convention = "xmldoc"
