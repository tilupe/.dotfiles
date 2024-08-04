local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require "luasnip.extras.fmt".fmt


local snippets, autosnippets = {}, {}


local note =
    s(
      "note", fmt(
    [[
    > [!NOTE]
    > {}
    ]], {
          i(0)
        }
      )
    )
table.insert(snippets, note)

return snippets, autosnippets
