-- Colorscheme (https://github.com/folke/tokyonight.nvim)
local M = {}

M.config = function ()
  local status_ok, _ = pcall(require, "tokyonight")
  if not status_ok then
    return
  end

  vim.g.tokyonight_style = "storm"
  vim.g.tokyonight_italic_functions = false

  -- Load the colorscheme
  vim.cmd[[colorscheme tokyonight]]
end

return M
