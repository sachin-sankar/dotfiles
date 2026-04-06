return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local bufferline = require('bufferline')
    bufferline.setup {
      options = {
        mode = 'buffers',
        style_preset = bufferline.style_preset.no_italic,
        separator_style = 'thin',
        always_show_bufferline = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level)
          local icon = level:match('error') and ' ' or ' '
          return ' ' .. icon .. count
        end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Explorer',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
        custom_areas = {
          right = function()
            local result = {}
            local seve = vim.diagnostic.severity
            local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
            local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
            local info = #vim.diagnostic.get(0, { severity = seve.INFO })
            local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

            if error ~= 0 then
              table.insert(result, { text = '  ' .. error, link = 'DiagnosticError' })
            end
            if warning ~= 0 then
              table.insert(result, { text = '  ' .. warning, link = 'DiagnosticWarn' })
            end
            if hint ~= 0 then
              table.insert(result, { text = '  ' .. hint, link = 'DiagnosticHint' })
            end
            if info ~= 0 then
              table.insert(result, { text = '  ' .. info, link = 'DiagnosticInfo' })
            end
            return result
          end,
        },
      },
    }
  end,
  keys = {
    { '<leader>bn', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '<leader>bp', '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous Buffer' },
    { '<leader>bc', '<cmd>BufferLinePick<cr>', desc = 'Pick Buffer' },
    { '<leader>bse', '<cmd>BufferLineSortByExtension<cr>', desc = 'Sort by Extension' },
    { '<leader>bsd', '<cmd>BufferLineSortByDirectory<cr>', desc = 'Sort by Directory' },
    { '<leader>bcl', '<cmd>BufferLineCloseLeft<cr>', desc = 'Close Buffers to Left' },
    { '<leader>bcr', '<cmd>BufferLineCloseRight<cr>', desc = 'Close Buffers to Right' },
    { '<leader>bco', '<cmd>BufferLineCloseOthers<cr>', desc = 'Close Other Buffers' },
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Previous Buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
  },
}
