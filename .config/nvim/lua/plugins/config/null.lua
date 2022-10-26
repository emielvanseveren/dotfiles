local null_ls = require 'null-ls'

-- we need to have prettierd, eslintd stylua installed
-- the reason it is prettierD is it runs prettier as a daemon. Without it running as a daemon it takes a while to start.
null_ls.setup {
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.code_actions.gitsigns,
  },
}
