local ok, trouble = pcall(require, "trouble")
if not ok then
  return
end

local M = {}

M.setup = {
  trouble.setup {
    auto_open = true,
    auto_close = true,
    padding = false,
    height = 10,
    use_lsp_diagnostic_signs = true,
  },
}

return M
