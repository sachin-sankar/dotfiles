local tools = {
	lua = {
		fmt = { "stylua" },
	},

	python = {
		fmt = { "ruff" },
	},

	go = {
		fmt = { "goimports", "gofumpt" },
	},

	sh = {
		fmt = { "shfmt" },
	},

	typst = {
		fmt = { "typstyle" },
		fmt_opts = { lsp_format = "prefer" },
	},

	typescript = {
		fmt = { "oxfmt" },
	},
}

local formatters_by_ft = (function()
	local out = {}
	for ft, ft_tools in pairs(tools) do
		if ft_tools.fmt then
			local entry = vim.list_extend({}, ft_tools.fmt)
			for k, v in pairs(ft_tools.fmt_opts or {}) do
				entry[k] = v
			end
			out[ft] = entry
		end
	end
	return out
end)()

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters_by_ft = formatters_by_ft,
	},
}