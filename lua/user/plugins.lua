local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print("Installing packer close and reopen Neovim...")
end

-- Autocommand that reloads neovim whenever you save the plugins.file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({border = 'single'})
    end
  }
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use {'wbthomason/packer.nvim'} -- Have packer manage itself
  use {'nvim-lua/plenary.nvim'}
  use {'nvim-lua/popup.nvim'} -- An implementation of the Popup API from vim in Neovim
  use { -- Treesitter
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    event = "BufWinEnter",
    config = function(blam)
      require('plugins.treesitter').config()
    end,
  }
  use {'kyazdani42/nvim-web-devicons'} -- Web devicons needed for a lot of plugins
  use {'windwp/nvim-ts-autotag', event = "InsertEnter", after = "nvim-treesitter"} -- TS autotag/autorename plugin
  use {'p00f/nvim-ts-rainbow', after = "nvim-treesitter"} -- TS rainbow plugin
  use { -- Lualine
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    event = "BufWinEnter",
    config = function()
      require('plugins.lualine').config()
    end,
  }

  -- CMP / LSP
  use {'neovim/nvim-lspconfig'}
  use {'hrsh7th/cmp-nvim-lsp'}
  use {'hrsh7th/cmp-nvim-lua'}
  use {'hrsh7th/cmp-buffer'}
  use {'hrsh7th/cmp-path'}
  use {'hrsh7th/cmp-cmdline'}
  use {'hrsh7th/cmp-vsnip'}
  use {'hrsh7th/vim-vsnip'}
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require('lsp.cmp').config()
    end,
    requires = {'L3MON4D3/LuaSnip', 'rafamadriz/friendly-snippets'}
  }
  use {'rafamadriz/friendly-snippets'}
  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require("luasnip/loaders/from_vscode").lazy_load()
    end
  }
  use {'saadparwaiz1/cmp_luasnip'}

  -- LSP Installer
  use {'williamboman/nvim-lsp-installer'}
  use {'onsails/lspkind-nvim'}
  use { -- Colorscheme
    'folke/tokyonight.nvim',
    config = function()
      require('plugins.colorscheme').setup()
    end
  }
  use { -- Buffer status bar
    'romgrk/barbar.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    event = "BufWinEnter",
    config = function()
      require('plugins.barbar').config()
    end,
  }
  use { -- File tree explorer
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins.nvim-tree').config()
    end,
  }
  use { -- Nvim autopairs
    'windwp/nvim-autopairs',
    config = function()
      require('plugins.autopairs').config()
    end,
  }
  use { -- Whichkey
    'folke/which-key.nvim',
    event = 'BufWinEnter',
    config = function()
      require('plugins.which-key').setup()
    end,
  }
  use { -- Telescope
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    cmd = "Telescope",
    config = function()
      require("plugins.telescope").setup()
    end
  }
  use { -- FZF telescope plugin
    'nvim-telescope/telescope-fzf-native.nvim'
  }
  use { -- Projects telescope plugin
    'nvim-telescope/telescope-project.nvim'
  }
  use { -- VSCode like renamer
    'filipdutescu/renamer.nvim',
    config = function()
      require('plugins.renamer').config()
    end
  }
  use { -- Commenter
    'numToStr/Comment.nvim',
    event = "BufRead",
    config = function()
      require('plugins.comment').setup()
    end,
  }
  use { -- Colorizer
    'norcalli/nvim-colorizer.lua',
    event = "BufRead",
    config = function()
      require('plugins.colorizer').setup()
    end,
  }
  use { -- Gitsigns
    'lewis6991/gitsigns.nvim',
    event = "BufRead",
    config = function()
      require('plugins.gitsigns').setup()
    end,
  }
  use { -- Toggleterm
    'akinsho/toggleterm.nvim',
    event = "BufWinEnter",
    config = function()
      require('plugins.terminal').setup()
    end,
  }
  use { -- Dashboard
    'glepnir/dashboard-nvim',
    cmd = "Dashboard",
    event = "BufWinEnter",
    config = function()
      require('plugins.dashboard').setup()
    end,
  }
  use { -- Recent projects
    'ahmedkhalf/project.nvim',
    config = function()
      require('plugins.project').setup()
    end
  }
  use { -- Indent blankline
    'lukas-reineke/indent-blankline.nvim',
    event = "BufRead",
    config = function()
      require('plugins.blankline').setup()
    end,
  }
  use { -- Formatter
    'lukas-reineke/format.nvim',
    cmd = "Format",
    config = function()
      require('plugins.formatter').setup()
    end,
  }
  use { -- hop
    'phaazon/hop.nvim',
    branch = 'v1',
    config = function ()
      require('plugins.hop').setup()
    end
  }
  use { -- diffview
    'sindrets/diffview.nvim',
    event = 'BufRead',
    requires = 'nvim-lua/plenary.nvim'
  }
  use { -- git-blame
    'f-person/git-blame.nvim',
    config = function ()
      require('plugins.git-blame').setup()
    end
  }
  use {
    "mattn/vim-gist",
    event = "BufRead",
    requires = "mattn/webapi-vim",
    config = function ()
      require('plugins.vim-gist').setup()
    end
  }
  use {'tpope/vim-surround'} -- Change surroundings
  use {'folke/zen-mode.nvim'} -- Zen mode

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then require('packer').sync() end
end)
