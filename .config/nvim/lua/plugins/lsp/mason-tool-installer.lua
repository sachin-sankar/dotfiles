return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
	},
	config = function()
		local servers = require("lsp.servers")
		local formatters = require("lsp.formatters")
		local linters = require("lsp.linters")

		local fmt_tools = {}
		for _, v in pairs(formatters) do
			if type(v) == "table" then
				for _, name in ipairs(v) do
					fmt_tools[#fmt_tools + 1] = name
				end
			end
		end

		local lint_tools = {}
		for _, v in pairs(linters) do
			for _, name in ipairs(v) do
				lint_tools[#lint_tools + 1] = name
			end
		end

		local ensure_installed = vim.list_extend(vim.tbl_keys(servers), fmt_tools)
		vim.list_extend(ensure_installed, lint_tools)

		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
			run_on_start = true,
		})
	end,
}

