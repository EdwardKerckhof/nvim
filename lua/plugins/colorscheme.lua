-- Colorscheme (https://github.com/folke/tokyonight.nvim)
local M = {}

M.setup = function ()
  vim.g.tokyonight_style = "storm"
  vim.g.tokyonight_italic_functions = false

  -- Load the colorscheme
  vim.cmd[[colorscheme tokyonight]]
end

return M
