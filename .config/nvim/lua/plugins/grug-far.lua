return {
  'MagicDuck/grug-far.nvim',
  config = function()
    require('grug-far').setup {
      icons = {
        enabled = true,
      },
    }
  end,
  keys = {
    { '<leader>sr', function() require('grug-far').open() end, desc = 'Search and Replace' },
  },
}
