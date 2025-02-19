return {

  {
    'saghen/blink.compat',
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = '*',
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      { 'L3MON4D3/LuaSnip', version = 'v2.*' },
      { 'Kaiser-Yang/blink-cmp-dictionary', dependencies = { 'nvim-lua/plenary.nvim' } },
    },

    -- use a release tag to download pre-built binaries
    version = '*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    build = 'nix run .#build-plugin',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = { preset = 'default' },
      completion = {
        trigger = {
          show_on_trigger_character = true,
        },
        accept = { auto_brackets = { enabled = true } },
        list = { selection = {
          preselect = function(ctx)
            return ctx.mode ~= 'cmdline'
          end,
        } },
      },

      fuzzy = {
        prebuilt_binaries = {
          download = false,
          ignore_version_mismatch = true,
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },

      signature = {
        enabled = true,
        window = {
          show_documentation = true,
        },
      },
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lsp', 'neorg', 'dictionary', 'path', 'snippets', 'buffer' }, -- , 'avante_commands', 'avante_mentions', 'avante_files'
        providers = {
          neorg = {
            name = 'neorg',
            module = 'blink.compat.source',
          },
          dictionary = {
            module = 'blink-cmp-dictionary',
            name = 'Dict',
            -- Make sure this is at least 2.
            -- 3 is recommended
            min_keyword_length = 3,
            opts = {
              -- options for blink-cmp-dictionary
            },
          },
          -- avante_commands = {
          --   name = 'avante_commands',
          --   module = 'blink.compat.source',
          --   score_offset = 90, -- show at a higher priority than lsp
          --   opts = {},
          -- },
          -- avante_files = {
          --   name = 'avante_files',
          --   module = 'blink.compat.source',
          --   score_offset = 100, -- show at a higher priority than lsp
          --   opts = {},
          -- },
          -- avante_mentions = {
          --   name = 'avante_mentions',
          --   module = 'blink.compat.source',
          --   score_offset = 1000, -- show at a higher priority than lsp
          --   opts = {},
          -- },
        },
      },
    },
    opts_extend = { 'sources.default' },
  },
}
