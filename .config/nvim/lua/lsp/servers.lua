return {
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
	ty = {},
	ruff = {
		cmd_env = { RUFF_TRACE = "messages" },
		init_options = { settings = { logLevel = "error" } },
	},
	gopls = {},
	bashls = {},
	tinymist = {
		single_file_support = true,
		settings = { formatterMode = "typstyle" },
	},
	jsonls = {},
	dockerls = {},
	docker_compose_language_service = {},
	vtsls = {},
	tailwindcss = {
		filetypes = {
			"css",
			"scss",
			"less",
			"html",
			"handlebars",
			"twig",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
		},
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
	yamlls = {},
}
