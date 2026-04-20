vim.pack.add({ "https://github.com/nvim-mini/mini.files" })

local files = require("mini.files")

files.setup({
    mappings = {
        go_in = "l",
        go_in_plus = "L",
        go_out = "h",
        go_out_plus = "H",
        mark_goto = "'",
        mark_set = "m",
        reset = "<BS>",
        reveal_cwd = "@",
        show_help = "g?",
        synchronize = "=",
        trim_left = "<",
        trim_right = ">",
        close = "<esc>",
    },
})

vim.keymap.set("n", "\\", function()
    if files.get_explorer_state() == nil then
        files.open(vim.api.nvim_buf_get_name(0))
    end
end, { nowait = true })

vim.keymap.set("n", "|", function()
    if files.get_explorer_state() == nil then
        require("mini.files").open(nil, false)
    end
end, { nowait = true })
