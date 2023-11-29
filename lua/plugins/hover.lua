return { {
	'lewis6991/hover.nvim',
	config = function()
		require('hover').setup({
			init = function()
				require('hover.providers.lsp');
			end,
			preview_opts = {
				border = 'single',
			},
			preview_window = false,
			title = true,
			mouse_providers = {
				'LSP',
			},
			mouse_delay = 1000,
		})

		vim.keymap.set('n', 'K', require('hover').hover, { desc = '[K] Hover' });
		vim.keymap.set('n', 'sK', require('hover').hover_select, { desc = '[K] Hover select' });

		-- Mouse support
		vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = '[MouseMove] Hover mouse' });
		vim.o.mousemoveevent = true;
	end,
} }
