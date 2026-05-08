return {
	"williamboman/mason-lspconfig.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local servers = require("lsp.servers")
		require("mason-lspconfig").setup({
			ensure_installed = vim.list_extend({}, vim.tbl_keys(servers)),
			automatic_installation = true,
		})
	end,
}