vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

local config = {
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
}

local instance = nil
local function get_instance()
	if instance == nil then
		instance = require("conform")

		instance.setup(config)
	end
	return instance
end

vim.keymap.set("n", "<leader>ec", function()
	vim.print("formatting buffer")
	get_instance().format()
end)
