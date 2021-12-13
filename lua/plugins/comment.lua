-- Comment.nvim (https://github.com/numToStr/Comment.nvim)
  local status_ok, nvim_comment = pcall(require, "Comment")
  if not status_ok then
    return
  end

local M = {}
local commentOpts = {}

M.config = function ()

  commentOpts = {
    active = true,
    on_config_done = nil,
    padding = true,
    ignore = "^$",
    mappings = {
      basic = true,
      extra = false,
    },
    toggler = {
      line = "gcc",
      block = "gbc",
    },
    opleader = {
      line = "gc",
      block = "gb",
    },
    pre_hook = nil,
    post_hook = nil,
  }
end

M.setup = function ()
  M.config()

  nvim_comment.setup(commentOpts)
end

return M
