-- impatient (https://github.com/lewis6991/impatient.nvim)
local ok, impatient = pcall(require, "impatient")
if not ok then return end

local M = {}

M.setup = function()
  impatient.enable_profile()
end

return M

