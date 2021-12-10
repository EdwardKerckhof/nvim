-- LSP-Rooter (https://github.com/ahmedkhalf/lsp-rooter.nvim)
local M = {}

M.setup = function ()
  local status_ok, lspRooter = pcall(require, "lsp-rooter")
  if not status_ok then
    return
  end

  lspRooter.setup {}
end

return M
