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
  { "dracula/vim" },
  { "danilamihailov/beacon.nvim" },
  { "kyazdani42/nvim-web-devicons", lazy = true },

  -- ========================================
  -- # Telescope
  -- ========================================
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/popup.nvim" } },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
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
  {
    "TimUntersberger/neogit",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      local neogit = require("neogit")
      neogit.setup({
        integrations = {
          diffview = true,
        },
      })
      vim.keymap.set("n", "<leader>g", neogit.open)
    end,
  },
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
  { "lewis6991/gitsigns.nvim" },

  -- ========================================
  -- # DAP
  -- ========================================
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
  { "theHamsta/nvim-dap-virtual-text" },

  -- ========================================
  -- # Other
  -- ========================================
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },
  { "kyazdani42/nvim-tree.lua", dependencies = { "kyazdani42/nvim-web-devicons" } },

  { "nvim-lua/plenary.nvim" },
  { "L3MON4D3/LuaSnip", version = "v1.*" },
  { "lewis6991/impatient.nvim" },
  { "folke/neodev.nvim" },
  {
    "akinsho/nvim-bufferline.lua",
    version = "v3.*",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },
  { "github/copilot.vim" },
  { "nathom/filetype.nvim" },
  { "andweeb/presence.nvim" },
  { "lervag/vimtex" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", event = { "BufReadPost", "BufNewFile" } },
  { "nvim-treesitter/nvim-treesitter-textobjects", event = "InsertEnter" },
  { "nvim-treesitter/nvim-treesitter-context" },
  { "famiu/bufdelete.nvim" },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("indent_blankline").setup({
        buftype_exclude = { "terminal" },
        filetype_exclude = { "startify", "help", "dashboard", "Outline" },
        indent_blankline_use_treesitter = true,
        indent_blankline_show_current_context = true,
      })
    end,
  },

  {
    "stevearc/aerial.nvim",
    lazy = true,
    config = function()
      require("aerial").setup({
        on_attach = function()
          -- currently using `(` and `)` to navigate errors
          -- vim.keymap.set("n", "(", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          -- vim.keymap.set("n", ")", "<cmd>AerialNext<CR>", { buffer = bufnr })
          vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle<CR>")
        end,
      })
    end,
  },

  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  },

  {
    "numtoStr/Comment.nvim",
    config = function()
      -- keymaps to remember:
      -- comment current line: gcc
      -- linewise comment visual selection -> gc
      -- blockwise comment visual seleciton -> gb
      require("Comment").setup()
    end,
  },

  {
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup()
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}

require("lazy").setup(plugins, {})
