local tools = {
	lua = {
		lsp = { "lua_ls" },
		lsp_config = {
			lua_ls = {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						codeLens = { enable = true },
						completion = { callSnippet = "Replace" },
						hint = {
							enable = true,
							setType = false,
							paramType = true,
							paramName = "Disable",
							semicolon = "Disable",
							arrayIndex = "Disable",
						},
					},
				},
			},
		},
		fmt = { "stylua" },
	},

	python = {
		lsp = { "pyrefly", "ruff" },
		lsp_config = {
			ruff = {
				cmd_env = { RUFF_TRACE = "messages" },
				init_options = { settings = { logLevel = "error" } },
			},
		},
		lint = { "ruff" },
		fmt = { "ruff" },
	},

	go = {
		lsp = { "gopls" },
		fmt = { "goimports", "gofumpt" },
	},

	sh = {
		lsp = { "bashls" },
		fmt = { "shfmt" },
	},

	typst = {
		lsp = { "tinymist" },
		lsp_config = {
			tinymist = {
				single_file_support = true,
				settings = { formatterMode = "typstyle" },
			},
		},
		fmt = { "typstyle" },
		fmt_opts = { lsp_format = "prefer" },
	},

	json = {
		lsp = { "jsonls" },
	},

	dockerfile = {
		lsp = { "dockerls" },
		lint = { "hadolint" },
	},

	yaml = {
		lsp = { "docker_compose_language_service" },
	},

	typescript = {
		lsp = { "ts_ls", "vtsls", "tsgo" },
		lsp_config = {
			oxlint = { settings = { fixKind = "all" } },
		},
		lint = { "oxlint" },
		fmt = { "oxfmt" },
	},

	css = {
		lsp = { "tailwindcss" },
		lsp_config = {
			tailwindcss = {
				filetypes = vim.tbl_filter(function(ft)
					return ft ~= "markdown"
				end, (vim.lsp.config.tailwindcss or {}).filetypes or {}),
				settings = {
					tailwindCSS = {
						includeLanguages = {
							elixir = "html-eex",
							eelixir = "html-eex",
							heex = "html-eex",
						},
					},
				},
			},
		},
	},
}

local lsp_servers = (function()
	local seen, list = {}, {}
	for _, ft_tools in pairs(tools) do
		for _, server in ipairs(ft_tools.lsp or {}) do
			if not seen[server] then
				seen[server] = true
				list[#list + 1] = server
			end
		end
	end
	return list
end)()

local lsp_configs = (function()
	local out = {}
	for _, ft_tools in pairs(tools) do
		for server, config in pairs(ft_tools.lsp_config or {}) do
			out[server] = vim.tbl_deep_extend("force", out[server] or {}, config)
		end
	end
	return out
end)()

local formatters_by_ft = (function()
	local out = {}
	for ft, ft_tools in pairs(tools) do
		if ft_tools.fmt then
			local entry = vim.list_extend({}, ft_tools.fmt)
			for k, v in pairs(ft_tools.fmt_opts or {}) do
				entry[k] = v
			end
			out[ft] = entry
		end
	end
	return out
end)()

local linters_by_ft = (function()
	local out = {}
	for ft, ft_tools in pairs(tools) do
		if ft_tools.lint then
			out[ft] = ft_tools.lint
		end
	end
	return out
end)()

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			capabilities.workspace = {
				fileOperations = {
					didRename = true,
					willRename = true,
				},
			}

			vim.diagnostic.config({
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
				},
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
					},
				},
				virtual_lines = { current_line = true },
			})

			vim.lsp.config("*", { capabilities = capabilities })

			for server, config in pairs(lsp_configs) do
				vim.lsp.config(server, config)
			end

			Snacks.util.lsp.on({ name = "gopls" }, function(_, client)
				if not client.server_capabilities.semanticTokensProvider then
					local semantic = client.config.capabilities.textDocument.semanticTokens
					client.server_capabilities.semanticTokensProvider = {
						full = true,
						legend = {
							tokenTypes = semantic.tokenTypes,
							tokenModifiers = semantic.tokenModifiers,
						},
						range = true,
					}
				end
			end)

			Snacks.util.lsp.on({ name = "ruff" }, function(_, client)
				client.server_capabilities.hoverProvider = false
			end)

			for _, server in ipairs(lsp_servers) do
				vim.lsp.enable(server)
			end

			Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
				if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buftype == "" then
					return vim.lsp.inlay_hint.enable(false, { bufnr = buffer })
				end
			end)
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = formatters_by_ft,
		},
	},

	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = linters_by_ft
			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
