local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

-- ls.add_snippets('cs', {
--   s(
--     'fun',
--     fmt(
--       [[
--     {1} {2}
--     {
--       {0}
--     }
--
--   ]],
--       {
--         c(1, {
--           t 'public ',
--           t 'private ',
--         }),
--         c(2, {
--           fmt 'async Task ',
--           fmt 'private ',
--         }),
--       }
--     )
--   ),
-- })
