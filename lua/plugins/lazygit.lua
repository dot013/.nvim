return { {
	'kdheepak/lazygit.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	keys = {
		{ '<leader>gg', '<cmd>:LazyGit<cr>', desc = '[gg] Open lazygit' },
	},
} };
