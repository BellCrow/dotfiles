vim.pack.add({"https://github.com/lervag/vimtex"})

vim.cmd("filetype plugin indent on")

-- vimtex-Konfiguration
vim.g.vimtex_view_method = 'general'
vim.g.vimtex_quickfix_mode = 0

-- Nur <Leader> verwenden, keinen separaten LocalLeader
vim.g.vimtex_mappings_disable = {
 ['n'] = {
   'K',           -- Beispiel: Dokumap über K deaktivieren (optional)
 },
}
-- Wichtig: vimtex nutzt standardmäßig <localleader> für seine Mappings.
-- Wir setzen hier lokale Mappings auf den globalen Leader um:

-- Diese Funktion kannst du bei Bedarf erweitern, um konkrete Mappings zu setzen:
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Beispiel-Mappings, die sonst auf <localleader> liegen würden:
-- Statt \ll (localleader ll) → <leader>ll
map('n', '<leader>ll', '<cmd>VimtexCompile<CR>', opts)
map('n', '<leader>lk', '<cmd>VimtexStop<CR>', opts)
map('n', '<leader>lv', '<cmd>VimtexView<CR>', opts)
map('n', '<leader>lc', '<cmd>VimtexClean<CR>', opts)

-- Force Neovim to treat .tex files as LaTeX, not plain TeX
vim.g.tex_flavor = "latex"

-- Configure SumatraPDF for Windows Forward/Inverse Search
vim.g.vimtex_view_general_viewer = "C:\\Users\\jkrieger\\AppData\\Local\\SumatraPDF\\SumatraPDF.exe"
vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"

-- Automatically open quickfix window on compilation errors
vim.g.vimtex_quickfix_mode = 1
