return {
  'Pocco81/auto-save.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    enabled = true,
    conditions = {
      exists = true,
      filename_is_not = {},
      filetype_is_not = {},
      modifiable = true,
    },
    write_all_buffers = false,
    debounce_delay = 135,
  },
}
