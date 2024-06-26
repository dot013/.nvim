local map = function(mode, keys, func, options)
	if not options then
		options = {}
	end
	if options.desc then
		options.desc = "[" .. keys .. "] " .. options.desc
	end
	vim.keymap.set(mode, keys, func, options)
end

-- Thank you ThePrimeagen ---------------

-- Move when highlighted
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Make cursor stay in place when using J
map("n", "J", "mzJ`z")

-- Make cursor stay in the middle when jumping
-- with ctrl+d and ctrl+u
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Just to be sure, whatever
map("n", "<C-c>", "<Esc>")

-- Don't press Q
map("n", "Q", "<nop>")

-- Delete to the void
map("n", "<leader>d", '"_d')
map("v", "<leader>d", '"_d')

-- Replace current word in entire file
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Turn file into a Linux executable
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Harpoon ------------------------------

local harpoon = require("harpoon")
harpoon:setup()

map("n", "<leader>w", function()
	harpoon:list():append()
end, { desc = "[Harpoon] Append to list" })
map("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "[Harpoon] Open quick menu" })

map("n", "1", function()
	harpoon:list():select(1)
end, { desc = "[Harpoon] Jump to item 1" })
map("n", "2", function()
	harpoon:list():select(2)
end, { desc = "[Harpoon] Jump to item 2" })
map("n", "3", function()
	harpoon:list():select(3)
end, { desc = "[Harpoon] Jump to item 3" })
map("n", "4", function()
	harpoon:list():select(4)
end, { desc = "[Harpoon] Jump to item 4" })

map("n", "<C-p>", function()
	harpoon:list():prev()
end, { desc = "[Harpoon] Jump to previous item" })
map("n", "<C-n>", function()
	harpoon:list():next()
end, { desc = "[Harpoon] Jump to next item" })

-- --------------------------------------

map("n", "<leader>w\\", "<cmd>:vsplit<cr>", { desc = "Splits the window vertically" })
map("n", "<leader>w/", "<cmd>:split<cr>", { desc = "Splits the window horizontally" })

map("n", "<leader>e", "<cmd>:Ex<cr>", { desc = "Explorer" })

map("n", "s=", "z=", { desc = "Suggest spelling correction" })
map("n", "<leader>st", function()
	if vim.o.spell then
		vim.o.spell = false
	else
		vim.o.spell = true
	end
end, { desc = "Toggle spelling correction" })

map("n", "<leader>ee", vim.diagnostic.open_float, { desc = "Open diagnostic" })

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Barbar -------------------------------

map("n", "wc", "<cmd>BufferClose<cr>", { desc = "Buffer close", noremap = true, silent = true })
map("n", "wA", "<cmd>BufferCloseAllButCurrent<cr>", { desc = "Buffer close all", noremap = true, silent = true })
