require("core.autocmd")
require("core.options")

require("core.snippets.rust")
require("core.snippets.typescript")

require("plugins")
require("impatient") -- FASTERRRRRR
require("plugins.config.luasnip")
require("plugins.config.dap")
require("plugins.config.cmp")
require("plugins.config.null")
require("plugins.config.lsp")
require("plugins.config.lualine")
require("plugins.config.nvimtree")
require("plugins.config.other")
require("plugins.config.telescope")
require("plugins.config.treesitter")

-- requires extensions to be loaded
require("core.mappings")

vim.cmd([[colorscheme dracula]])
