-- Nvim tree (https://github.com/kyazdani42/nvim-tree.lua)
local M = {}

M.config = function ()
  local status_ok, nvimtree = pcall(require, "nvim-tree")
  if not status_ok then
    return
  end

  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_quit_on_open = 1
  vim.g.nvim_tree_git_hl = 1
  vim.g.nvim_tree_highlight_opened_files = 1
  vim.g.nvim_tree_respect_buf_cwd = 1

  vim.api.nvim_set_keymap(
    "n",
    "<leader>e",
    "<CMD>NvimTreeToggle<CR>",
    { noremap = true, silent = true }
  )

  nvimtree.setup {
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = true
    },
    git = {
      enable = true,
      ignore = false,
      timeout = 500,
    },
    view = {
      width = 30,
      height = 30,
      hide_root_folder = false,
      side = 'left',
      auto_resize = false,
      mappings = {
        custom_only = false,
        list = {}
      },
      number = false,
      relativenumber = false
    },
    trash = {
      cmd = "trash",
      require_confirm = true
    }
  }
end

return M
