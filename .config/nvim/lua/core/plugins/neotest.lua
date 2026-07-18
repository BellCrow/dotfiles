vim.pack.add({"https://github.com/nvim-neotest/neotest",
			"https://github.com/nvim-neotest/nvim-nio"})
vim.pack.add({"https://github.com/citizenharris/neotest-dotnet"})

vim.keymap.set({"n", "v"}, "<leader>tr", "<cmd>Neotest run<cr>" )
vim.keymap.set({"n", "v"}, "<leader>ti", "<cmd>Neotest output<cr>" )
vim.keymap.set({"n", "v"}, "<leader>ts", "<cmd>Neotest summary<cr>")
vim.keymap.set({"n", "v"}, "<leader>ta", "<cmd>lua require('neotest').run.run({ suite = true })<cr>")

require("neotest").setup({
  adapters = {
	 require("neotest-dotnet")
  },
})

