-- Plugins related to LSP
return { {
	'neovim/nvim-lspconfig',
	dependencies = {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		{ 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
		'folke/neodev.nvim',
	},
	config = function()
		-- Kickstart autoformat on save ---------
		local format_is_enabled = true;
		vim.api.nvim_create_user_command('KickstartFormatToggle', function()
			format_is_enabled = not format_is_enabled;
			print('Setting autoformatting to:' .. tostring(format_is_enabled))
		end, {});

		local _augroups = {};
		local get_augroup = function(client)
			if not _augroups[client.id] then
				local group_name = 'kickstart-lsp-format-' .. client.name;
				local id = vim.api.nvim_create_augroup(group_name, { clear = true });
				_augroups[client.id] = id
			end
			return _augroups[client.id];
		end

		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
			callback = function(args)
				local client_id = args.data.client_id;
				local client = vim.lsp.get_client_by_id(client_id);
				local bufnr = args.buf;

				if not client.server_capabilities.documentFormattingProvider then
					return;
				end

				if client.name == 'tsserver' then
					return;
				end

				vim.api.nvim_create_autocmd('BufWritePre', {
					group = get_augroup(client),
					buffer = bufnr,
					callback = function()
						if not format_is_enabled then
							return
						end

						vim.lsp.buf.format({
							async = false,
							filter = function(c)
								return c.id == client.id
							end,
						});
					end,
				});
			end,
		});

		-- CONFIGURE LSP	
		-- Runs on_attach when an LSP connects to a particular buffer
		local on_attach = function(_, bufnr)
			local nmap = function(keys, func, desc)
				if desc then
					desc = 'LSP: ' .. desc
				end
				vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc });
			end

			nmap('<leader>rn', vim.lsp.buf.rename, '[rn] Rename');
			nmap('<leader>ca', vim.lsp.buf.code_action, '[ca] Code Action');

			nmap('<leader>gd', require('telescope.builtin').lsp_definitions, '[gd] Goto Definition');
			nmap('<leader>gD', require('telescope.builtin').lsp_declaration, '[gD] Goto Declaration');
			nmap('<leader>gr', require('telescope.builtin').lsp_references, '[gr] Goto References');
			nmap('<leader>gI', require('telescope.builtin').lsp_implementations, '[gI] Goto Implementations');
			nmap('<leader>td', require('telescope.builtin').lsp_type_definitions, '[td] Type Definition');

			nmap('K', vim.lsp.buf.hover, 'Hover docs');
			nmap('<C-s>', vim.lsp.buf.signature_help, 'Signature docs');

			vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
				vim.lsp.buf.format()
			end, { desc = 'Format current buffer with LSP' });
		end

		-- document existing key chains
		require('which-key').register({
			['<leader>c'] = { name = '[c] Code', _ = 'which_key_ignore' },
			['<leader>d'] = { name = '[d] Document', _ = 'which_key_ignore' },
			['<leader>g'] = { name = '[g] Git', _ = 'which_key_ignore' },
			['<leader>h'] = { name = '[h] More Git', _ = 'which_key_ignore' },
			['<leader>r'] = { name = '[r] Rename', _ = 'which_key_ignore' },
			['<leader>s'] = { name = '[s] Search', _ = 'which_key_ignore' },
			['<leader>w'] = { name = '[w] Workspace', _ = 'which_key_ignore' },
		});

		require('mason').setup();
		require('mason-lspconfig').setup();

		local servers = {
			lua_ls = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				}
			},
			html = {
				filetypes = { 'html', 'svg', 'xml' },
			},
		};

		-- Neovim lua configuraion
		require('neodev').setup()

		local capabilities = vim.lsp.protocol.make_client_capabilities();
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities);

		local mason_lspconfig = require('mason-lspconfig');

		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
			automatic_installation = true,
		});

		mason_lspconfig.setup_handlers({
			function(server_name)
				require('lspconfig')[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server_name],
					filetypes = (servers[server_name] or {}).filetypes,
				});
			end,
		});
	end,
} };
