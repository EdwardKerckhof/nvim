local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
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
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
)

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { 'wbthomason/packer.nvim' } -- Have packer manage itself
  use { 'nvim-popup.nvim' } -- An implementation of the Popup API from vim in Neovim
  use { 'nvim-plenary.nvim' } -- Useful lua functions used ny lots of plugins
  use { -- Treesitter
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    config = function()
      require('plugins.treesitter').config()
    end,
  }
  use { -- ine
    'nvim-ine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function ()
      require('plugins.lualine').config()
    end
  }
  use { -- Colorscheme
    'folke/tokyonight.nvim',
    config = function()
      require('plugins.colorscheme').config()
    end,
  }
  use {
    'romgrk/barbar.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function ()
      require('plugins.barbar').config()
    end
  }
  use { -- VSCode like renamer
    'filipdutescu/renamer.nvim',
    config = function ()
      require('plugins.renamer').config()
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

