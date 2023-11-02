return { {
	'romgrk/barbar.nvim',
	dependencies = {
		'lewis6991/gitsigns.nvim',
		'nvim-tree/nvim-web-devicons',
	},
	init = function() vim.g.barbar_auto_setup = false end,
	keys = {
		{ '<leader>1', '<cmd>BufferGoto 1<cr>',   desc = '[1] Goto tab 1',        noremap = true, silent = true },
		{ '<leader>2', '<cmd>BufferGoto 2<cr>',   desc = '[2] Goto tab 2',        noremap = true, silent = true },
		{ '<leader>3', '<cmd>BufferGoto 3<cr>',   desc = '[3] Goto tab 3',        noremap = true, silent = true },
		{ '<leader>4', '<cmd>BufferGoto 4<cr>',   desc = '[4] Goto tab 4',        noremap = true, silent = true },
		{ '<leader>5', '<cmd>BufferGoto 5<cr>',   desc = '[5] Goto tab 5',        noremap = true, silent = true },
		{ '<leader>6', '<cmd>BufferGoto 6<cr>',   desc = '[6] Goto tab 6',        noremap = true, silent = true },
		{ '<leader>7', '<cmd>BufferGoto 7<cr>',   desc = '[7] Goto tab 7',        noremap = true, silent = true },
		{ '<leader>8', '<cmd>BufferGoto 8<cr>',   desc = '[8] Goto tab 8',        noremap = true, silent = true },
		{ '<leader>9', '<cmd>BufferGoto 9<cr>',   desc = '[9] Goto tab 9',        noremap = true, silent = true },
		{ '<leader>0', '<cmd>BufferLast<cr>',     desc = '[0] Goto last tab',     noremap = true, silent = true },
		{ '.',         '<cmd>BufferNext<cr>',     desc = '[.] Goto next tab',     noremap = true, silent = true },
		{ ',',         '<cmd>BufferPrevious<cr>', desc = '[,] Goto previous tab', noremap = true, silent = true },
	},
	opts = {},
	version = '^1.0.0',
} };
