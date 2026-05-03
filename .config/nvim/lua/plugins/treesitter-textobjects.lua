return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	event = "VeryLazy",
	config = function()
		require("nvim-treesitter-textobjects").setup({
			move = {
				enable = true,
				set_jumps = true,
			},
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = { query = "@function.outer", desc = "Select outer function" },
					["if"] = { query = "@function.inner", desc = "Select inner function" },
					["ac"] = { query = "@class.outer", desc = "Select outer class" },
					["ic"] = { query = "@class.inner", desc = "Select inner class" },
					["aa"] = { query = "@parameter.outer", desc = "Select outer parameter" },
					["ia"] = { query = "@parameter.inner", desc = "Select inner parameter" },
				},
			},
		})

		local move = require("nvim-treesitter-textobjects.move")

		local keymaps = {
			["]f"] = { query = "@function.outer", method = "goto_next_start", desc = "Next Function Start" },
			["]F"] = { query = "@function.outer", method = "goto_next_end", desc = "Next Function End" },
			["]c"] = { query = "@class.outer", method = "goto_next_start", desc = "Next Class Start" },
			["]C"] = { query = "@class.outer", method = "goto_next_end", desc = "Next Class End" },
			["]a"] = { query = "@parameter.inner", method = "goto_next_start", desc = "Next Parameter Start" },
			["]A"] = { query = "@parameter.inner", method = "goto_next_end", desc = "Next Parameter End" },
			["[f"] = { query = "@function.outer", method = "goto_previous_start", desc = "Prev Function Start" },
			["[F"] = { query = "@function.outer", method = "goto_previous_end", desc = "Prev Function End" },
			["[c"] = { query = "@class.outer", method = "goto_previous_start", desc = "Prev Class Start" },
			["[C"] = { query = "@class.outer", method = "goto_previous_end", desc = "Prev Class End" },
			["[a"] = { query = "@parameter.inner", method = "goto_previous_start", desc = "Prev Parameter Start" },
			["[A"] = { query = "@parameter.inner", method = "goto_previous_end", desc = "Prev Parameter End" },
		}

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(ev)
				for key, spec in pairs(keymaps) do
					vim.keymap.set({ "n", "x", "o" }, key, function()
						move[spec.method](spec.query, "textobjects")
					end, { buffer = ev.buf, desc = spec.desc, silent = true })
				end
			end,
		})
	end,
}
