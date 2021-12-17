-- Gitsigns (https://github.com/lewis6991/gitsigns.nvim)
local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

local M = {}

M.setup = function()
  gitsigns.setup {
    signs = {
      add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
      delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    },
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    numhl = false,
    linehl = false,
    keymaps = {
      -- Default keymap options
      noremap = true,
      buffer = true,
    },
    watch_gitdir = { interval = 1000, follow_files = true },
    sign_priority = 6,
    update_debounce = 100,
    max_file_length = 40000,
    preview_config = {
      -- Options passed to nvim_open_win
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    yadm = {
      enable = false,
    },
    status_formatter = nil, -- Use default
  }
end

return M
