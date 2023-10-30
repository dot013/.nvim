-- Plugins related to the colorscheme and Neovim appearence
return { {
	'shaunsingh/nord.nvim',
	priority = 1000,
	config = function()
		vim.cmd.colorscheme('nord');
		vim.g.nord_disable_background = true;

		require('nord').set();
	end,
}, {
	'nvim-lualine/lualine.nvim',
	opts = {
		options = {
			icons_enabled = false,
			theme = 'nord',
			component_separators = '|',
			section_separators = '',
		},
	},
}, {
	'lukas-reineke/indent-blankline.nvim',
	main = 'ibl',
	opts = {},
} };
