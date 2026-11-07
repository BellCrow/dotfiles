vim.pack.add({ "https://github.com/nvim-neotest/neotest",
	"https://github.com/nvim-neotest/nvim-nio" })
vim.pack.add({ "https://github.com/citizenharris/neotest-dotnet" })

-- Lazy loader for neotest: only require/setup when first used
local neotest_instance = nil
local function get_neotest()
	if not neotest_instance then
		neotest_instance = require("neotest")
		neotest_instance.setup({
			adapters = {
				require("neotest-dotnet"),
			},
		})
	end
	return neotest_instance
end

vim.keymap.set({ "n", "v" }, "<leader>tr", function()
	get_neotest().run.run()
end)

vim.keymap.set({ "n", "v" }, "<leader>ti", function()
	get_neotest().output.open()
end)

vim.keymap.set({ "n", "v" }, "<leader>ts", function()
	get_neotest().summary.toggle()
end)

vim.keymap.set({ "n", "v" }, "<leader>ta", function()
	get_neotest().run.run({ suite = true })
end)
