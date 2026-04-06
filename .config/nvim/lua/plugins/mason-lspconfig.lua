return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = { "williamboman/mason.nvim" },
	opts = {
		ensure_installed = {
			"lua_ls",
			"pyright",
			"ts_ls",
			"bashls",
			"jsonls",
			"marksman",
			"dockerls",
			"docker_compose_language_service",
			"gopls",
			"prismals",
			"ruff",
			"tailwindcss",
			"tsgo",
			"tinymist",
			"biome",
		},
		automatic_installation = true,
	},
}
