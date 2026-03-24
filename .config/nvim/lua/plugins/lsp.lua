return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        typos_lsp = {
          -- optional: tweak severity (default is WARN)
          filetypes = { "text", "plaintex", "typst", "gitcommit", "markdown" },
          init_options = {
            diagnosticSeverity = "Warning",
          },
        },
      },
    },
  },
}
