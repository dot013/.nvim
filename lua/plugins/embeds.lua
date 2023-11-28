return { {
	'kdheepak/lazygit.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	keys = {
		{ '<leader>gg', '<cmd>:LazyGit<cr>', desc = '[gg] Go lazygit' },
	},
}, {
	'theniceboy/joshuto.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	keys = {
		{ '<leader>gj', '<cmd>:Joshuto<cr>', desc = '[gj] Go joshuto' },
	},
} };
