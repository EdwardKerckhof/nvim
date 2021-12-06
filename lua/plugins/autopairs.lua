-- Autopairs (https://github.com/windwp/nvim-autopairs)
local M = {}

M.config = function ()
  local status_ok, autopairs = pcall(require, "nvim-autopairs")
  if not status_ok then
    return
  end

  autopairs.setup({
    map_cr = true,
    check_ts = true,
    ts_config = {
      lua = {'string'},-- it will not add a pair on that treesitter node
      javascript = {'template_string'},
      java = false,-- don't check treesitter on java
    }
  })
end

return M
