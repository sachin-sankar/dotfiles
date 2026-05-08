return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lsp_servers = {
      lua_ls = {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            codeLens = { enable = true },
            completion = { callSnippet = "Replace" },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            },
          },
        },
      },
      pyrefly = {},
      ruff = {
        cmd_env = { RUFF_TRACE = "messages" },
        init_options = { settings = { logLevel = "error" } },
      },
      gopls = {},
      bashls = {},
      tinymist = {
        single_file_support = true,
        settings = { formatterMode = "typstyle" },
      },
      jsonls = {},
      dockerls = {},
      docker_compose_language_service = {},
      ts_ls = {},
      vtsls = {},
      tsgo = {},
      tailwindcss = {
        filetypes = vim.tbl_filter(function(ft)
          return ft ~= "markdown"
        end, (vim.lsp.config.tailwindcss or {}).filetypes or {}),
        settings = {
          tailwindCSS = {
            includeLanguages = {
              elixir = "html-eex",
              eelixir = "html-eex",
              heex = "html-eex",
            },
          },
        },
      },
      oxlint = { settings = { fixKind = "all" } },
    }

    local capabilities = require("blink.cmp").get_lsp_capabilities()
    capabilities.workspace = {
      fileOperations = {
        didRename = true,
        willRename = true,
      },
    }

    vim.diagnostic.config({
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = "󰀪 ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
          [vim.diagnostic.severity.INFO] = "󰋽 ",
        },
      },
      virtual_lines = { current_line = true },
    })

    vim.lsp.config("*", { capabilities = capabilities })

    for server, config in pairs(lsp_servers) do
      vim.lsp.config(server, config)
    end

    for server in pairs(lsp_servers) do
      vim.lsp.enable(server)
    end

    Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
      if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buftype == "" then
        return vim.lsp.inlay_hint.enable(false, { bufnr = buffer })
      end
    end)
  end,
}

