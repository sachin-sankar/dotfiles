return {
	lua = { "stylua" },
	python = { "ruff_format", "ruff_organize_imports" },
	go = { "goimports", "gofumpt" },
	sh = { "shfmt" },
	typst = { "typstyle", opts = { lsp_format = "prefer" } },
	typescript = { "oxfmt" },
	yaml = { "oxfmt" },
}
