return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search Help" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Search Keymaps" })
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Search Files" })
		vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "Search Select Telescope" })
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Search current Word" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Search by Grep" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Search Diagnostics" })
		vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Search Resume" })
		vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, { desc = 'Search Recent Files ("." for repeat)' })

		vim.keymap.set("n", "<leader><leader>", function()
			require("telescope.builtin").buffers(
				{ previewer = false, initial_mode = "normal" },
				{ desc = "[ ] Find existing buffers" }
			)
		end)
		require('telescope').setup({
			defaults = {
				layout_strategy = 'vertical'
			}
		})
	end,
}
