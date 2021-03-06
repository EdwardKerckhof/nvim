-- Autopairs (https://github.com/windwp/nvim-autopairs)
local status_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end

local M = {}

M.setup = function()
  local cmpap_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
  if not cmpap_ok then
    return
  end
  local cmp_ok, cmp = pcall(require, "cmp")
  if not cmp_ok then
    return
  end

  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

  autopairs.setup {
    check_ts = true,
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    fast_wrap = {
      map = "<M-e>",
      chars = { "{", "[", "(", '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
      offset = 0, -- Offset from pattern match
      end_key = "$",
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      check_comma = true,
      highlight = "PmenuSel",
      highlight_grey = "LineNr",
    },
  }
end

return M
