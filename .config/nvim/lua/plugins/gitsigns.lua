return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
      untracked = { text = '▎' },
    },
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      ignore_whitespace = false,
    },
    current_line_blame_formatter = '  <author>, <author_time:%Y-%m-%d> - <summary>',
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      map('n', ']h', gitsigns.next_hunk, { desc = 'Next Hunk' })
      map('n', '[h', gitsigns.prev_hunk, { desc = 'Prev Hunk' })
      map('n', '<leader>ghs', gitsigns.stage_hunk, { desc = 'Stage Hunk' })
      map('n', '<leader>ghr', gitsigns.reset_hunk, { desc = 'Reset Hunk' })
      map('v', '<leader>ghs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'Stage Hunk' })
      map('v', '<leader>ghr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'Reset Hunk' })
      map('n', '<leader>ghS', gitsigns.stage_buffer, { desc = 'Stage Buffer' })
      map('n', '<leader>ghR', gitsigns.reset_buffer, { desc = 'Reset Buffer' })
      map('n', '<leader>ghp', gitsigns.preview_hunk, { desc = 'Preview Hunk' })
      map('n', '<leader>ghb', function() gitsigns.blame_line { full = true } end, { desc = 'Blame Line' })
    end,
  },
}
