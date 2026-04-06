return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('fzf-lua').setup {
      defaults = {
        file_icons = true,
        git_icons = true,
      },
    }
  end,
}
