local tools = {
	python = {
		lint = { "ruff" },
	},

	dockerfile = {
		lint = { "hadolint" },
	},

	typescript = {
		lint = { "oxlint" },
	},
}

local linters_by_ft = (function()
	local out = {}
	for ft, ft_tools in pairs(tools) do
		if ft_tools.lint then
			out[ft] = ft_tools.lint
		end
	end
	return out
end)()

return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = linters_by_ft
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}