-- TODO: test the option to debug unit tests
-- if missing; add this functionality
require("core/util")
vim.pack.add({ "https://github.com/mfussenegger/nvim-dap" })

local dap = require("dap")

vim.keymap.set("n", "<leader>db", function()
    dap.toggle_breakpoint()
end)

vim.keymap.set("n", "<leader>dB", function()
    dap.set_breakpoint()
end)

vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
    require("dap.ui.widgets").hover()
end)

vim.keymap.set("n", "<leader>dx", function()
    dap.clear_breakpoints()
end)

vim.keymap.set("n", "<leader>fb", function()
    require("fzf-lua").dap_breakpoints()
end)

vim.keymap.set("n", "<Up>", function()
    dap.continue()
end)

vim.keymap.set("n", "<leader>dC", function()
    dap.run_to_cursor()
end)

vim.keymap.set("n", "<Down>", function()
    dap.step_over()
end)

vim.keymap.set("n", "<Right>", function()
    dap.step_into()
end)

vim.keymap.set("n", "<Left>", function()
    dap.step_out()
end)

vim.keymap.set("n", "<leader>dT", function()
    dap.terminate()
end)

-- taken from the man himself https://git.ramboe.io/YouTube/neovim-c-the-sane-debugging-setup-nvim-dap-ui
-- https://emojipedia.org/en/stickers/search?q=circle
vim.fn.sign_define("DapBreakpoint", {
    text = "🔴",
    texthl = "DapBreakpointSymbol",
    linehl = "DapBreakpoint",
    numhl = "DapBreakpoint",
})

vim.fn.sign_define("DapBreakpointRejected", {
    text = "⭕",
    texthl = "DapStoppedSymbol",
    linehl = "DapBreakpoint",
    numhl = "DapBreakpoint",
})

vim.fn.sign_define("DapStopped", {
    text = "➜",
    texthl = "MiniIconsRed",
    linehl = "RedrawDebugClear",
    numhl = "DapBreakpoint",
})

-- dap view
vim.pack.add({ "https://github.com/igorlfs/nvim-dap-view" })
require("dap-view").setup({
    winbar = {
        -- You can add a "console" section to merge the terminal with the other views
        sections = { "scopes", "watches", "exceptions", "breakpoints", "threads", "repl", "console" },
        -- Must be one of the sections declared above
        default_section = "scopes",
        -- Configure each section individually
        base_sections = {
            -- Labels can be set dynamically with functions
            -- Each function receives the window's width and the current section as arguments
            scopes = { label = "Scopes", keymap = "S" },
            breakpoints = { label = "Breakpoints", keymap = "B" },
            exceptions = { label = "Exceptions", keymap = "E" },
            watches = { label = "Watches", keymap = "W" },
            threads = { label = "Threads", keymap = "T" },
            repl = { label = "REPL", keymap = "R" },
            sessions = { label = "Sessions", keymap = "K" },
            console = { label = "Console", keymap = "C" },
        },
        controls = {
            enabled = true,
            position = "right",
            buttons = {
                "play",
                "step_into",
                "step_over",
                "step_out",
                "step_back",
                "run_last",
                "terminate",
                "disconnect",
            },
        },
    },
    -- Auto open when a session is started and auto close when all sessions finish
    -- Alternatively, can be a string:
    -- - "keep_terminal": as above, but keeps the terminal when the session finishes
    -- - "open_term": open the terminal when starting a new session, nothing else
    auto_toggle = true,
})

local dap_view = require("dap-view")
vim.keymap.set({ "n", "v" }, "<leader>dw", function()
    vim.print("blub")
    dap_view.add_expr()
end)
