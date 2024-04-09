local on_attach = function(_, bufnr)
	local bmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. "[" .. keys .. "] " .. desc
		end
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	bmap("<leader>r", vim.lsp.buf.rename, "Rename")
	bmap("<leader>a", vim.lsp.buf.code_action, "Code action")

	bmap("gd", vim.lsp.buf.definition, "Goto Definition")
	bmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
	bmap("gI", vim.lsp.buf.implementation, "Goto Implementation")
	bmap("<leader>D", vim.lsp.buf.type_definition, "Type Definition")

	-- bmap('K', vim.lsp.buf.hover, 'Hover docs');
	bmap("<C-k>", vim.lsp.buf.signature_help, "Signature docs")

	-- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
	-- vim.lsp.buf.format()
	-- end, {});

	-- local format_is_enabled = true;
	-- vim.api.nvim_buf_create_user_command('AutoFormatToggle', function()
	-- format_is_enabled = not format_is_enabled;
	-- print('Setting autoformatting to:' .. tostring(format_is_enabled));
	-- end, {});
end

require("which-key").register({
	["<leader>c"] = { name = "[c] Code", _ = "which_key_ignore" },
	["<leader>d"] = { name = "[d] Document", _ = "which_key_ignore" },
	["<leader>g"] = { name = "[g] Git", _ = "which_key_ignore" },
	["<leader>h"] = { name = "[h] More Git", _ = "which_key_ignore" },
	["<leader>r"] = { name = "[r] Rename", _ = "which_key_ignore" },
	["<leader>s"] = { name = "[s] Search", _ = "which_key_ignore" },
	["<leader>w"] = { name = "[w] Workspace", _ = "which_key_ignore" },
})

require("hover").setup({
	init = function()
		require("hover.providers.lsp")
	end,
	preview_opts = {
		border = "single",
	},
	preview_window = false,
	title = true,
	mouse_providers = { "LSP" },
	mouse_delay = 1000,
})

vim.keymap.set("n", "K", require("hover").hover, { desc = "[K] Hover" })
vim.keymap.set("n", "sK", require("hover").hover_select, { desc = "[K] Hover select" })

-- Mouse support
vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "[MouseMove] Hover mouse" })
vim.o.mousemoveevent = true

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason").setup()
require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,
	["lua_ls"] = function()
		require("neodev").setup()
		require("lspconfig").lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			Lua = {
				workspace = { checkThirdParty = false },
				telemetry = { enable = false },
			},
		})
	end,
	["html"] = function()
		require("lspconfig").html.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "html", "svg", "xml" },
		})
	end,
})

local formatter_util = require("formatter.util")
vim.api.nvim_create_augroup("__formatter__", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})
require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
			function()
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						formatter_util.escape_path(formatter_util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},
		nix = {
			require("formatter.filetypes.nix").alejandra,
		},
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})
