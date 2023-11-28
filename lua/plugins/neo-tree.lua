return { {
	'nvim-neo-tree/neo-tree.nvim',
	lazy = false,
	opts = {
		closes_if_last_window = true,
		window = {
			position = 'left',
			width = 30,
			mappings = {},
		},
		filesystem = {
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_by_name = {
				},
				never_show = {
					'.DS_Store',
				},
			},
			hijack_netrw_behavior = 'open_default',
			follow_current_file = {
				enabled = true,
			},
			window = { mappings = {} },
		},
	},
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons',
		'MunifTanjim/nui.nvim',
		'3rd/image.nvim',
	},
	keys = {
		{ '<leader>ex', '<cmd>Neotree toggle<cr>', desc = '[ex] Toggle explorer' },
	},
} };
