return {{
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make',
			cond = function()
				return vim.fn.executable('make') == 1
			end,
		},
	},
	config = function()
		pcall(require('telescope').load_extensions, 'fnf');
		
		local builtin = require('telescope.builtin');
		vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' });
		vim.keymap.set('n', '<leader>/', function() 
			builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
				winblend = 10,
				previewer = false,
			}));
		end, { desc = '[/] Fuzzy find in current buffer' });

		vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = '[fr] Find recent files' });
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[ff] Find files' });
		vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[fw] Find word' });
		vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = '[gf] Git files' });

		vim.keymap.set('n', '<leader>rs', builtin.resume, { desc = '[rs] Resume search' });

		vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[sh] Search help' });
	end,
	lazy = false,
}};
