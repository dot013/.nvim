vim.g.mapleader = ' ';
vim.g.maplocalleader = ' ';

vim.g.loaded_netrw = 1;
vim.g.loaded_netrwPlugin = 1;

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim';
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath,
	});
end
vim.opt.rtp:prepend(lazypath);

require('lazy').setup('plugins');

-- Custom keybindings
require('keybindings');

vim.wo.number = true;
vim.o.mouse = true;

-- True colors
vim.o.termguicolors = true;

-- Enable spell checking by default
vim.o.spell = true;

-- Set relative line numbers
vim.o.number = true;
vim.o.relativenumber = true;
vim.o.signcolumn = 'number';

-- Set indentation
vim.o.noexpandtab = true;
vim.o.tabstop = 4;
vim.o.softtabstop = 4;
vim.o.shiftwidth = 4;
-- vim.o.expandtab = 4;
vim.o.breakindent = true;

-- Scroll off
vim.o.scrolloff = 10;

-- Line length column
vim.o.colorcolumn = '80';

-- Sync NeoVim and OS clipboards
vim.o.clipboard = 'unnamedplus';

-- Highlight search
vim.o.hlsearch = false;
vim.o.incsearch = true;

-- Save undo history
vim.o.undofile = true;

-- Case-insensitive search, unless \C or capital in search
vim.o.ignorecase = true;
vim.o.smartcase = true;

vim.wo.signcolumn = 'yes';

vim.o.updatetime = 250;
vim.o.timeoutlen = 300;

vim.o.completeopt = 'menuone,noselect';

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true });

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true });
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true });

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true });
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank();
	end,
	group = highlight_group,
	pattern = '*',
});
