local bp = require "user.snippets.boilerplate"
local ls = require "luasnip"
local f = ls.function_node

local file_pattern = "*"

local date = function()
  return { os.date "%Y-%m-%d" }
end

bp.cs(file_pattern, "date", {
  f(date, {}),
}, { "Date in the form of YYYY-MM-DD" })

return bp.snippets, bp.autosnippets
