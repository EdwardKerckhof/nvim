-- Hop (https://github.com/phaazon/hop.nvim)
local M = {}

M.setup = function ()
  local status_ok, hop = pcall(require, "hop")
  if not status_ok then
    return
  end

  hop.setup ()

  vim.api.nvim_set_keymap("n", "s", ":HopChar2<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "S", ":HopWord<CR>", { silent = true })
end

return M
