return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",     -- LSP source
    "hrsh7th/cmp-buffer",       -- Buffer text source
    "hrsh7th/cmp-path",         -- File path source
    "L3MON4D3/LuaSnip",         -- Snippet engine (required)
    "saadparwaiz1/cmp_luasnip", -- Snippet source for nvim-cmp
    "onsails/lspkind.nvim",     -- Pretty icons (optional)
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- Manually trigger completion
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept current item
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- Prioritize LSP
        { name = "luasnip" },  -- Then snippets
      }, {
        { name = "buffer" },   -- Then text in current file
        { name = "path" },     -- Then file system paths
      }),
    })
  end,
}
