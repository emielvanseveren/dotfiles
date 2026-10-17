-- nvim-treesitter `main` branch (the rewrite). Requires Nvim 0.12+ and the
-- `tree-sitter` CLI (>= 0.26.1) on $PATH, which compiles parsers locally.
--
-- The rewrite's setup() only accepts `install_dir`; there is no `highlight`,
-- `indent`, `ensure_installed` or `incremental_selection`. Highlighting is opt-in
-- per buffer via vim.treesitter.start(), which is what the FileType autocmd below
-- does. Incremental selection is now built in: an / in / ]n / [n.
local parsers = {
  -- systems / daily drivers
  "rust", "c", "cpp", "python", "lua", "bash", "go",
  -- web
  "typescript", "javascript", "tsx", "html", "css", "xml", "glimmer",
  -- config / data
  "json", "yaml", "toml", "hcl", "terraform", "ssh_config", "kconfig",
  -- build systems
  "cmake", "meson", "ninja", "make", "dockerfile",
  -- embedded / yocto
  "bitbake", "devicetree", "slint",
  -- git
  "diff", "gitcommit", "git_rebase", "gitignore",
  -- docs / markup
  "markdown", "markdown_inline", "latex", "typst", "mermaid",
  -- nvim itself
  "query", "vim", "vimdoc", "regex", "printf", "comment",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSUpdate", "TSUninstall", "TSLog" },
    config = function()
      local ts = require("nvim-treesitter")

      -- Default install_dir is stdpath("data").."/site", which is what we want.
      ts.setup({})

      -- Install only what is missing, so startup is a no-op once warm.
      local installed = require("nvim-treesitter.config").get_installed("parsers")
      local missing = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, parsers)

      if #missing > 0 then
        ts.install(missing, { summary = true })
      end

      -- This is what actually turns treesitter on. Without it you silently fall
      -- back to regex `syntax`.
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("lit_treesitter", { clear = true }),
        desc = "Start treesitter highlighting and indent where a parser exists",
        callback = function(event)
          local lang = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
          if not lang then
            return
          end
          -- pcall: a filetype can map to a parser we chose not to install.
          if pcall(vim.treesitter.start, event.buf, lang) then
            vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
