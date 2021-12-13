-- Colorscheme (https://github.com/folke/tokyonight.nvim)
local M = {}

M.setup = function()
  vim.g.tokyonight_style = "night"
  vim.g.tokyonight_italic_functions = false

  -- Load the colorscheme
  vim.cmd [[
    try
      colorscheme tokyonight
    catch /^Vim\%((\a\+)\)\=:E185/
      colorscheme default
      set background=dark
    endtry
  ]]
end

return M
