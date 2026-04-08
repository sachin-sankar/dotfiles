return {
  'Pocco81/auto-save.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    enabled = true,
    execution_message = {
      message = function() -- message to print on save
        return ""
      end,
      dim = 0.18,               -- dim the color of `message`
      cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
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
