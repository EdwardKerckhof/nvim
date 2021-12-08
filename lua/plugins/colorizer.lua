-- Colorizer (https://github.com/norcalli/nvim-colorizer.lua)
local M = {}

M.setup = function ()
  local status_ok, colorizer = pcall(require, "colorizer")
  if not status_ok then
    return
  end

  colorizer.setup()
end

return M
