return {
	"mfussenegger/nvim-dap-python",
	dependencies = {
		'rcarriga/nvim-dap-ui'
	},
	config = function()
		require('dap-python').setup('python3')
	end
}
