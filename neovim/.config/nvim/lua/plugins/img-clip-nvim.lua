print("test")
require("img-clip").setup({
    dir_path = "~/notes/neorg/assets/imgs", ---@type string
})


 vim.keymap.set('n', '<leader>po', function ()
  local oil = require("oil")
  local filename = oil.get_cursor_entry().name
  local dir = oil.get_current_dir()
  oil.close()

  local img_clip = require("img-clip")
  img_clip.paste_image({}, dir .. filename)
 end, { desc = 'Blame' })
