return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  version = false, -- last version is super old
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", { "nvim-treesitter/nvim-treesitter-context", opts = {} } },
  opts = {
    -- ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    auto_install = true, -- automatically install missing parsers when entering a buffer.
    indent = { enable = true },
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { "latex" }, -- list of language that will be disabled
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
    matchup = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          ["af"] = "@function.outer", -- select from current position until end of function
          ["if"] = "@function.inner", -- select from current position until end of fuction but without
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner", -- swap with item underneed
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner", -- swap with item above
        },
      },
    },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
    },
    autotag = {
      enable = true,
    },
  },
}
