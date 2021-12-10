-- Treesitter (https://github.com/nvim-treesitter/nvim-treesitter)
local M = {}

M.config = function ()
  local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end

  -- Fix for issue: https://github.com/windwp/nvim-ts-autotag/issues/19
  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = true,
        virtual_text = {
            spacing = 5,
            severity_limit = 'Warning',
        },
        update_in_insert = true,
    }
  )

  treesitter.setup {
    ensure_installed = {
      "bash",
      "c_sharp",
      "cmake",
      "comment",
      "css",
      "dart",
      "dockerfile",
      "graphql",
      "hjson",
      "html",
      "javascript",
      "jsdoc",
      "json5",
      "kotlin",
      "latex",
      "lua",
      "prisma",
      "python",
      "r",
      "regex",
      "scss",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vue",
      "yaml",
    },
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    autotag = { -- nvim-ts-autotag plugin
      enable = true,
    },
    rainbow = { -- nvim-ts-rainbow plugin
      enable = true,
      extended_mode = false,
    },
    context_commentstring = { -- comment based on cursor location
      enable = true
    },
    matchup = {
      enable = true
    }
  }
end

return M
