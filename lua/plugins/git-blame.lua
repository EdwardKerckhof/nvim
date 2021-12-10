-- git-blame (https://github.com/f-person/git-blame.nvim)
local M = {}

M.setup = function ()
  vim.g.gitblame_enabled = 1
  vim.g.gitblame_message_template = "<summary> • <date> • <author>"
  vim.g.gitblame_highlight_group = "LineNr"
end

return M
