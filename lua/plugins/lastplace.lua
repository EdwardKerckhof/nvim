-- nvim-lastplace (https://github.com/ethanholz/nvim-lastplace)
local M = {}

M.setup = function ()
  local status_ok, nvimLastplace = pcall(require, "nvim-lastplace")
  if not status_ok then
    return
  end

  nvimLastplace.setup({
    lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
    lastplace_ignore_filetype = {
      "gitcommit", "gitrebase", "svn", "hgcommit",
    },
    lastplace_open_folds = true,
  })
end

return M
