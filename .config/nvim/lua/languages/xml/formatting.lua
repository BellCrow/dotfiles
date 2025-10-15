local conform = require("conform")
conform.formatters.my_xmlformat = {
    command = "xmlformat",
    args = {
        -- means, that xmlformat takes
        -- input from the stdin
        "-",
    },
}
conform.formatters_by_ft.xml = { "my_xmlformat" }
