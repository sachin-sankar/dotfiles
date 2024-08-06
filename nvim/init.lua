require("sachin.core")
require("sachin.lazy")

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		if vim.fn.bufname() == "" then
			vim.cmd("silent! Telescope close")
		end
	end,
})
