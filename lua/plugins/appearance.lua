-- Plugins related to the colorscheme and Neovim appearence
return { --[[ {
	'shaunsingh/nord.nvim',
	priority = 1000,
	config = function()
		vim.cmd.colorscheme('nord');
		if not vim.g.startted_by_firenvim then
			vim.g.nord_disable_background = true;
		else
			vim.g.nord_disable_background = false;
		end

		require('nord').set();
	end,
}, ]] --
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 100,
		config = function()
			require('catppuccin').setup({
				flavour = 'mocha',
				transparent_background = true,
			});
			vim.cmd.colorscheme('catppuccin');
		end
	}, {
	'nvim-lualine/lualine.nvim',
	opts = {
		options = {
			icons_enabled = false,
			theme = 'catppuccin',
			component_separators = '|',
			section_separators = '',
		},
	},
}, {
	'lukas-reineke/indent-blankline.nvim',
	main = 'ibl',
	opts = {},
} };
