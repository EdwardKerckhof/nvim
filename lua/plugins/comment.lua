-- Comment.nvim (https://github.com/numToStr/Comment.nvim)
local M = {}
local commentOpts = {}

M.config = function ()
  local status_ok, comment = pcall(require, "Comment")
  if not status_ok then
    return
  end

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
  local nvim_comment = require "Comment"

  nvim_comment.setup(commentOpts)
end

return M
