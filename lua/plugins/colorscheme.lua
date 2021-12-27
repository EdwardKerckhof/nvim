local M = {}

M.tokyodark = function()
  vim.g.tokyodark_transparent_background = false
  vim.g.tokyodark_enable_italic_comment = true
  vim.g.tokyodark_enable_italic = true
  vim.g.tokyodark_color_gamma = "1.0"
  vim.cmd "colorscheme tokyodark"
end

M.tokyonight = function()
  vim.g.tokyonight_style = "night"
  vim.g.tokyonight_italic_functions = false
  vim.cmd "colorscheme tokyonight"
end

return M
