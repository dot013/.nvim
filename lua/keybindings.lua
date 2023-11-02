-- Move when highlithed
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv");
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv");

-- Make cursor stay in place when using J
vim.keymap.set('n', 'J', 'mzJ`z');

-- Make cursor stay in the middle when jumping
-- with ctrl+d and ctrl+u
vim.keymap.set('n', '<C-d>', '<C-d>zz');
vim.keymap.set('n', '<C-u>', '<C-u>zz');

-- Just to be sure, whatever
vim.keymap.set('n', '<C-c>', '<Esc>');

-- Don't press Q
vim.keymap.set('n', 'Q', '<nop>');

-- Delete to the void
vim.keymap.set('n', '<leader>d', '\"_d');
vim.keymap.set('v', '<leader>d', '\"_d');

-- Replace current word in entire file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Turn file into a linux executable
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true });

-- Thank you ThePrimeagen
