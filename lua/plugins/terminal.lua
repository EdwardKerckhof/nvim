local M = {}

M.setup = function()
  local status_ok, toggleterm = pcall(require, "toggleterm")
  if not status_ok then return end

  toggleterm.setup {
    on_config_done = nil,
    size = 20,
    open_mapping = [[<C-t>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = false,
    direction = "float",
    close_on_exit = true, -- close the terminal window when the process exits
    shell = "zsh", -- change the default shell
    float_opts = {border = "curved", winblend = 0, highlights = {border = "Normal", background = "Normal"}},
    execs = {{"lazygit", "<leader>gg", "LazyGit", "float"}, {"lazygit", "<c-\\>", "LazyGit", "float"}}
  }
end

return M
