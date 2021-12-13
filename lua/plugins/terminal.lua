local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then return end

local M = {}

M.setup = function()
  toggleterm.setup {
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
    float_opts = {border = "curved", winblend = 0, highlights = {border = "Normal", background = "Normal"}}
  }
end

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({cmd = "lazygit", hidden = true, direction = "float" })

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

return M
