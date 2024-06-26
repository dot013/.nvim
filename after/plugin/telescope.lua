local telescope = require("telescope")
local builtin = require("telescope.builtin")

local nmap = function(key, func, desc)
	if desc then
		desc = "[" .. key .. "] " .. desc
	end
	vim.keymap.set("n", key, func, { desc = desc })
end

nmap("<leader><space>", builtin.buffers, "Find existing buffers")
nmap("/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		windblend = 10,
		previewer = false,
	}))
end, "Find in current buffer")

nmap("fr", builtin.oldfiles, "Find recent files")
nmap("ff", builtin.find_files, "Find files")
nmap("fw", builtin.grep_string, "Find word")
nmap("gf", builtin.git_files, "Git files")
nmap("rs", builtin.resume, "Resume search")

telescope.setup({})

pcall(require("telescope").load_extensions, "fnf")
