return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "A", },
      change = { text = "C", },
      delete = { text = "D", },
      topdelete = { text = "TD" },
      changedelete = { text = "CD" },
    },
    signs_staged = {
      add = { text = "SA" },
      change = { text = "SC" },
      delete = { text = "SD", },
      topdelete = { text = "STD" },
      changedelete = { text = "SCD" },
    },
    signs_staged_enable = true,
    signcolumn = true,   -- show signs in column
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 1000,
      ignore_whitespace = false,
    },
    linehl = true,
    numhl = true,        -- highlight line number
    word_diff = false,   -- highlight words or letters that changed in changed line.
    attach_to_untracked = true,
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end
      map("n", "ghj", gs.next_hunk, "[g]it [h]unk down[j]")
      map("n", "ghk", gs.prev_hunk, "[g]it [h]unk up[k]")
      map("n", "ghp", gs.preview_hunk, "[g]it [h]nk [p]review")
      map("n", "ghs", gs.stage_hunk, "[g]it [h]unk [s]tage")
      map("n", "ghS", gs.undo_stage_hunk, "[g]it [h]unk un[S]tage")
      map("n", "ghr", gs.reset_hunk, "[g]it [h]unk [r]eset")
    end,
  }
}
