local function setup_keybinds()
    local fzf = require("fzf-lua")

    vim.keymap.set("n", "<Leader>fb", fzf.builtin)

    vim.keymap.set("n", "<Leader>ff", fzf.git_files)
    vim.keymap.set("n", "<Leader>fF", fzf.files)

    vim.keymap.set("n", "<Leader>fr", fzf.resume)

    vim.keymap.set("n", "<Leader>fd", fzf.diagnostics_document)
    vim.keymap.set("n", "<Leader>fD", fzf.diagnostics_workspace)

    vim.keymap.set("n", "<Leader>fg", fzf.live_grep)

    vim.keymap.set("n", "<Leader>ds", fzf.lsp_document_symbols)
    vim.keymap.set("n", "<Leader>ws", fzf.lsp_workspace_symbols)
    vim.keymap.set("n", "grr", fzf.lsp_references)

    -- vim.keymap.set("n", "<Leader>fh", fzf.help_tags)
    --
    --
    -- vim.keymap.set("n", "<Leader>fw", fzf.grep_string)
    --
    --
    -- vim.keymap.set("n", "<Leader>fk", fzf.keymaps)
    --
    --
    -- -- this overrides a default (n)vim binding !
end

-- return {
--     "nvim-telescope/telescope.nvim",
--     dependencies = { "nvim-lua/plenary.nvim" },
--     config = function()
--         require("telescope").setup({
--             defaults = { layout_strategy = "vertical" },
--         })
--         setup_keybinds()
--     end,
-- }
return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "nvim-mini/mini.icons" },
    ---@module "fzf-lua"
    ---@type fzf-lua.Config|{}
    ---@diagnostic disable: missing-fields
    opts = {},
    config = function()
        require("fzf-lua").setup()
        setup_keybinds()
    end,
    ---@diagnostic enable: missing-fields
}
