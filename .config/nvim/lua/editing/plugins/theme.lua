return {
    "rebelot/kanagawa.nvim",
    priority = 10000,
    config = function()
        require("kanagawa").setup({
            terminalColors = true,
            colors = {
                theme = {
                    all = {
                        ui = {
                            -- selection is otherwise barely visible
                            bg_visual = "#210d54",
                            bg_gutter = "none",
                        },
                    },
                },
            },
            overrides = function(colors)
                -- print("In override")
                -- return {
                -- 	BlinkCmpMenu = { bg = colors.theme.ui.float.fg },
                -- 	-- BlinkCmpMenu = { bg = "#ffffff"},
                -- 	BlinkCmpLabelDetail = { bg = colors.theme.ui.float.fg },
                -- 	BlinkCmpMenuSelection = { bg = colors.theme.ui.float.fg },
                --
                -- 	-- BlinkCmpMenu = { bg = colors.theme.ui.bd_p1},
                -- 	-- BlinkCmpLabelDetail = { bg = colors.theme.dragonBlack3 },
                -- 	-- BlinkCmpMenuSelection = { bg = colors.theme.waveBlue1 },
                local theme = colors.theme
                return {
                    NormalFloat = { bg = "none" },
                    FloatBorder = { bg = "none" },
                    FloatTitle = { bg = "none" },

                    -- Save an hlgroup with dark background and dimmed foreground
                    -- so that you can use it where your still want darker windows.
                    -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                    NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                    -- Popular plugins that open floats will link to NormalFloat by default;
                    -- set their background accordingly if you wish to keep them dark and borderless
                    LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

                    -- the blink.cmp menu seems to not use the regular float window
                    -- colors. so we set them here explicitly
                    BlinkCmpMenuBorder = { bg = "None", fg = theme.ui.float.fg_border },
                    BlinkCmpMenu = { bg = "None", fg = theme.ui.fg_dim },
                }
            end,
        })
        vim.cmd("colorscheme kanagawa-wave")
    end,
}
