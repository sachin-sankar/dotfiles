return {
	"williamboman/mason.nvim",
	cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
	config = function()
		require("mason").setup()
	end,
}
