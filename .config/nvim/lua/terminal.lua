-- created with the help of the legendary tj:
local function Create_floating_term(workDir)
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)

    local x = math.floor((vim.o.columns - width) / 2)
    local y = math.floor((vim.o.lines - height) / 2)

    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = x,
        row = y,
        style = "minimal",
        border = "rounded",
    }

    local path = vim.fn.expand("%:p:h")
    local backing_buffer = vim.api.nvim_create_buf(false, true)
    _ = vim.api.nvim_open_win(backing_buffer, true, win_config)
    vim.print(path)
    local workDirInternal = workDir or vim.uv.cwd()
    vim.fn.termopen({ vim.o.shell }, { cwd = workDirInternal })
    vim.cmd("normal i")
end

function Create_floating_term_in_cwd()
    local cwd = vim.uv.cwd()
    assert(cwd ~= nil)
    Create_floating_term(cwd)
end
function Create_floating_term_in_path_of_current_file()
    local filePath = vim.fn.expand("%:p:h")
    Create_floating_term(filePath)
end
