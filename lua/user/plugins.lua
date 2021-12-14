local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  use { "wbthomason/packer.nvim" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim" } -- Useful lua functions used by a lot of plugins
  use { "nvim-lua/popup.nvim" } -- An implementation of the Popup API from vim in Neovim

  use { -- Treesitter
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = "BufWinEnter",
    config = function(_)
      require("plugins.treesitter").setup()
    end,
  }
  use { "kyazdani42/nvim-web-devicons" } -- Web devicons needed for a lot of plugins
  use { "windwp/nvim-ts-autotag", event = "InsertEnter", after = "nvim-treesitter" } -- TS autotag/autorename plugin
  use { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" } -- TS rainbow plugin
  use { -- TS commenstring based on cursor location
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufRead",
    after = "nvim-treesitter",
  }

  use { -- Lualine
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("plugins.lualine").setup()
    end,
  }

  -- CMP
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-nvim-lua" }
  use { "hrsh7th/cmp-buffer" }
  use { "hrsh7th/cmp-path" }
  use { "hrsh7th/cmp-cmdline" }
  use { "hrsh7th/cmp-vsnip" }
  use { "hrsh7th/vim-vsnip" }
  use { "hrsh7th/cmp-emoji" }
  use {
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.cmp").setup()
    end,
  }

  -- snippets
  use {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip/loaders/from_vscode").lazy_load()
    end,
  }
  use { "saadparwaiz1/cmp_luasnip" }

  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

  -- LSP
  use { "neovim/nvim-lspconfig" }
  use { "williamboman/nvim-lsp-installer" }
  use { "onsails/lspkind-nvim" }
  use { "tamago324/nlsp-settings.nvim" }
  use { "jose-elias-alvarez/null-ls.nvim" }

  use { -- Colorscheme
    "folke/tokyonight.nvim",
    config = function()
      require("plugins.colorscheme").setup()
    end,
  }
  use { -- Buffer status bar
    -- 'romgrk/barbar.nvim',
    "akinsho/bufferline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.bufferline").setup()
    end,
  }
  use { -- File tree explorer
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.nvim-tree").setup()
    end,
  }
  use { -- Nvim autopairs
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.autopairs").setup()
    end,
  }
  use { -- Whichkey
    "folke/which-key.nvim",
    event = "BufWinEnter",
    config = function()
      require("plugins.which-key").setup()
    end,
  }
  use { -- Trouble
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        auto_open = true,
        auto_close = true,
        padding = false,
        height = 10,
        use_lsp_diagnostic_signs = true,
      }
    end,
    cmd = "Trouble",
  }
  use { -- Telescope
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    config = function()
      require("plugins.telescope").setup()
    end,
  }
  use { -- FZF telescope plugin
    "nvim-telescope/telescope-fzf-native.nvim",
  }
  use { -- Projects telescope plugin
    "nvim-telescope/telescope-project.nvim",
  }
  use { "nvim-telescope/telescope-media-files.nvim" }
  use { -- VSCode like renamer
    "filipdutescu/renamer.nvim",
    branch = "master",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.renamer").setup()
    end,
  }
  use { -- Commenter
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("plugins.comment").setup()
    end,
  }
  use { -- Colorizer
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("plugins.colorizer").setup()
    end,
  }
  use { -- Gitsigns
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require("plugins.gitsigns").setup()
    end,
  }
  use { -- Toggleterm
    "akinsho/toggleterm.nvim",
    event = "BufWinEnter",
    config = function()
      require("plugins.terminal").setup()
    end,
  }
  use { -- Dashboard
    -- 'glepnir/dashboard-nvim',
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("plugins.dashboard").setup()
    end,
  }
  use { -- Recent projects
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugins.project").setup()
    end,
  }
  use { -- Indent blankline
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("plugins.blankline").setup()
    end,
  }
  -- use { -- Formatter
  --   "lukas-reineke/format.nvim",
  --   cmd = "Format",
  --   config = function()
  --     require("plugins.formatter").setup()
  --   end,
  -- }
  use { -- hop
    "phaazon/hop.nvim",
    branch = "v1",
    config = function()
      require("plugins.hop").setup()
    end,
  }
  use { -- diffview
    "sindrets/diffview.nvim",
    event = "BufRead",
    requires = "nvim-lua/plenary.nvim",
  }
  use { -- git-blame
    "f-person/git-blame.nvim",
    config = function()
      require("plugins.git-blame").setup()
    end,
  }
  use { -- vig-gist
    "mattn/vim-gist",
    event = "BufRead",
    requires = "mattn/webapi-vim",
    config = function()
      require("plugins.vim-gist").setup()
    end,
  }
  use { -- change cwd automatically
    "ahmedkhalf/lsp-rooter.nvim",
    config = function()
      require("plugins.lsp-rooter").setup()
    end,
  }
  use { -- add signature hinting when typing
    "ray-x/lsp_signature.nvim",
    config = function()
      require("plugins.lsp-signature").setup()
    end,
  }
  use {
    "aserowy/tmux.nvim",
    config = function()
      require("plugins.tmux").setup()
    end,
  }
  use {
    "monaqa/dial.nvim",
    event = "BufRead",
    config = function()
      require("plugins.dial").setup()
    end,
  }
  use { -- Markdown Preview
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
    config = function()
      require "plugins.markdown-preview"
    end,
  }
  use { -- neoscroll smooth scroll
    "karb94/neoscroll.nvim",
    event = "BufRead",
    config = function()
      require("plugins.neoscroll").setup()
    end,
  }
  use { -- TODO comments highlight and searcher
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("plugins.todo-comments").setup()
    end,
  }
  use { -- Match brackets
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      require("plugins.matchup").setup()
    end,
  }
  use { -- Underline word under cursor
    "itchyny/vim-cursorword",
    event = { "BufEnter", "BufNewFile" },
    config = function()
      require("plugins.cursorword").setup()
    end,
  }
  use { -- Open urls with gx
    "felipec/vim-sanegx",
    event = "BufRead",
  }
  use { -- Live edit html, css and javascript
    "turbio/bracey.vim",
    cmd = { "Bracey", "BracyStop", "BraceyReload", "BraceyEval" },
    run = "npm install --prefix server",
  }
  use { -- Notifications
    "rcarriga/nvim-notify",
  }
  use { -- Automatically create dir for file if non existent
    "jghauser/mkdir.nvim",
    event = "BufWritePre",
    config = function()
      require "mkdir"
    end,
  }
  use { -- Cheatsheet
    "RishabhRD/nvim-cheat.sh",
    requires = "RishabhRD/popfix",
    config = function()
      vim.g.cheat_default_window_layout = "float"
    end,
    cmd = { "Cheat", "CheatWithoutComments", "CheatList", "CheatListWithoutComments" },
    keys = "<leader>?",
  }
  use { -- Treesitter spellcheck
    "lewis6991/spellsitter.nvim",
    config = function()
      require("plugins.spellsitter").setup()
    end,
  }
  -- use { -- Yarn / Npm package info and manager
  --   "vuki656/package-info.nvim",
  --   requires = "MunifTanjim/nui.nvim",
  --   config = function()
  --     require("plugins.package-info").setup()
  --   end,
  -- }
  use { -- LSPSaga
    "tami5/lspsaga.nvim",
    config = function()
      require("plugins.lspsaga").setup()
    end,
  }
  use { -- Close Buffers
    "kazhala/close-buffers.nvim",
    config = function()
      require("plugins.close-buffers").setup()
    end,
  }
  use { -- Impatient
    "lewis6991/impatient.nvim",
    config = function()
      require("plugins.impatient").setup()
    end,
  }
  -- use {
  --   "folke/persistence.nvim",
  --   event = "BufReadPre", -- this will only start session saving when an actual file was opened
  --   module = "persistence",
  --   config = function()
  --     require("persistence").setup()
  --   end,
  -- }
  use {
    "Shatur/neovim-session-manager",
    config = function()
      require("plugins.session-manager").setup()
    end,
  }
  use { "folke/lsp-colors.nvim" } -- automatic lsp colors
  use { "tpope/vim-surround" } -- Change surroundings
  use { "folke/zen-mode.nvim" } -- Zen mode
  use { "tpope/vim-repeat" } -- Repeat with '.'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
