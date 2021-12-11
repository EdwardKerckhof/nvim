-- neoscroll (https://github.com/karb94/neoscroll.nvim)
local M = {}

M.setup = function ()
  local status_ok, neoscroll = pcall(require, "neoscroll")
  if not status_ok then
    return
  end

  neoscroll.setup{
    easing_function = 'quadratic',        -- Default easing function
  }
end

return M
