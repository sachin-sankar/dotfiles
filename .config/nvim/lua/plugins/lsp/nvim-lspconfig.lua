return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local servers = require("lsp.servers")

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

		for server, config in pairs(servers) do
			vim.lsp.config(server, config)
			vim.lsp.enable(server)
		end

		Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
			if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buftype == "" then
				return vim.lsp.inlay_hint.enable(false, { bufnr = buffer })
			end
		end)
	end,
}