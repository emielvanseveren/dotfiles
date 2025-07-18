return {
  "hrsh7th/nvim-cmp",
  -- not sure what the event here should be, we cant use insertEnter because we also use it in the command line
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    --version = "v1.*",
    "onsails/lspkind.nvim",
  },
  event = { "InsertEnter", "CmdlineEnter" },
  opts = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
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
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), modes),
      ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), modes),

      -- https://github.com/hrsh7th/nvim-cmp/commit/93cf84f7deb2bdb640ffbb1d2f8d6d412a7aa558
      ["<c-y>"] = cmp.config.disable,
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
      mapping = cmp.mapping.preset.insert(mappings),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "path" },
      }),
      formatting = {
        expandable_indicator = true,
        fields = { 'abbr', 'kind', 'menu' },
        format = require("lspkind").cmp_format({
          mode = "symbol_text",
        }),
      },
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
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
