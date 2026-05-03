return {
	"smjonas/inc-rename.nvim",
	keys = {
		{
			"<leader>cn",
			function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end,
			expr = true,
			desc = "Incremental Rename",
		},
	},
}
