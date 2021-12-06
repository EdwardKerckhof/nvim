-- Nvim tree (https://github.com/kyazdani42/nvim-tree.lua)
local M = {}

M.config = function ()
  local status_ok, nvimtree = pcall(require, "nvim-tree")
  if not status_ok then
    return
  end

  vim.g.nvim_tree_indent_markers = 1

  vim.api.nvim_set_keymap(
    "n",
    "<leader>e",
    "<CMD>NvimTreeToggle<CR>",
    { noremap = true, silent = true }
  )

  nvimtree.setup {
    git = {
      enable = true,
      ignore = true,
      timeout = 500,
    },
    trash = {
      cmd = "trash",
      require_confirm = true
    }
  }
end

return M
