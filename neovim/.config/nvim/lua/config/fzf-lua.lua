local ok, fzf = pcall(require, 'fzf-lua')
if not ok then
  return
end

local actions = require 'fzf-lua.actions'
local trouble_actions = require('trouble.sources.fzf').actions

fzf.setup {
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
    -- backddrop = 10, Todo check what that is
    preview = {
      --border = 'noborder',
    },
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

vim.keymap.set('n', '<leader><space>', function()
  vim.cmd 'FzfLua files'
end, { desc = 'files' })
vim.keymap.set('n', '<leader>ff', function()
  vim.cmd 'FzfLua'
end, { desc = '[f]zfLua' })
vim.keymap.set('n', '<leader>fs', function()
  vim.cmd 'FzfLua live_grep_native'
end, { desc = '[s]tring' })
vim.keymap.set('n', '<leader>fr', function()
  vim.cmd 'FzfLua resume'
end, { desc = '[r]esume' })
vim.keymap.set('n', '<leader>fw', function()
  vim.cmd 'FzfLua grep_cWORD'
end, { desc = '[w]ord' })
vim.keymap.set('n', '<leader>fi', function()
  require('fzf-lua').lsp_implementations { jump_to_single_result = true }
end, { desc = '[i]mplementations' })
vim.keymap.set('n', '<leader>ca', function()
  require('fzf-lua').lsp_code_actions { winopts = { height = 0.25, width = 0.8 } }
end, { desc = '[c]ode [a]ctions' })
vim.keymap.set('n', 'gr', function()
  require('fzf-lua').lsp_references { sync = true, ignore_current_line = true, includeDeclaration = false, jump_to_single_result = true }
end, { desc = '[r]eferences' })
vim.keymap.set('n', 'gd', function()
  require('fzf-lua').lsp_definitions { sync = true, ignore_current_line = true, includeDeclaration = false, jump_to_single_result = true }
end, { desc = '[d]efinitions' })
vim.keymap.set('v', '<C-s>', function() vim.cmd 'FzfLua grep_visual' end, { desc = 'Resume'})
