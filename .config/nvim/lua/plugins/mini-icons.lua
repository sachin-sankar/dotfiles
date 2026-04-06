return {
  'echasnovski/mini.icons',
  lazy = true,
  opts = {
    file = {
      ['.keep'] = { glyph = '󰊢', hl = 'MiniIconsGrey' },
      ['devcontainer.json'] = { glyph = '', hl = 'MiniIconsAzure' },
      ['.go-version'] = { glyph = '', hl = 'MiniIconsBlue' },
    },
    filetype = {
      dotenv = { glyph = '', hl = 'MiniIconsYellow' },
      gotmpl = { glyph = '󰟓', hl = 'MiniIconsGrey' },
    },
  },
  init = function()
    package.preload['nvim-web-devicons'] = function()
      require('mini.icons').mock_nvim_web_devicons()
      return package.loaded['nvim-web-devicons']
    end
  end,
}
