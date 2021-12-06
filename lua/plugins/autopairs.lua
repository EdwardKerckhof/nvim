-- Autopairs (https://github.com/windwp/nvim-autopairs)
local M = {}

M.config = function ()
  local status_ok, autopairs = pcall(require, "nvim-autopairs")
  if not status_ok then
    return
  end

  autopairs.setup({

  })
end

return M
