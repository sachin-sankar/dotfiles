return {
	"williamboman/mason-lspconfig.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local lsp_servers = {
			"lua_ls",
			"pyrefly",
			"ruff",
			"gopls",
			"bashls",
			"tinymist",
			"jsonls",
			"dockerls",
			"docker_compose_language_service",
			"ts_ls",
			"vtsls",
			"tsgo",
			"tailwindcss",
		}

		require("mason-lspconfig").setup({
			ensure_installed = lsp_servers,
			automatic_installation = true,
		})
	end,
}