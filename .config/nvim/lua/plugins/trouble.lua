return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    modes = {
      lsp = {
        win = { position = 'bottom' },
      },
    },
  },
  keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics' },
    { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics' },
    { '<leader>cs', '<cmd>Trouble symbols toggle<cr>', desc = 'Symbols' },
    { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List' },
    { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List' },
  },
}
