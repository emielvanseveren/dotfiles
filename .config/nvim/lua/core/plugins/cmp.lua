return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    version = "v1.*",
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local modes = { "i", "s", "c" }
    local function border(hl_name)
      return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
      }
    end

    local mappings = {
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), modes),
      ["<C-e>"] = cmp.mapping(cmp.mapping.abort(), modes),
      ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), modes),
      ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), modes),
      -- Intellij like mapping
      -- If no completion is selected, insert the first one in the list,
      -- If a completion is selected insert this one.
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          if not entry then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            cmp.confirm()
          end
        else
          fallback()
        end
      end, modes),
    }

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert(mappings),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "path" },
      }),
      formatting = {
        format = require("lspkind").cmp_format({
          mode = "symbol_text",
        }),
      },
      window = {
        completion = {
          -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          col_offset = -3,
          side_padding = 0,
          border = border("CmpBorder"),
        },
        documentation = {
          -- no border, native-style scrollbar
          border = nil,
          scrollbar = "",
        },
        confirmation = { completeopt = "menu,menuone,noinsert" },
      },
    })

    -- Completion for command mode
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(mappings),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
        },
      }),
    })

    -- Completion for / search based on current buffer
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(mappings),
      sources = cmp.config.sources({
        { name = "buffer" },
      }),
    })
  end,
}
