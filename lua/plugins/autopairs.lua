-- Autopairs (https://github.com/windwp/nvim-autopairs)
local status_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_ok then return end

local M = {}

M.setup = function()
  local cmpap_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
  if not cmpap_ok then return end
  local cmp_ok, cmp = pcall(require, 'cmp')
  if not cmp_ok then return end

  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))
  cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = "racket"

  autopairs.setup({check_ts = true})
end

return M
