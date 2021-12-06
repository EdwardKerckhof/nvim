-- Treesitter (https://github.com/nvim-treesitter/nvim-treesitter)
local M = {}

M.config = function ()
  local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end

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
      "yaml"
    },
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    highlight = {
      enable = true,  -- false will disable the whole extension
      additional_vim_regex_highlighting = false,
    },
  }
end

return M
