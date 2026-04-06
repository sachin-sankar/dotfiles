local servers = {
  'lua_ls',
  'pyright',
  'ts_ls',
  'bashls',
  'jsonls',
  'marksman',
  'dockerls',
  'docker_compose_language_service',
  'gopls',
  'prismals',
  'ruff',
  'tailwindcss',
  'oxlint',
  'tsgo',
  'tinymist',
  'biome',
}

return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    capabilities.workspace = {
      fileOperations = {
        didRename = true,
        willRename = true,
      },
    }

    vim.diagnostic.config {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = 'if_many',
        prefix = '●',
      },
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
        },
      },
      virtual_lines = {
        current_line = true
      }
    }

    vim.lsp.config('*', {
      capabilities = capabilities,
    })

    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
          codeLens = {
            enable = true,
          },
          completion = {
            callSnippet = 'Replace',
          },
          hint = {
            enable = true,
            setType = false,
            paramType = true,
            paramName = 'Disable',
            semicolon = 'Disable',
            arrayIndex = 'Disable',
          },
        },
      },
    })

    vim.lsp.config('gopls', {
      settings = {
        gopls = {
          gofumpt = true,
          codelenses = {
            gc_details = false,
            generate = true,
            regenerate_cgo = true,
            run_govulncheck = true,
            test = true,
            tidy = true,
            upgrade_dependency = true,
            vendor = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          analyses = {
            nilness = true,
            unusedparams = true,
            unusedwrite = true,
            useany = true,
          },
          usePlaceholders = true,
          completeUnimported = true,
          staticcheck = true,
          directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
          semanticTokens = true,
        },
      },
    })

    Snacks.util.lsp.on({ name = 'gopls' }, function(_, client)
      if not client.server_capabilities.semanticTokensProvider then
        local semantic = client.config.capabilities.textDocument.semanticTokens
        client.server_capabilities.semanticTokensProvider = {
          full = true,
          legend = {
            tokenTypes = semantic.tokenTypes,
            tokenModifiers = semantic.tokenModifiers,
          },
          range = true,
        }
      end
    end)

    vim.lsp.config('ruff', {
      cmd_env = { RUFF_TRACE = 'messages' },
      init_options = {
        settings = {
          logLevel = 'error',
        },
      },
    })

    Snacks.util.lsp.on({ name = 'ruff' }, function(_, client)
      client.server_capabilities.hoverProvider = false
    end)

    vim.lsp.config('tailwindcss', {
      filetypes = vim.tbl_filter(function(ft)
        return ft ~= 'markdown'
      end, vim.lsp.config.tailwindcss.filetypes),
      settings = {
        tailwindCSS = {
          includeLanguages = {
            elixir = 'html-eex',
            eelixir = 'html-eex',
            heex = 'html-eex',
          },
        },
      },
    })

    vim.lsp.config('oxlint', {
      settings = {
        fixKind = 'all',
      },
    })

    vim.lsp.config('tsgo', {
      filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
      },
      settings = {
        typescript = {
          inlayHints = {
            enumMemberValues = { enabled = true },
            functionLikeReturnTypes = { enabled = false },
            parameterNames = {
              enabled = 'literals',
              suppressWhenArgumentMatchesName = true,
            },
            parameterTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            variableTypes = { enabled = false },
          },
        },
      },
    })

    vim.lsp.config('tinymist', {
      single_file_support = true,
      settings = {
        formatterMode = 'typstyle',
      },
    })

    for _, server in ipairs(servers) do
      vim.lsp.enable(server)
    end

    Snacks.util.lsp.on({ method = 'textDocument/inlayHint' }, function(buffer)
      if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buftype == '' then
        vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
      end
    end)
  end,
}
