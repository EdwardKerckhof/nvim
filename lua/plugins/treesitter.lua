-- Treesitter (https://github.com/nvim-treesitter/nvim-treesitter)
local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

local M = {}

M.setup = function()
  configs.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { "" }, -- list of language that will be disabled
      additional_vim_regex_highlighting = true,
    },
    autotag = {
      enable = true,
    },
    rainbow = {
      enable = true,
      extended_mode = false,
    },
    indent = {
      enable = true,
      disable = { "yaml", "python" },
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    matchup = {
      enable = true,
    },
  }
  -- -- Fix for issue: https://github.com/windwp/nvim-ts-autotag/issues/19
  -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  --   underline = true,
  --   virtual_text = { spacing = 5, severity_limit = "Warning" },
  --   update_in_insert = true,
  -- })
end

return M
