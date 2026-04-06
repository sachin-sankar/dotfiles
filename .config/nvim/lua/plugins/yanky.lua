return {
  'gbprod/yanky.nvim',
  dependencies = {
    'folke/snacks.nvim',
    'kkharji/sqlite.lua',
  },
  opts = {
    ring = {
      storage = 'sqlite',
    },
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 150,
    },
  },
  keys = {
    { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yank Text' },
    { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put Text After Cursor' },
    { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put Text Before Cursor' },
    { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }, desc = 'Put Text After Selection' },
    { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }, desc = 'Put Text Before Selection' },
    { '[y', '<Plug>(YankyCycleForward)', desc = 'Cycle Forward Through Yank History' },
    { ']y', '<Plug>(YankyCycleBackward)', desc = 'Cycle Backward Through Yank History' },
    { '<leader>sy', function() Snacks.picker.yanky() end, desc = 'Yank History' },
  },
}
