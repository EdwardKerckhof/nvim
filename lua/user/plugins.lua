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
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by a lot of plugins
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "kyazdani42/nvim-web-devicons" -- Web devicons needed for a lot of plugins

  use {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  }

  -- CMP
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-emoji"
  use {
    "fatih/vim-go",
    config = function()
      vim.g.go_def_mapping_enabled = 0
      vim.g.go_metalinter_enabled = 0
      vim.g.go_fmt_autosave = 0
      vim.g.go_mod_fmt_autosave = 0
      vim.g.go_asmfmt_autosave = 0
    end,
  }
  use {
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.cmp").setup()
    end,
  }
  use {
    "tzachar/cmp-tabnine",
    config = function()
      local tabnine = require "cmp_tabnine.config"
      tabnine:setup {
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
      }
    end,

    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
  }

  -- Snippets
  use {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip/loaders/from_vscode").lazy_load()
    end,
  }
  use "saadparwaiz1/cmp_luasnip"
  use "rafamadriz/friendly-snippets"

  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"
  use "onsails/lspkind-nvim"
  use "tamago324/nlsp-settings.nvim"
  use "jose-elias-alvarez/null-ls.nvim"
  use "folke/lsp-colors.nvim" -- automatic lsp colors
  use {
    "filipdutescu/renamer.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.renamer").setup()
    end,
  }
  use {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = function()
      require("plugins.trouble").setup()
    end,
  }
  use {
    "ahmedkhalf/lsp-rooter.nvim",
    config = function()
      require("plugins.lsp-rooter").setup()
    end,
  }
  use {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("plugins.lsp-signature").setup()
    end,
  }
  use {
    "tami5/lspsaga.nvim",
    config = function()
      require("plugins.lspsaga").setup()
    end,
  }

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    config = function()
      require("plugins.telescope").setup()
    end,
  }
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugins.project").setup()
    end,
  }
  use "nvim-telescope/telescope-fzf-native.nvim"
  use "nvim-telescope/telescope-project.nvim"
  use "nvim-telescope/telescope-media-files.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    commit = "668de0951a36ef17016074f1120b6aacbe6c4515",
    run = ":TSUpdate",
    config = function()
      require("plugins.treesitter").setup()
    end,
  }
  use {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    after = "nvim-treesitter",
  }
  use {
    "p00f/nvim-ts-rainbow",
    after = "nvim-treesitter",
  }
  use {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufRead",
    after = "nvim-treesitter",
  }
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.autopairs").setup()
    end,
  }
  -- use {
  --   "lewis6991/spellsitter.nvim",
  --   config = function()
  --     require("plugins.spellsitter").setup()
  --   end,
  -- }

  -- GIT
  use {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require("plugins.gitsigns").setup()
    end,
  }
  use {
    "f-person/git-blame.nvim",
    config = function()
      require("plugins.git-blame").setup()
    end,
  }
  use {
    "mattn/vim-gist",
    event = "BufRead",
    requires = "mattn/webapi-vim",
    config = function()
      require("plugins.vim-gist").setup()
    end,
  }

  -- Colorscheme
  use {
    -- "folke/tokyonight.nvim",
    "tiagovla/tokyodark.nvim",
    config = function()
      require("plugins.colorscheme").tokyodark()
    end,
  }

  -- Bufferline/Statusline
  use {
    "tamton-aquib/staline.nvim",
    config = function()
      require("plugins.staline").setup()
    end,
  }
  use {
    "akinsho/bufferline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.bufferline").setup()
    end,
  }

  -- DAP
  -- use "mfussenegger/nvim-dap"
  -- use "theHamsta/nvim-dap-virtual-text"
  -- use "rcarriga/nvim-dap-ui"
  -- use "Pocco81/DAPInstall.nvim"
  --
  -- Vimspector
  -- use "puremourning/vimspector"

  use { -- file tree explorer
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    commit = "99d65afd6ef05cc57f835451126e5c44db03cef1",
    config = function()
      require("plugins.nvim-tree").setup()
    end,
  }
  use { -- whichkey
    "folke/which-key.nvim",
    event = "BufWinEnter",
    config = function()
      require("plugins.which-key").setup()
    end,
  }
  use { -- commenter
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
      require("plugins.comment").setup()
    end,
  }
  use { -- colorizer
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("plugins.colorizer").setup()
    end,
  }
  use { -- toggleterm
    "akinsho/toggleterm.nvim",
    event = "BufWinEnter",
    config = function()
      require("plugins.terminal").setup()
    end,
  }
  use { -- dashboard
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("plugins.alpha").setup()
    end,
  }
  use { -- Indent blankline
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("plugins.blankline").setup()
    end,
  }
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
  use { -- nvim tmux helper
    "aserowy/tmux.nvim",
    config = function()
      require("plugins.tmux").setup()
    end,
  }
  use { -- better increment and decrement
    "monaqa/dial.nvim",
    event = "BufRead",
    config = function()
      require("plugins.dial").setup()
    end,
  }
  use { -- markdown preview
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
  use { -- match brackets
    "andymass/vim-matchup",
    commit = "97ffd1a2068049e812ddfd04b182f6a93c2c0394",
    event = "CursorMoved",
    config = function()
      require("plugins.matchup").setup()
    end,
  }
  use { -- underline word under cursor
    "itchyny/vim-cursorword",
    event = { "BufEnter", "BufNewFile" },
    config = function()
      require("plugins.cursorword").setup()
    end,
  }
  use { -- open urls with gx
    "felipec/vim-sanegx",
    event = "BufRead",
  }
  use { -- live edit html, css and javascript
    "turbio/bracey.vim",
    cmd = { "Bracey", "BracyStop", "BraceyReload", "BraceyEval" },
    run = "npm install --prefix server",
  }
  use { -- automatically create dir for file if non existent
    "jghauser/mkdir.nvim",
    event = "BufWritePre",
    config = function()
      require "mkdir"
    end,
  }
  use { -- cheatsheet
    "RishabhRD/nvim-cheat.sh",
    requires = "RishabhRD/popfix",
    config = function()
      vim.g.cheat_default_window_layout = "float"
    end,
    cmd = { "Cheat", "CheatWithoutComments", "CheatList", "CheatListWithoutComments" },
    keys = "<leader>?",
  }
  use { -- impatient
    "lewis6991/impatient.nvim",
    config = function()
      require("plugins.impatient").setup()
    end,
  }
  use { -- session manager
    "Shatur/neovim-session-manager",
    config = function()
      require("plugins.session-manager").setup()
    end,
  }
  use {
    "vimwiki/vimwiki",
    branch = "dev",
    config = function()
      vim.g.vimwiki_global_ext = 0
      vim.g.vimwiki_markdown_link_ext = 1
      vim.g.vimwiki_list = {
        {
          path = "~/notes",
          syntax = "markdown",
          ext = ".md",
          template_path = "~/notes/templates/",
          template_default = "default",
          path_html = "~/notes/site_html/",
          custom_wiki2html = "vimwiki_markdown",
          html_filename_parameterization = 1,
          template_ext = ".tpl",
        },
      }
    end,
  }
  use "kevinhwang91/nvim-bqf"
  use "tpope/vim-surround" -- change surroundings
  use "folke/zen-mode.nvim" -- zen mode
  use "tpope/vim-repeat" -- repeat with '.'
  use "b0o/SchemaStore.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
