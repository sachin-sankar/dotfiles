return {
	"dmtrKovalenko/fff.nvim",
	build = function()
		require("fff.download").download_or_build_binary()
	end,
	opts = {
		layout = {
			height = 0.8,
			width = 0.8,
			preview_position = "right",
			preview_size = 0.5,
		},
		preview = {
			enabled = true,
		},
		frecency = {
			enabled = true,
		},
		history = {
			enabled = true,
		},
	},
	lazy = false,
	keys = {
		{
			"ff",
			function()
				require("fff").find_files()
			end,
			desc = "Find files",
		},
		{
			"fg",
			function()
				require("fff").live_grep()
			end,
			desc = "Live grep",
		},
		{
			"fz",
			function()
				require("fff").live_grep({
					grep = {
						modes = { "fuzzy", "plain" },
					},
				})
			end,
			desc = "Live fuzzy grep",
		},
		{
			"fc",
			function()
				require("fff").live_grep({ query = vim.fn.expand("<cword>") })
			end,
			desc = "Search current word",
		},
		{
			"<leader><space>",
			function()
				require("fff").find_files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>/",
			function()
				require("fff").live_grep()
			end,
			desc = "Grep",
		},
	},
}
