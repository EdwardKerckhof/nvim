-- Which key (https://github.com/folke/which-key.nvim)
local M = {}
local localOpts = {}

local Terminal = require('toggleterm.terminal').Terminal
local toggle_lazygit = function()
  local lazygit = Terminal:new({CMD = "lazygit", direction = "float"})
  return lazygit:toggle()
end

M.config = function()
  localOpts = {
    active = true,
    on_config_done = nil,
    setup = {
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = false, -- adds help for operators like d, y, ...
          motions = false, -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true -- bindings for prefixed with g
        },
        spelling = {enabled = true, suggestions = 20} -- use which-key for spelling hints
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+" -- symbol prepended to a group
      },
      window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
        padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
      },
      layout = {
        height = {min = 4, max = 25}, -- min and max height of the columns
        width = {min = 20, max = 50}, -- min and max width of the columns
        spacing = 3 -- spacing between columns
      },
      hidden = {"<silent>", "<CMD>", "<CMD>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
      show_help = true -- show help message on the command line when the popup is visible
    },
    opts = {
      mode = "n", -- NORMAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true -- use `nowait` when creating keymaps
    },
    vopts = {
      mode = "v", -- VISUAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true -- use `nowait` when creating keymaps
    },
    vmappings = {["/"] = {"<ESC><CMD>lua require('Comment.api').gc(vim.fn.visualmode())<CR>", "Comment"}},
    mappings = {
      ["w"] = {"<CMD>w!<CR>", "Save"},
      ["z"] = {"<CMD>ZenMode<CR>", "Zen"},
      ["q"] = {"<CMD>q!<CR>", "Quit"},
      ["/"] = {"<CMD>lua require('Comment').toggle()<CR>", "Comment"},
      ["c"] = {"<CMD>BufferClose!<CR>", "Close Buffer"},
      ["f"] = {"<CMD>Telescope find_files<CR>", "Find File"},
      ["h"] = {"<CMD>nohlsearch<CR>", "No Highlight"},
      ["P"] = {"<CMD>Telescope projects<CR>", "Projects"},
      ["?"] = {"<CMD>Cheat<CR>", "Cheatsheet"},
      b = {
        name = "Buffers",
        j = {"<CMD>BufferPick<CR>", "Jump"},
        f = {"<CMD>Telescope buffers<CR>", "Find"},
        b = {"<CMD>b#<CR>", "Previous"},
        w = {"<CMD>BufferWipeout<CR>", "Wipeout"},
        e = {"<CMD>BufferCloseAllButCurrent<CR>", "Close all but current"},
        h = {"<CMD>BufferCloseBuffersLeft<CR>", "Close all to the left"},
        l = {"<CMD>BufferCloseBuffersRight<CR>", "Close all to the right"},
        D = {"<CMD>BufferOrderByDirectory<CR>", "Sort by directory"},
        L = {"<CMD>BufferOrderByLanguage<CR>", "Sort by language"}
      },

      -- Packer
      p = {
        name = "Packer",
        c = {"<CMD>PackerCompile<CR>", "Compile"},
        i = {"<CMD>PackerInstall<CR>", "Install"},
        r = {"<CMD>lua require('lvim.plugin-loader').recompile()<CR>", "Re-compile"},
        s = {"<CMD>PackerSync<CR>", "Sync"},
        S = {"<CMD>PackerStatus<CR>", "Status"},
        u = {"<CMD>PackerUpdate<CR>", "Update"}
      },

      -- Git
      g = {
        name = "Git",
        j = {"<CMD>lua require 'gitsigns'.next_hunk()<CR>", "Next Hunk"},
        k = {"<CMD>lua require 'gitsigns'.prev_hunk()<CR>", "Prev Hunk"},
        l = {"<CMD>lua require 'gitsigns'.blame_line()<CR>", "Blame"},
        p = {"<CMD>lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk"},
        r = {"<CMD>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk"},
        R = {"<CMD>lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer"},
        s = {"<CMD>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk"},
        u = {"<CMD>lua require 'gitsigns'.undo_stage_hunk()<CR>", "Undo Stage Hunk"},
        o = {"<CMD>Telescope git_status<CR>", "Open changed file"},
        b = {"<CMD>Telescope git_branches<CR>", "Checkout branch"},
        c = {"<CMD>Telescope git_commits<CR>", "Checkout commit"},
        C = {"<CMD>Telescope git_bcommits<CR>", "Checkout commit(for current file)"},
        d = {"<CMD>DiffviewOpen<CR>", "Git Diff Open"},
        D = {"<CMD>DiffviewClose<CR>", "Git Diff Close"},
        g = {toggle_lazygit, "Lazy Git"}
      },

      -- LSP
      l = {
        name = "LSP",
        a = {"<CMD>lua require('lvim.core.telescope').code_actions()<CR>", "Code Action"},
        d = {"<CMD>Telescope lsp_document_diagnostics<CR>", "Document Diagnostics"},
        w = {"<CMD>Telescope lsp_workspace_diagnostics<CR>", "Workspace Diagnostics"},
        f = {"<CMD>lua vim.lsp.buf.formatting()<CR>", "Format"},
        i = {"<CMD>LspInfo<CR>", "Info"},
        I = {"<CMD>LspInstallInfo<CR>", "Installer Info"},
        j = {"<CMD>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<CR>", "Next Diagnostic"},
        k = {"<CMD>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<CR>", "Prev Diagnostic"},
        l = {"<CMD>lua vim.lsp.codelens.run()<CR>", "CodeLens Action"},
        p = {
          name = "Peek",
          d = {"<CMD>lua require('lvim.lsp.peek').Peek('definition')<CR>", "Definition"},
          t = {"<CMD>lua require('lvim.lsp.peek').Peek('typeDefinition')<CR>", "Type Definition"},
          i = {"<CMD>lua require('lvim.lsp.peek').Peek('implementation')<CR>", "Implementation"}
        },
        q = {"<CMD>lua vim.lsp.diagnostic.set_loclist()<CR>", "Quickfix"},
        r = {"<CMD>lua vim.lsp.buf.rename()<CR>", "Rename"},
        s = {"<CMD>Telescope lsp_document_symbols<CR>", "Document Symbols"},
        S = {"<CMD>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols"}
      },

      -- Telescope search
      s = {
        name = "Search",
        b = {"<CMD>Telescope git_branches<CR>", "Checkout branch"},
        c = {"<CMD>Telescope colorscheme<CR>", "Colorscheme"},
        f = {"<CMD>Telescope find_files<CR>", "Find File"},
        h = {"<CMD>Telescope help_tags<CR>", "Find Help"},
        M = {"<CMD>Telescope man_pages<CR>", "Man Pages"},
        r = {"<CMD>Telescope oldfiles<CR>", "Open Recent File"},
        R = {"<CMD>Telescope registers<CR>", "Registers"},
        t = {"<CMD>Telescope live_grep<CR>", "Text"},
        k = {"<CMD>Telescope keymaps<CR>", "Keymaps"},
        C = {"<CMD>Telescope commands<CR>", "Commands"}
      },

      -- Gist
      G = {
        name = "Gist",
        a = {"<CMD>Gist -b -a<cr>", "Create Anon"},
        d = {"<CMD>Gist -d<cr>", "Delete"},
        f = {"<CMD>Gist -f<cr>", "Fork"},
        g = {"<CMD>Gist -b<cr>", "Create"},
        l = {"<CMD>Gist -l<cr>", "List"},
        p = {"<CMD>Gist -b -p<cr>", "Create Private"}
      },

      -- Bracey hot reload live server
      S = {
        name = "Bracey live server",
        s = {"<CMD>Bracey<cr>", "Start Live Server"},
        S = {"<CMD>BraceyStop<cr>", "Stop Live Server"},
        r = {"<CMD>BraceyReload<cr>", "Reload Live Server"}
      },

      -- DAP Debugger
      d = {
        name = "Debugger",
        t = {"<CMD>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint"},
        b = {"<CMD>lua require'dap'.step_back()<cr>", "Step Back"},
        c = {"<CMD>lua require'dap'.continue()<cr>", "Continue"},
        C = {"<CMD>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor"},
        d = {"<CMD>lua require'dap'.disconnect()<cr>", "Disconnect"},
        g = {"<CMD>lua require'dap'.session()<cr>", "Get Session"},
        i = {"<CMD>lua require'dap'.step_into()<cr>", "Step Into"},
        o = {"<CMD>lua require'dap'.step_over()<cr>", "Step Over"},
        u = {"<CMD>lua require'dap'.step_out()<cr>", "Step Out"},
        p = {"<CMD>lua require'dap'.pause.toggle()<cr>", "Pause"},
        r = {"<CMD>lua require'dap'.repl.toggle()<cr>", "Toggle Repl"},
        s = {"<CMD>lua require'dap'.continue()<cr>", "Start"},
        q = {"<CMD>lua require'dap'.close()<cr>", "Quit"}
      },

      -- Tests jester
      t = {
        name = "Tests",
        d = {"<CMD>lua require('jester').debug_file({ path_to_jest = '/usr/bin/jest' })<CR>", "Debug File"},
        f = {"<CMD>lua require('jester').run_file()<CR>", "Test File"},
        t = {"<CMD>lua require('jester').run()<CR>", "Test Nearest"},
        l = {"<CMD>lua require('jester').run_last()<CR>", "Test Last"}
      },

      -- Package info
      n = {
        name = "Package Info",
        s = {"<CMD>lua require('package-info').show({ force = true })<CR>", "Show Latest Package Versions"},
        d = {"<CMD>lua require('package-info').delete()<CR>", "Delete Package"},
        p = {"<CMD>lua require('package-info').change_version()<CR>", "Change Package Version"},
        i = {"<CMD>lua require('package-info').install()<CR>", "Install a new Package"},
        r = {"<CMD>lua require('package-info').reinstall()<CR>", "Reinstall Dependencies"}
      },

      -- Spectre replace
      r = {
        name = "Replace",
        r = {"<CMD>lua require('spectre').open()<CR>", "Replace"},
        w = {"<CMD>lua require('spectre').open_visual({select_word=true})<CR>", "Replace Word"},
        f = {"<CMD>lua require('spectre').open_file_search()<CR>", "Replace Buffer"}
      },

      -- Treesitter
      T = {name = "Treesitter", i = {":TSConfigInfo<CR>", "Info"}}
    }
  }
end

M.setup = function()
  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then return end

  M.config()

  which_key.setup(localOpts.setup)

  local opts = localOpts.opts
  local vopts = localOpts.vopts

  local mappings = localOpts.mappings
  local vmappings = localOpts.vmappings

  which_key.register(mappings, opts)
  which_key.register(vmappings, vopts)
end

return M
