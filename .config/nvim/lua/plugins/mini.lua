return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.surround').setup()
      require('mini.pairs').setup()
      require('mini.bracketed').setup()
      require('mini.pick').setup()
      require('mini.icons').setup()
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
