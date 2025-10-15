return {
    {
        "nvim-mini/mini.surround",
        config = function()
            require("mini.surround").setup({})
        end,
    },
    {
        "nvim-mini/mini.pairs",
        config = function()
            require("mini.pairs").setup({})
        end,
    },
    {
        "nvim-mini/mini.ai",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        config = function()
            local spec_treesitter = require("mini.ai").gen_spec.treesitter
            require("mini.ai").setup({
                custom_textobjects = {
                    F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
                    c = spec_treesitter({ a = "@class.outer", i = "@class.inner" }),
                },
            })
        end,
    },
    {
        "nvim-mini/mini.statusline",
        config = function()
            ---comment Formats a number for the diagnostics, so it
            ---takes a constant amount of space
            ---@param number any
            local function format_diagnostic_number(number)
                local number_width = 3

                if number == nil or number <= 0 then
                    return ""
                end

                local ret = tostring(number)
                local current_string_width = ret:len()
                if current_string_width < number_width then
                    local missing_spaces = string.rep(" ", number_width - current_string_width)
                    ret = missing_spaces .. ret
                end
                return ret
            end

            ---Takes in a string and returns it colored by the highlight group in the form of a statusline string
            ---@param text string the text to color
            ---@param highlight_group string the highlight group used to color the string
            ---@return string The colored string given in statusline format
            local function color_text(text, highlight_group)
                return "%#" .. highlight_group .. "#" .. text .. "%*"
            end

            local function lua_line()
                -- i presume one could do this more elegantly....
                local signs = { Error = "", Warn = "", Hint = "󰌵", Info = "" }

                local diagnostics_table = vim.diagnostic.count(0)
                local error_count_status_line = signs.Error
                    .. " "
                    .. format_diagnostic_number(diagnostics_table[vim.diagnostic.severity.ERROR])

                local warning_count_status_line = signs.Warn
                    .. " "
                    .. format_diagnostic_number(diagnostics_table[vim.diagnostic.severity.WARN])

                local info_count_status_line = signs.Info
                    .. " "
                    .. format_diagnostic_number(diagnostics_table[vim.diagnostic.severity.INFO])

                local hint_count_status_line = signs.Hint
                    .. " "
                    .. format_diagnostic_number(diagnostics_table[vim.diagnostic.severity.HINT])

                local diagnostic_strings = {}
                if diagnostics_table[vim.diagnostic.severity.ERROR] ~= nil then
                    table.insert(diagnostic_strings, color_text(error_count_status_line, "DiagnosticError"))
                end
                if diagnostics_table[vim.diagnostic.severity.WARN] ~= nil then
                    table.insert(diagnostic_strings, color_text(warning_count_status_line, "DiagnosticWarning"))
                end
                if diagnostics_table[vim.diagnostic.severity.INFO] ~= nil then
                    table.insert(diagnostic_strings, color_text(info_count_status_line, "DiagnosticInfo"))
                end
                if diagnostics_table[vim.diagnostic.severity.HINT] ~= nil then
                    table.insert(diagnostic_strings, color_text(hint_count_status_line, "DiagnosticHint"))
                end

                local diagnostic_values = table.concat(diagnostic_strings, " | ")
                local filename = MiniStatusline.section_filename({ trunc_width = 140 })
                local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
                local location = MiniStatusline.section_location({ trunc_width = 75 })
                local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

                return MiniStatusline.combine_groups({
                    "%<", -- Mark general truncate point
                    { hl = "MiniStatuslineFilename", strings = { filename } },
                    "%=", -- End left alignment
                    { strings = { diagnostic_values } },
                    { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
                    { strings = { search, location } },
                })
            end

            require("mini.statusline").setup({
                content = {
                    active = lua_line,
                    inactive = lua_line,
                },
            })
        end,
    },
}
