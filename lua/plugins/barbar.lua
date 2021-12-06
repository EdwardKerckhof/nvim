-- Bufferline (https://github.com/akinsho/bufferline.nvim#features)
local M = {}

M.config = function ()
  local status_ok, bufferline = pcall(require, "bufferline")
  if not status_ok then
    return
  end

  bufferline.setup {

  }
end

return M
