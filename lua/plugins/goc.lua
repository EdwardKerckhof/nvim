local status_ok, goc = pcall(require, "nvim-goc")
if not status_ok then
  return
end

local M = {}

M.setup = function()
  vim.opt.switchbuf = "useopen"
  goc.setup { verticalSplit = false }

  vim.api.nvim_set_keymap("n", "<Leader>tt", "<CMD>lua require('nvim-goc').Coverage<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<Leader>tc", "<CMD>lua require('nvim-goc').ClearCoverage<CR>", { silent = true })
end

return M
