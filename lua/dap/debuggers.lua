local M = {}

M.launch_go_debugger = function()
  local dap = require "dap"
  -- The adapter has not been started yet.
  -- Spin it up.
  local goLaunchAdapter = {
    type = "executable",
    command = "node",
    args = { os.getenv "HOME" .. "/vscode-go/dist/debugAdapter.js" },
  }

  local goLaunchConfig = {
    type = "go",
    request = "attach",
    mode = "remote",
    name = "Remote Attached Debugger",
    dlvToolPath = "/usr/bin/dlv", -- Or wherever your local delve lives.
    remotePath = "",
    port = "3000",
    cwd = vim.fn.getcwd(),
  }
  -- If you want you can even have nvim be responsible for the `delve` launch step above:
  --  vim.fn.system({"${some_script_that_starts_dlv_in_your_container}", ${script_args})
  local session = dap.launch(goLaunchAdapter, goLaunchConfig)
  if session == nil then
    io.write "Error launching adapter"
  end

  dap.repl.open()
end
