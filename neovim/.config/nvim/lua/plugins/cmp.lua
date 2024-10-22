return {
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  {
    'saadparwaiz1/cmp_luasnip',
    dependencies = { 'L3MON4D3/LuaSnip' },
  },
  { 'hrsh7th/cmp-nvim-lsp' },
  {
    'iguanacucumber/magazine.nvim',
    name = 'nvim-cmp', -- Otherwise highlighting gets messed up
    version = false, -- last release is way too old
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    -- Not all LSP servers add brackets when completing a function.
    -- To better deal with this, LazyVim adds a custom option to cmp,
    -- that you can configure. For example:
    --
    -- ```lua
    -- opts = {
    --   auto_brackets = { "python" }
    -- }
    -- ```
    opts = function()
      vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
      local cmp = require 'cmp'
      local defaults = require 'cmp.config.default'()
      local auto_select = true
      return {
        auto_brackets = {}, -- configure any filetype to auto add brackets
        completion = {
          completeopt = 'menu,menuone,noinsert' .. (auto_select and '' or ',noselect'),
        },
        preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert {
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-z>'] = cmp.mapping.complete(),
          ['<CR>'] = require('extras.utils').confirm { select = auto_select },
          ['<C-y>'] = require('extras.utils').confirm { select = true },
          ['<S-CR>'] = require('extras.utils').confirm { behavior = cmp.ConfirmBehavior.Replace }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<C-CR>'] = function(fallback)
            cmp.abort()
            fallback()
          end,
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'easy-dotnet' },
          { name = 'path' },
          { name = 'buffer' },
        },
        formatting = {
          format = function(entry, item)
            if MiniIcons.get('lsp', item.kind) then
              item.kind = MiniIcons.get('lsp', item.kind) .. ' ' .. item.kind
            end

            local widths = {
              abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
              menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
            }

            for key, width in pairs(widths) do
              if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. '…'
              end
            end

            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = 'CmpGhostText',
          },
        },
        sorting = {
          comparators = {
            -- With cmp you chain comparators.
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            -- I added my comparator here.
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      }
    end,
  },
  -- {
  --   'folke/noice.nvim',
  --   event = 'VeryLazy',
  --   opts = {
  --     lsp = {
  --       override = {
  --         ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
  --         ['vim.lsp.util.stylize_markdown'] = true,
  --         ['cmp.entry.get_documentation'] = true,
  --       },
  --     },
  --     routes = {
  --       {
  --         filter = {
  --           event = 'msg_show',
  --           any = {
  --             { find = '%d+L, %d+B' },
  --             { find = '; after #%d+' },
  --             { find = '; before #%d+' },
  --           },
  --         },
  --         view = 'mini',
  --       },
  --     },
  --     presets = {
  --       bottom_search = true,
  --       command_palette = true,
  --       long_message_to_split = true,
  --     },
  --   },
  -- -- stylua: ignore
  -- keys = {
  --   { "<leader>sn", "", desc = "+noice"},
  --   { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
  --   { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
  --   { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
  --   { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
  --   { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
  --   { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
  --   { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
  --   { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
  -- },
  --   config = function(_, opts)
  --     -- HACK: noice shows messages from before it was enabled,
  --     -- but this is not ideal when Lazy is installing plugins,
  --     -- so clear the messages in this case.
  --     if vim.o.filetype == 'lazy' then
  --       vim.cmd [[messages clear]]
  --     end
  --     require('noice').setup(opts)
  --   end,
  -- },
}
