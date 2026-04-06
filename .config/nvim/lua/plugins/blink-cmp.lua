return {
  'saghen/blink.cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    'L3MON4D3/LuaSnip',
    {
      'saghen/blink.compat',
      opts = {},
    },
  },
  opts_extend = {
    'sources.completion.enabled_providers',
    'sources.default',
  },
  opts = {
    snippets = {
      preset = 'luasnip',
      expand = function(snippet)
        require('luasnip').lsp_expand(snippet)
      end,
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono',
    },
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        draw = {
          treesitter = { 'lsp' },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = false,
      },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      per_filetype = {
        lua = { inherit_defaults = true, 'lazydev' },
      },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },
    cmdline = {
      enabled = true,
      keymap = {
        preset = 'cmdline',
        ['<Right>'] = false,
        ['<Left>'] = false,
      },
      completion = {
        list = { selection = { preselect = false } },
        menu = {
          auto_show = function(ctx)
            return vim.fn.getcmdtype() == ':'
          end,
        },
        ghost_text = { enabled = true },
      },
    },
    keymap = {
      preset = 'enter',
      ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      ['<C-y>'] = { 'select_and_accept' },
    },
  },
}
