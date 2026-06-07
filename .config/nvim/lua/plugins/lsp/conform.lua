return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
			lsp_fallback = true,
		},
		formatters_by_ft = require("lsp.formatters"),
	},
}
