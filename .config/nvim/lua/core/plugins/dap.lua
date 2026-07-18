-- TODO: test the option to debug unit tests
-- if missing; add this functionality
require("core/util")
vim.pack.add({ "https://github.com/mfussenegger/nvim-dap" })

-- Lazy loader for nvim-dap: only require/setup when first used
local dap_instance = nil
local function get_dap()
	if not dap_instance then
		dap_instance = require("dap")

		-- Signs need to be defined once, when dap is first loaded
		vim.fn.sign_define("DapBreakpoint", {
			text = "🔴",
			texthl = "DapBreakpointSymbol",
			linehl = "DapBreakpoint",
			numhl = "DapBreakpoint",
		})

		vim.fn.sign_define("DapBreakpointRejected", {
			text = "⭕",
			texthl = "DapStoppedSymbol",
			linehl = "DapBreakpoint",
			numhl = "DapBreakpoint",
		})

		vim.fn.sign_define("DapStopped", {
			text = "➜",
			texthl = "MiniIconsRed",
			linehl = "RedrawDebugClear",
			numhl = "DapBreakpoint",
		})
	end
	return dap_instance
end

vim.keymap.set("n", "<leader>db", function()
	get_dap().toggle_breakpoint()
end)

vim.keymap.set("n", "<leader>dB", function()
	get_dap().set_breakpoint()
end)

vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
	require("dap.ui.widgets").hover()
end)

vim.keymap.set("n", "<leader>dx", function()
	get_dap().clear_breakpoints()
end)

vim.keymap.set("n", "<leader>fb", function()
	require("fzf-lua").dap_breakpoints()
end)

vim.keymap.set("n", "<Up>", function()
	get_dap().continue()
end)

vim.keymap.set("n", "<leader>dC", function()
	get_dap().run_to_cursor()
end)

vim.keymap.set("n", "<Down>", function()
	get_dap().step_over()
end)

vim.keymap.set("n", "<Right>", function()
	get_dap().step_into()
end)

vim.keymap.set("n", "<Left>", function()
	get_dap().step_out()
end)

vim.keymap.set("n", "<leader>dT", function()
	get_dap().terminate()
end)

-- dap view
vim.pack.add({ "https://github.com/igorlfs/nvim-dap-view" })

local dap_view_instance = nil
local function get_dap_view()
	if not dap_view_instance then
		dap_view_instance = require("dap-view")
		dap_view_instance.setup({
			winbar = {
				-- You can add a "console" section to merge the terminal with the other views
				sections = { "scopes", "watches", "exceptions", "breakpoints", "threads", "repl", "console" },
				-- Must be one of the sections declared above
				default_section = "scopes",
				-- Configure each section individually
				base_sections = {
					-- Labels can be set dynamically with functions
					-- Each function receives the window's width and the current section as arguments
					scopes = { label = "Scopes", keymap = "S" },
					breakpoints = { label = "Breakpoints", keymap = "B" },
					exceptions = { label = "Exceptions", keymap = "E" },
					watches = { label = "Watches", keymap = "W" },
					threads = { label = "Threads", keymap = "T" },
					repl = { label = "REPL", keymap = "R" },
					sessions = { label = "Sessions", keymap = "K" },
					console = { label = "Console", keymap = "C" },
				},
				controls = {
					enabled = true,
					position = "right",
					buttons = {
						"play",
						"step_into",
						"step_over",
						"step_out",
						"step_back",
						"run_last",
						"terminate",
						"disconnect",
					},
				},
			},
			-- Auto open when a session is started and auto close when all sessions finish
			-- Alternatively, can be a string:
			-- - "keep_terminal": as above, but keeps the terminal when the session finishes
			-- - "open_term": open the terminal when starting a new session, nothing else
			auto_toggle = true,
		})
	end
	return dap_view_instance
end

vim.keymap.set({ "n", "v" }, "<leader>dw", function()
	get_dap_view().add_expr()
end)
