-- Which key (https://github.com/folke/which-key.nvim)
local M = {}
local localOpts = {}

local Terminal = require('toggleterm.terminal').Terminal
local toggle_lazygit = function()
  local lazygit = Terminal:new({cmd = "lazygit", direction = "float"})
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
      hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
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
      ["w"] = {"<cmd>w!<CR>", "Save"},
      ["z"] = {"<cmd>ZenMode<CR>", "Zen"},
      ["q"] = {"<cmd>q!<CR>", "Quit"},
      ["/"] = {"<cmd>lua require('Comment').toggle()<CR>", "Comment"},
      ["c"] = {"<cmd>BufferClose!<CR>", "Close Buffer"},
      ["f"] = {"<cmd>Telescope find_files<CR>", "Find File"},
      ["h"] = {"<cmd>nohlsearch<CR>", "No Highlight"},
      ["P"] = {"<cmd>Telescope projects<CR>", "Projects"},
      b = {
        name = "Buffers",
        j = {"<cmd>BufferPick<CR>", "Jump"},
        f = {"<cmd>Telescope buffers<CR>", "Find"},
        b = {"<cmd>b#<CR>", "Previous"},
        w = {"<cmd>BufferWipeout<CR>", "Wipeout"},
        e = {"<cmd>BufferCloseAllButCurrent<CR>", "Close all but current"},
        h = {"<cmd>BufferCloseBuffersLeft<CR>", "Close all to the left"},
        l = {"<cmd>BufferCloseBuffersRight<CR>", "Close all to the right"},
        D = {"<cmd>BufferOrderByDirectory<CR>", "Sort by directory"},
        L = {"<cmd>BufferOrderByLanguage<CR>", "Sort by language"}
      },

      -- Packer
      p = {
        name = "Packer",
        c = {"<cmd>PackerCompile<CR>", "Compile"},
        i = {"<cmd>PackerInstall<CR>", "Install"},
        r = {"<cmd>lua require('lvim.plugin-loader').recompile()<CR>", "Re-compile"},
        s = {"<cmd>PackerSync<CR>", "Sync"},
        S = {"<cmd>PackerStatus<CR>", "Status"},
        u = {"<cmd>PackerUpdate<CR>", "Update"}
      },

      -- Git
      g = {
        name = "Git",
        j = {"<cmd>lua require 'gitsigns'.next_hunk()<CR>", "Next Hunk"},
        k = {"<cmd>lua require 'gitsigns'.prev_hunk()<CR>", "Prev Hunk"},
        l = {"<cmd>lua require 'gitsigns'.blame_line()<CR>", "Blame"},
        p = {"<cmd>lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk"},
        r = {"<cmd>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk"},
        R = {"<cmd>lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer"},
        s = {"<cmd>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk"},
        u = {"<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>", "Undo Stage Hunk"},
        o = {"<cmd>Telescope git_status<CR>", "Open changed file"},
        b = {"<cmd>Telescope git_branches<CR>", "Checkout branch"},
        c = {"<cmd>Telescope git_commits<CR>", "Checkout commit"},
        C = {"<cmd>Telescope git_bcommits<CR>", "Checkout commit(for current file)"},
        d = {"<cmd>DiffviewOpen<CR>", "Git Diff Open"},
        D = {"<cmd>DiffviewClose<CR>", "Git Diff Close"},
        g = {toggle_lazygit, "Lazy Git"}
      },

      -- LSP
      l = {
        name = "LSP",
        a = {"<cmd>lua require('lvim.core.telescope').code_actions()<CR>", "Code Action"},
        d = {"<cmd>Telescope lsp_document_diagnostics<CR>", "Document Diagnostics"},
        w = {"<cmd>Telescope lsp_workspace_diagnostics<CR>", "Workspace Diagnostics"},
        f = {"<cmd>lua vim.lsp.buf.formatting()<CR>", "Format"},
        i = {"<cmd>LspInfo<CR>", "Info"},
        I = {"<cmd>LspInstallInfo<CR>", "Installer Info"},
        j = {"<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<CR>", "Next Diagnostic"},
        k = {"<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<CR>", "Prev Diagnostic"},
        l = {"<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action"},
        p = {
          name = "Peek",
          d = {"<cmd>lua require('lvim.lsp.peek').Peek('definition')<CR>", "Definition"},
          t = {"<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<CR>", "Type Definition"},
          i = {"<cmd>lua require('lvim.lsp.peek').Peek('implementation')<CR>", "Implementation"}
        },
        q = {"<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Quickfix"},
        r = {"<cmd>lua vim.lsp.buf.rename()<CR>", "Rename"},
        s = {"<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols"},
        S = {"<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols"}
      },

      -- Telescope search
      s = {
        name = "Search",
        b = {"<cmd>Telescope git_branches<CR>", "Checkout branch"},
        c = {"<cmd>Telescope colorscheme<CR>", "Colorscheme"},
        f = {"<cmd>Telescope find_files<CR>", "Find File"},
        h = {"<cmd>Telescope help_tags<CR>", "Find Help"},
        M = {"<cmd>Telescope man_pages<CR>", "Man Pages"},
        r = {"<cmd>Telescope oldfiles<CR>", "Open Recent File"},
        R = {"<cmd>Telescope registers<CR>", "Registers"},
        t = {"<cmd>Telescope live_grep<CR>", "Text"},
        k = {"<cmd>Telescope keymaps<CR>", "Keymaps"},
        C = {"<cmd>Telescope commands<CR>", "Commands"}
      },

      -- Gist
      G = {
        name = "Gist",
        a = {"<cmd>Gist -b -a<cr>", "Create Anon"},
        d = {"<cmd>Gist -d<cr>", "Delete"},
        f = {"<cmd>Gist -f<cr>", "Fork"},
        g = {"<cmd>Gist -b<cr>", "Create"},
        l = {"<cmd>Gist -l<cr>", "List"},
        p = {"<cmd>Gist -b -p<cr>", "Create Private"}
      },

      -- Bracey hot reload live server
      S = {
        name = "Bracey live server",
        s = {"<cmd>Bracey<cr>", "Start Live Server"},
        S = {"<cmd>BraceyStop<cr>", "Stop Live Server"},
        r = {"<cmd>BraceyReload<cr>", "Reload Live Server"},
      },

      -- DAP Debugger
      d = {
        name = "Debugger",
        t = {"<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint"},
        b = {"<cmd>lua require'dap'.step_back()<cr>", "Step Back"},
        c = {"<cmd>lua require'dap'.continue()<cr>", "Continue"},
        C = {"<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor"},
        d = {"<cmd>lua require'dap'.disconnect()<cr>", "Disconnect"},
        g = {"<cmd>lua require'dap'.session()<cr>", "Get Session"},
        i = {"<cmd>lua require'dap'.step_into()<cr>", "Step Into"},
        o = {"<cmd>lua require'dap'.step_over()<cr>", "Step Over"},
        u = {"<cmd>lua require'dap'.step_out()<cr>", "Step Out"},
        p = {"<cmd>lua require'dap'.pause.toggle()<cr>", "Pause"},
        r = {"<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl"},
        s = {"<cmd>lua require'dap'.continue()<cr>", "Start"},
        q = {"<cmd>lua require'dap'.close()<cr>", "Quit"}
      },

      -- Tests jester
      t = {
        name = "Tests",
        d = {"<cmd>lua require('jester').debug_file({ path_to_jest = '/usr/bin/jest' })<CR>", "Debug File"},
        f = {"<cmd>lua require('jester').run_file()<CR>", "Test File"},
        t = {"<cmd>lua require('jester').run()<CR>", "Test Nearest"},
        l = {"<cmd>lua require('jester').run_last()<CR>", "Test Last"}
      },

      -- Spectre replace
      r = {
        name = "Replace",
        r = {"<cmd>lua require('spectre').open()<CR>", "Replace"},
        w = {"<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Replace Word"},
        f = {"<cmd>lua require('spectre').open_file_search()<CR>", "Replace Buffer"}
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
