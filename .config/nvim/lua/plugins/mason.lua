return {
	"mason-org/mason.nvim",
	cmd = "Mason",
	opts = {
		ensure_installed = {
			"hadolint",
			"goimports",
			"gofumpt",
			"gomodifytags",
			"impl",
			"golangci-lint",
			"markdownlint-cli2",
			"markdown-toc",
		},
	},
}
