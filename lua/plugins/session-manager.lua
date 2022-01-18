local status_ok, session_manager = pcall(require, "session_manager")
if not status_ok then
  return
end

local M = {}

M.setup = function()
  -- local Path = require('plenary.path')
  session_manager.setup {
    autoload_mode = require("session_manager.config").AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
    autosave_last_session = false, -- Automatically save last session on exit.
  }

  local tele_status_ok, telescope = pcall(require, "telescope")
  if not tele_status_ok then
    return
  end

  local tele_session_status_ok, _ = pcall(telescope.load_extension, "sessions")
  if not tele_session_status_ok then
    return
  end
end

return M
