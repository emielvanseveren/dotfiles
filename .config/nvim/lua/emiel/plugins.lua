-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {

  -- ========================================
  -- # Themes
  -- ========================================
  { "RRethy/nvim-base16" },
  { "dracula/vim", as = "dracula" },
  { "danilamihailov/beacon.nvim" },
  { "kyazdani42/nvim-web-devicons" },

  -- ========================================
  -- # Telescope
  -- ========================================
  { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/popup.nvim" } },
  { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
  { "nvim-telescope/telescope-ui-select.nvim" },
  { "xiyaowong/telescope-emoji.nvim" },

  -- ========================================
  -- # LSP
  -- ========================================
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-nvim-lua" },
  { "hrsh7th/cmp-nvim-lsp-signature-help" },
  { "saadparwaiz1/cmp_luasnip" },
  { "onsails/lspkind.nvim" },
  { "RishabhRD/nvim-lsputils" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "jose-elias-alvarez/null-ls.nvim" },

  -- ========================================
  -- # Git
  -- ========================================
  { "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" },
  { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" },
  { "lewis6991/gitsigns.nvim" },

  -- ========================================
  -- # DAP
  -- ========================================
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } },
  { "theHamsta/nvim-dap-virtual-text" },

  -- ========================================
  -- # Other
  -- ========================================
  { "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } },
  { "kyazdani42/nvim-tree.lua", requires = { "kyazdani42/nvim-web-devicons" } },
  { "lukas-reineke/indent-blankline.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "L3MON4D3/LuaSnip", version = "v1.*" },
  { "lewis6991/impatient.nvim" },
  { "folke/neodev.nvim" },
  {
    "akinsho/nvim-bufferline.lua",
    version = "v3.*",
    requires = { "kyazdani42/nvim-web-devicons" },
  },
  { "github/copilot.vim" },
  { "andweeb/presence.nvim" },
  { "lervag/vimtex" },
  { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
  { "nvim-treesitter/nvim-treesitter-context" },
  { "stevearc/aerial.nvim" },
  { "famiu/bufdelete.nvim" },

  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  },

  {
    "numtoStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "saecki/crates.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup()
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}

require("lazy").setup(plugins, {})
