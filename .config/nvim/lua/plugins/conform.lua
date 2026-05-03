return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff" },
			go = { "goimports", "gofumpt" },
			sh = { "shfmt" },
			typst = { "typstyle", lsp_format = "prefer" },
		},
	},
}
