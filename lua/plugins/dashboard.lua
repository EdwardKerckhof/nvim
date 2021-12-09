-- Dashboard (https://github.com/glepnir/dashboard-nvim)
local M = {}

M.setup = function ()
  vim.g.dashboard_default_executive = 'telescope'
  vim.g.dashboard_custom_header = {
    [[                                                        ]],
    [[                                                        ]],
    [[                                                        ]],
    [[ ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗ ]],
    [[ ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║ ]],
    [[ ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║ ]],
    [[ ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║ ]],
    [[ ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║ ]],
    [[ ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝ ]],
    [[                                                        ]],
    [[                                                        ]],
    [[                                                        ]],
  }
  vim.g.dashboard_custom_section = {
    a = {
      description = { "  Find File          " },
      command = "Telescope find_files",
    },
    b = {
      description = { "  New File           " },
      command = ":ene!",
    },
    c = {
      description = { "  Recent Projects    " },
      command = "Telescope projects",
    },
    d = {
      description = { "  Recently Used Files" },
      command = "Telescope oldfiles",
    },
    e = {
      description = { "  Find Word          " },
      command = "Telescope live_grep",
    },
    f = {
      description = { "  Config             " },
      command = "edit ~/.config/nvim/init.lua"
    }
  }

  local footer = {
    "Edward Kerckhof",
  }
  vim.g.dashboard_custom_footer = footer;
end

return M
