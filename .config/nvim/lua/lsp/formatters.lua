return {
	lua = { "stylua" },
	python = { "ruff" },
	go = { "goimports", "gofumpt" },
	sh = { "shfmt" },
	typst = { "typstyle", opts = { lsp_format = "prefer" } },
	typescript = { "oxfmt" },
}