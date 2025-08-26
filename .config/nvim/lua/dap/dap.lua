return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			'nvim-neotest/nvim-nio',
			'mfussenegger/nvim-dap-python',
		},
	},
	config = function()
		local dap = require('dap')
		vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, {})
		vim.keymap.set('n', '<leader>dc', dap.continue, {})
		vim.keymap.set('n', '<leader>dd', dap.step_over, {})
		vim.keymap.set('n', '<leader>di', dap.step_into, {})
		vim.keymap.set('n', '<leader>do', dap.step_out, {})
		vim.keymap.set('n', '<leader>dC', dap.terminate, {})
		vim.keymap.set('n', '<leader>dt', dap.run_to_cursor, {})
	end,
}
