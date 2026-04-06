return {
  'Pocco81/auto-save.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    enabled = true,
    execution_message = {
      message = function(time)
        return ('AutoSave: saved at %s'):format(time)
      end,
    },
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
