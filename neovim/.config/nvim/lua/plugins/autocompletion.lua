return {
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'BufEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local cmp = require 'cmp'
      local icons = require 'utils.icons'
      local luasnip = require 'luasnip'

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-y>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'neorg' },
        },
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = function(entry, item)
            local max_width = 0
            local source_names = {
              nvim_lsp = '(LSP)',
              path = '(Path)',
              luasnip = '(Snip)',
              buffer = '(Buf)',
            }
            local duplicates = {
              buffer = 1,
              path = 1,
              nvim_lsp = 0,
              luasnip = 1,
            }
            local duplicates_default = 0
            if max_width ~= 0 and #item.abbr > max_width then
              item.abbr = string.sub(item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
            end
            item.kind = icons.kind[item.kind]
            item.menu = source_names[entry.source.name]
            item.dup = duplicates[entry.source.name] or duplicates_default
            return item
          end,
        },
      }
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip').setup()
      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip').filetype_extend('cs', { 'csharpdoc' })
      require('luasnip').filetype_extend('python', { 'pydoc' })
      require('luasnip').filetype_extend('lua', { 'luadoc' })
      require('luasnip').filetype_extend('sh', { 'shelldoc' })
      --require 'snippets.cs'
    end,
  },
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    config = function()
      vim.g.codeium_no_map_tab = 1
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-Space>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-g>', function()
        return vim.fn['codeium#CycleCompletions'](1)
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-t>', function()
        return vim.fn['codeium#CycleCompletions'](-1)
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-x>', function()
        return vim.fn['codeium#Clear']()
      end, { expr = true, silent = true })
    end,
  },
}
