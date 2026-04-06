return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      python = { 'ruff' },
      javascript = { 'biome' },
      javascriptreact = { 'biome' },
      typescript = { 'biome' },
      typescriptreact = { 'biome' },
      dockerfile = { 'hadolint' },
      markdown = { 'markdownlint-cli2' },
    }

    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
