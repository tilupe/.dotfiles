print("test")
require("img-clip").setup({
    -- file and directory options
    default = {
    copy_images = false,
    dir_path = "~/notes/neorg/assets/imgs", ---@type string
    download_images = true,
    drag_and_drop = {
      enabled = true,
      insert_mode = false
    },
    embed_image_as_base64 = false,
    file_name = "%Y-%m-%d-%H-%M-%S",
    insert_mode_after_paste = true,
    max_base64_size = 10,
    process_cmd = "",
    prompt_for_file_name = true,
    relative_template_path = true,
    relative_to_current_file = false,
    show_dir_path_in_prompt = false,
    template = ".image $FILE_PATH", ---@type string
    url_encode_path = false,
    use_absolute_path = true,
    use_cursor_in_template = true
  },

  -- filetype specific options
  filetypes = {
    norg = {
      use_absolute_path = true,
      dir_path = "~/notes/neorg/assets/imgs", ---@type string
      template = ".image ![$CURSOR]($FILE_PATH)", ---@type string
      download_images = false, ---@type boolean
    },
    markdown = {
      url_encode_path = true, ---@type boolean
      template = "![$CURSOR]($FILE_PATH)", ---@type string
      download_images = false, ---@type boolean
    },

    vimwiki = {
      url_encode_path = true, ---@type boolean
      template = "![$CURSOR]($FILE_PATH)", ---@type string
      download_images = false, ---@type boolean
    },

    html = {
      template = '<img src="$FILE_PATH" alt="$CURSOR">', ---@type string
    },

    tex = {
      relative_template_path = false, ---@type boolean
      template = [[
\begin{figure}[h]
  \centering
  \includegraphics[width=0.8\textwidth]{$FILE_PATH}
  \caption{$CURSOR}
  \label{fig:$LABEL}
\end{figure}
    ]], ---@type string
    },

    typst = {
      template = [[
#figure(
  image("$FILE_PATH", width: 80%),
  caption: [$CURSOR],
) <fig-$LABEL>
    ]], ---@type string
    },

    rst = {
      template = [[
.. image:: $FILE_PATH
   :alt: $CURSOR
   :width: 80%
    ]], ---@type string
    },

    asciidoc = {
      template = 'image::$FILE_PATH[width=80%, alt="$CURSOR"]', ---@type string
    },

    org = {
      template = [=[
#+BEGIN_FIGURE
[[file:$FILE_PATH]]
#+CAPTION: $CURSOR
#+NAME: fig:$LABEL
#+END_FIGURE
    ]=], ---@type string
    },
  },

  -- file, directory, and custom triggered options
  files = {}, ---@type table
  dirs = {}, ---@type table
  custom = {}, ---@type table
})


 vim.keymap.set('n', '<leader>po', function ()
  local oil = require("oil")
  local filename = oil.get_cursor_entry().name
  local dir = oil.get_current_dir()
  oil.close()

  local img_clip = require("img-clip")
  img_clip.paste_image({}, dir .. filename)
 end, { desc = 'Blame' })
