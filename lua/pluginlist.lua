return {
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 1000,
		config = function()
			require('catppuccin').setup({
				flavour = 'mocha',
				transparent_background = true,
			});
			vim.cmd.colorscheme('catppuccin');
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		opts = {
			options = {
				icons_enabled = false,
				theme = 'catppuccin',
				component_separators = '|',
				section_separators = '',
			},
		},
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		opts = {},
	},
	{ 'j-hui/fidget.nvim', },
	{ "williamboman/mason.nvim", },
	{ "williamboman/mason-lspconfig.nvim", },
	{ "neovim/nvim-lspconfig", },
	{ 'folke/which-key.nvim', },
	{ 'folke/neodev.nvim', },
	{ 'nvim-tree/nvim-web-devicons', },
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '+' },
				topdelete = { text = '-' },
				changedelete = { text = '~' },
			},
			on_attach = function (bufnr)
				vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' });
				local gs = package.loaded.gitsigns;
				vim.keymap.set({ 'n', 'v' }, ']c', function()
					if vim.wo.diff then
						return ']c';
					end
					vim.schedule(function ()
						gs.next_hunk()
					end);
					return '<Ignore>';
				end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' });
				vim.keymap.set({ 'n', 'v' }, '[c', function()
					if vim.wo.diff then
						return '[c';
					end
					vim.schedule(function ()
						gs.next_hunk()
					end);
					return '<Ignore>';
				end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' });
			end,
		},
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'rafamadriz/friendly-snippets',
			'hrsh7th/cmp-nvim-lsp',
			'onsails/lspkind.nvim',
		},
	},
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fnf-native.nvim',
				build = 'make',
				cond = function ()
					return vim.fn.executable('make') == 1
				end
			},
		},
	},
};
