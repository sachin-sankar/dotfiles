return {
  'tiagovla/tokyodark.nvim',
  opts = {
    -- custom options here
  },
  config = function(_, opts)
    require('tokyodark').setup(opts) -- calling setup is optional
    vim.cmd [[colorscheme tokyodark]]
  end,
}
-- vim: ts=2 sts=2 sw=2 et
