local ls = require("luasnip")
local types = require("luasnip.util.types")

------------------------- 
-- setup
------------------------- 

ls.config.set_config({
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updates as you type
  updateevents = "TextChanged,TextChangedI",
  
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<--", "Error" } },
      },
    },
  },
})

-- Add support for typescript react
ls.filetype_extend("typescript", { "typescriptreact"})

------------------------- 
-- keymaps
------------------------- 

-- This will expand the current item or jump to the next item within the snippet.
vim.keymap.set({"i", "s"}, "<c-n>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- This allows moves to the previous item within the snippet.
vim.keymap.set({"i", "s"}, "<c-p>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true})

-- This is usefful for choice nodes. 
-- It is selectin within a list of options.
vim.keymap.set("i", "<c-l>", function()
    if ls.choice_active() then
      ls.change_choice(1)
  end
end
)

-- shortcut to source my luasnips file again, which will reload my snippets (handy while changing snippets)
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/plugins/config/luasnip.lua <CR>")

-- snippets
--ls.snippets {
--  all = {
    
--  }
-- }

