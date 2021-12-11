-- spellsitter (https://github.com/lewis6991/spellsitter.nvim)
local M = {}

M.setup = function()
  local status_ok, spellsitter = pcall(require, "spellsitter")
  if not status_ok then return end

  spellsitter.setup {enable = true, spellchecker = 'vimfn'}
end

return M
