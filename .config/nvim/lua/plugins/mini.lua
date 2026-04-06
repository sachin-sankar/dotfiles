return {
	{
		"nvim-mini/mini.move",
		event = "VeryLazy",
		opts = {},
	},
	{
		"nvim-mini/mini.pairs",
		event = "VeryLazy",
		opts = {},
	},
	{
		"nvim-mini/mini.ai",
		event = "VeryLazy",
		opts = {},
	},
	{
		"nvim-mini/mini.icons",
		lazy = true,
		opts = {
			file = {
				[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
				["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
				[".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
			},
			filetype = {
				dotenv = { glyph = "", hl = "MiniIconsYellow" },
				gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
			},
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	{
		"nvim-mini/mini.surround",
		event = "VeryLazy",
		opts = {
			mappings = {
				add = "sa",
				delete = "sd",
				replace = "sr",
				find = "sf",
				find_left = "sF",
				highlight = "sh",
				update_n_lines = "sn",
			},
		},
	},
}
