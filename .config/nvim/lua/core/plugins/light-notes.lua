vim.pack.add({
    { src = "https://github.com/BellCrow/lightNotes.nvim", version = "master" },
})
local lightNotes = require("lightNotes")
lightNotes.setup({ notes_directory = "~/lightNotesDemo/notes", log_level = 1 })

vim.keymap.set("n", "<leader>ng", lightNotes.toggle_global_note, { desc = "LightNotes: Opens the global note" })

vim.keymap.set("n", "<leader>nb", lightNotes.toogle_branch_scoped_note, {
    desc = "LightNotes: Opens a note scoped to the branch of the current git repo. Fails if you are not in a git repository",
})

vim.keymap.set("n", "<leader>np", lightNotes.toogle_repo_scoped_note, {
    desc = "LightNotes: Opens a note scoped to the current repository. Fails if you are not in a git repository",
})

vim.keymap.set("n", "<leader>nn", lightNotes.close_note, {
    desc = "LightNotes: Closes an existing float window if there is one. It's supposed to be a nicer shortcut,"
        .. " than pressing the same shortcut as the one use to open the current note",
})

local function file_scoped_note(file_path)
    vim.print("Gotten file path: " .. file_path)
    local identifier = lightNotes.calcualate_hash(file_path)
    return identifier, identifier
end

vim.keymap.set("n", "<leader>nf", function()
    lightNotes.custom_scope(file_scoped_note)
end)
