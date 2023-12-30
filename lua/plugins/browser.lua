return { {
	'glacambre/firenvim',
	lazy = not vim.g.started_by_firenvim,
	build = function()
		vim.g.firenvim_config = {
			localSettings = {
				['.*'] = {
					cmdline = 'neovim',
					content = 'text',
					priority = 0,
					selector = 'textare',
					takeover = 'never',
				}
			}
		}

		vim.fn['firenvim#install'](0);
	end,
} }
