local ok, fzf = pcall(require, 'fzf-lua')
if not ok then
  return
end

local actions = require 'fzf-lua.actions'
local trouble_actions = require('trouble.sources.fzf').actions

fzf.setup {
  grep = {
    rg_glob = true,
    glob_flag = '--iglob',
    glob_separator = '%s%-%-',
  },
  winopts_fn = function()
    return {
      width = vim.o.columns > 80 and 0.75 or 0.95,
      height = vim.o.lines > 30 and 0.5 or 0.8,
    }
  end,

  winopts = {
    hl = { normal = 'Pmenu' },
    split = 'belowright new',
    border = 'none',
  },
  fzf_opts = {
    ['--highlight-line'] = true,
    ['--border'] = 'none',
    -- ['--no-info'] = '',
    -- ['--info'] = 'hidden',
    -- ['--padding'] = '13%,5%,13%,5%',
    -- ['--header'] = ' ',
    -- ['--no-scrollbar'] = '',
  },
  actions = {
    files = {
      ['default'] = actions.file_edit,
      ['ctrl-s'] = actions.file_split,
      ['ctrl-v'] = actions.file_vsplit,
      ['ctrl-q'] = actions.file_sel_to_qf,
      ['ctrl-t'] = trouble_actions.open,
    },
  },
  files = {
    formatter = 'path.filename_first',
    git_icons = true,
    prompt = 'files:',
    --preview_opts = 'hidden',
    winopts = {
      split = 'belowright new',
    },
    no_header = true,
    cwd_header = false,
    --cwd_prompt = false,
    -- cwd = require('utils').git_root(),
    actions = {
      ['ctrl-d'] = function(...)
        fzf.actions.file_vsplit(...)
        vim.cmd 'windo diffthis'
        local switch = vim.api.nvim_replace_termcodes('<C-w>h', true, false, true)
        vim.api.nvim_feedkeys(switch, 't', false)
      end,
    },
  },
  previewers = {
    builtin = {
      extensions = {
        ['png'] = { 'viu', '-b' },
        ['jpg'] = { 'ueberzug' },
        ['jpeg'] = { 'ueberzug' },
      },
    },
  },
}
--   buffers = {
--     formatter = 'path.filename_first',
--     prompt = 'buffers:',
--     preview_opts = 'hidden',
--     no_header = true,
--     fzf_opts = { ['--delimiter'] = ' ', ['--with-nth'] = '-1..' },
--   },
--   helptags = {
--     prompt = '💡:',
--     preview_opts = 'hidden',
--     winopts = {
--       row = 1,
--       width = vim.api.nvim_win_get_width(0),
--       height = 0.3,
--     },
--   },
--   git = {
--     bcommits = {
--       prompt = 'logs:',
--       cmd = "git log --color --pretty=format:'%C(yellow)%h%Creset %Cgreen%><(12)%cr%><|(12)%Creset %s' <file>",
--       preview = "git show --stat --color --format='%C(cyan)%an%C(reset)%C(bold yellow)%d%C(reset): %s' {1} -- <file>",
--       actions = {
--         ['ctrl-d'] = function(...)
--           fzf.actions.git_buf_vsplit(...)
--           vim.cmd 'windo diffthis'
--           local switch = vim.api.nvim_replace_termcodes('<C-w>h', true, false, true)
--           vim.api.nvim_feedkeys(switch, 't', false)
--         end,
--       },
--       preview_opts = 'nohidden',
--       winopts = {
--         preview = {
--           layout = 'vertical',
--           vertical = 'right:50%',
--           wrap = 'wrap',
--         },
--         row = 1,
--         width = vim.api.nvim_win_get_width(0),
--         height = 0.3,
--       },
--     },
--     branches = {
--       prompt = 'branches:',
--       cmd = 'git branch --all --color',
--       winopts = {
--         preview = {
--           layout = 'vertical',
--           vertical = 'right:50%',
--           wrap = 'wrap',
--         },
--         row = 1,
--         width = vim.api.nvim_win_get_width(0),
--         height = 0.3,
--       },
--     },
--   },
--   autocmds = {
--     prompt = 'autocommands:',
--     winopts = {
--       width = 0.8,
--       height = 0.7,
--       preview = {
--         layout = 'horizontal',
--         horizontal = 'down:40%',
--         wrap = 'wrap',
--       },
--     },
--   },
--   keymaps = {
--     prompt = 'keymaps:',
--     winopts = {
--       width = 0.8,
--       height = 0.7,
--     },
--     actions = {
--       ['default'] = function(selected)
--         local lines = vim.split(selected[1], '│', {})
--         local mode, key = lines[1]:gsub('%s+', ''), lines[2]:gsub('%s+', '')
--         vim.cmd('verbose ' .. mode .. 'map ' .. key)
--       end,
--     },
--   },
--   highlights = {
--     prompt = 'highlights:',
--     winopts = {
--       width = 0.8,
--       height = 0.7,
--       preview = {
--         layout = 'horizontal',
--         horizontal = 'down:40%',
--         wrap = 'wrap',
--       },
--     },
--     actions = {
--       ['default'] = function(selected)
--         print(vim.cmd.highlight(selected[1]))
--       end,
--     },
--   },
--   lsp = {
--     code_actions = {
--       prompt = 'code actions:',
--       winopts = {
--         width = 0.8,
--         height = 0.7,
--         preview = {
--           layout = 'horizontal',
--           horizontal = 'up:75%',
--         },
--       },
--     },
--   },
--   registers = {
--     prompt = 'registers:',
--     preview_opts = 'hidden',
--     winopts = {
--       width = 0.8,
--       height = 0.7,
--       preview = {
--         layout = 'horizontal',
--         horizontal = 'down:45%',
--       },
--     },
--   },
-- }
