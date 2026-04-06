return {
  'NvChad/nvim-colorizer.lua',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    filetypes = { 'css', 'html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'svelte', 'vue', 'scss', 'less', 'lua' },
    user_default_options = {
      RGB = true,
      RRGGBB = true,
      RRGGBBAA = true,
      rgb_fn = true,
      hsl_fn = true,
      names = true,
      css = true,
      tailwind = true,
    },
  },
}
