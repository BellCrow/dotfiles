vim.pack.add({ "https://github.com/danymat/neogen" })

local neogen = require("neogen")
neogen.setup()

vim.keymap.set("n", "<leader>cd", function()
    neogen.generate()
end)
