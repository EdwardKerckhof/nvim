-- Nvim tree (https://github.com/kyazdani42/nvim-tree.lua)
local ok, nvimtree = pcall(require, "nvim-tree")
if not ok then
  return
end

local M = {}
local kind = require "user.lsp.lsp-kind"

M.setup = function()
  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_quit_on_open = 1
  vim.g.nvim_tree_git_hl = 1
  vim.g.nvim_tree_highlight_opened_files = 1
  vim.g.nvim_tree_respect_buf_cwd = 1
  vim.g.nvim_tree_icons = kind.nvim_tree_icons

  vim.api.nvim_set_keymap("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", { noremap = true, silent = true })

  local tree_cb = require("nvim-tree.config").nvim_tree_callback
  local list = {
    { key = { "l", "<CR>", "o", "<2-LeftMouse>" }, cb = tree_cb "edit" },
    { key = "h", cb = tree_cb "close_node" },
    { key = "v", cb = tree_cb "vsplit" },
    { key = "C", cb = tree_cb "cd" },
  }

  nvimtree.setup {
    disable_netrw = false,
    hijack_netrw = false,
    open_on_setup = false,
    ignore_ft_on_setup = { "startify", "dashboard", "alpha" },
    auto_close = true,
    update_to_buf_dir = { enable = true, auto_open = true },
    update_cwd = true,
    update_focused_file = { enable = true, update_cwd = true },
    diagnostics = { enable = true, icons = { hint = "", info = "", warning = "", error = "" } },
    git = { enable = true, ignore = false, timeout = 200 },
    view = {
      width = 30,
      height = 30,
      hide_root_folder = false,
      side = "left",
      auto_resize = false,
      mappings = { custom_only = false, list = list },
      number = false,
      relativenumber = false,
    },
    trash = { cmd = "trash", require_confirm = true },
  }
end

return M
