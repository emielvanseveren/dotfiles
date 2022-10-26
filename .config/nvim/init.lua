require("core.autocmd")
require("core.options")
require("core.mappings")

require("plugins")
require("impatient") -- FASTERRRRRR
require("plugins.config.mason")
require("plugins.config.cmp")
require("plugins.config.null")
require("plugins.config.lsp")
require("plugins.config.lualine")
require("plugins.config.nvimtree")
require("plugins.config.other")
require("plugins.config.telescope")
require("plugins.config.treesitter")

vim.cmd [[colorscheme dracula]]
