-- Project (https://github.com/ahmedkhalf/project.nvim)
local M = {}

M.setup = function ()
  local status_ok, project = pcall(require, "project_nvim")
  if not status_ok then
    return
  end

  project.setup {
    manual_mode = false,
    detection_methods = { "lsp", "pattern" },
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    show_hidden = false,
    silent_chdir = true,
    ignore_lsp = {},
    datapath = vim.fn.stdpath("data"),
  }
end

return M
