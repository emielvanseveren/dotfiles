local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_is_bootstrap = ensure_packer()

require("packer").startup(function(use)
  use { "wbthomason/packer.nvim" } -- Packer can manage itself
  -- ========================================
  -- # Gui Enhancements
  -- ========================================
  use { "RRethy/nvim-base16" }
  use { "dracula/vim", as = "dracula" }
  use { "danilamihailov/beacon.nvim" }
  use { "lewis6991/gitsigns.nvim" }
  use { "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } }
  use { "kyazdani42/nvim-tree.lua", requires = { "kyazdani42/nvim-web-devicons" } }

  -- ========================================
  -- # VIM Enhancements
  -- ========================================
  use { "lukas-reineke/indent-blankline.nvim" }
  use { "nvim-lua/plenary.nvim" }
  use { "L3MON4D3/LuaSnip" }
  use { "lewis6991/impatient.nvim" }
  use { "phaazon/hop.nvim", branch = "v2" }
  use { "akinsho/nvim-bufferline.lua", tag = "v3.*", requires = { "kyazdani42/nvim-web-devicons" } }

  -- ========================================
  -- # Telescope
  -- ========================================
  use { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/popup.nvim" } }
  use { "nvim-telescope/telescope-project.nvim" }
  use { "nvim-telescope/telescope-fzy-native.nvim" }
  use { "nvim-telescope/telescope-ui-select.nvim" }

  -- ========================================
  -- # LSP
  -- ========================================
  use { "neovim/nvim-lspconfig" }
  use { "hrsh7th/nvim-cmp" }
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-path" }
  use { "hrsh7th/cmp-cmdline" }
  use { "hrsh7th/cmp-buffer" }
  use { "hrsh7th/cmp-nvim-lua" }
  use { "hrsh7th/cmp-nvim-lsp-signature-help" }
  use { "saadparwaiz1/cmp_luasnip" }
  use { "onsails/lspkind.nvim" }
  use { "simrat39/rust-tools.nvim" }
  use { "RishabhRD/nvim-lsputils" }
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }
  use { "jose-elias-alvarez/null-ls.nvim" }


  -- ========================================
  -- # Git
  -- ========================================
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- ========================================
  -- # Other
  -- ========================================
  use { "github/copilot.vim" }
  use { "andweeb/presence.nvim" }
  use { "antoinemadec/FixCursorHold.nvim" }
  use { "ThePrimeagen/harpoon" }
  use { "lervag/vimtex" }
  use { "AckslD/nvim-neoclip.lua" }
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use { "nvim-treesitter/nvim-treesitter-context" }
  use { "norcalli/nvim-colorizer.lua" }
  use({ "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end })

  -- Automatically set up configuration after cloning packer.nvim
  -- This needs to be done after all plugins.
  if packer_is_bootstrap then
    require("packer").sync()
  end
end)

if packer_is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end
