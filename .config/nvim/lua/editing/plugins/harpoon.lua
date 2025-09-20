return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    -- dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({
            settings = {
                -- makes harpoon not write a save file
                -- to disk for folders/projects
                encode = "false",
            },
        })

        vim.keymap.set("n", "<leader><leader><leader>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        ----------------SHOW BUFFERS---------------------
        vim.keymap.set("n", "<leader><leader>y", function()
            harpoon:list():select(1)
        end)

        vim.keymap.set("n", "<leader><leader>u", function()
            harpoon:list():select(2)
        end)

        vim.keymap.set("n", "<leader><leader>i", function()
            harpoon:list():select(3)
        end)
        vim.keymap.set("n", "<leader><leader>o", function()
            harpoon:list():select(4)
        end)

        vim.keymap.set("n", "<leader><leader>p", function()
            harpoon:list():select(5)
        end)

        ----------------PIN BUFFERS---------------------
        vim.keymap.set("n", "<leader>ay", function()
            print("pinned to y")
            harpoon:list():replace_at(1)
        end)

        vim.keymap.set("n", "<leader>au", function()
            print("pinned to u")
            harpoon:list():replace_at(2)
        end)

        vim.keymap.set("n", "<leader>ai", function()
            print("pinned to i")
            harpoon:list():replace_at(3)
        end)
        vim.keymap.set("n", "<leader>ao", function()
            print("pinned to o")
            harpoon:list():replace_at(4)
        end)

        vim.keymap.set("n", "<leader>ap", function()
            print("pinned to p")
            harpoon:list():replace_at(5)
        end)
    end,
}
