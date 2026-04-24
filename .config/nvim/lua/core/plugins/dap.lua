vim.pack.add({ "https://github.com/mfussenegger/nvim-dap" })

local dap = require("dap")

vim.keymap.set("n", "<leader>db", function()
    dap.toggle_breakpoint()
end)

vim.keymap.set("n", "<leader>dc", function()
    dap.continue()
end)

vim.keymap.set("n", "<leader>dC", function()
    dap.run_to_cursor()
end)

vim.keymap.set("n", "<leader>dT", function()
    dap.terminate()
end)

vim.pack.add({ "https://github.com/igorlfs/nvim-dap-view" })
