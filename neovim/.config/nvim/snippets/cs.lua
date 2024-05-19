local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require "luasnip.extras.fmt".fmt

local mysplit = function(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end


local find_namespace = function()
  local file_path = mysplit(vim.fn.expand("%"), "/")
  local is_in_namespace = false
  local len = #file_path
  local namespace = ''
  vim.inspect(file_path)
  for k, v in pairs(file_path) do
    if k == len then goto continue end
    if not is_in_namespace then
      if v == "src" or v == "test" then
        is_in_namespace = true
        goto continue
      end
    end

    if is_in_namespace then
      if namespace == '' then
        namespace = v
      else
        namespace = namespace .. "." .. v
      end
    end

    ::continue::
  end

  return namespace
end


local get_file_name = function()
  local file_path = mysplit(vim.fn.expand("%:t"), ".")

  return file_path[1]
end

local snippets, autosnippets = {}, {}


local new_class =
    s(
      "clas", fmt(
        [[
    namespace {};

    public class {}
    {{
        {}
    }}
    ]], {
          f(find_namespace),
          f(get_file_name), i(0)
        }
      )
    )
table.insert(snippets, new_class)


local if_snippet =
    s("if", fmt(
      [[
    if ({})
    {{
        {}
    }}
    ]]
      , { i(1), i(0) }))
table.insert(snippets, if_snippet)

local foreach =
    s(
      "fore", fmt(
        [[
  foreach (var {} in {})
  {{
      {}
  }}
  ]], { i(2), i(1), i(0) }))
table.insert(snippets, foreach)

-- local test =
-- s("test", fmt(
--   [[
--   [Test]
--   public {} {}()
--   {{
--
--     // Arrange
--
--     // Act
--
--     // Assert
--   }}
--   ]], {
--     c(1, {
--       t("void"),
--       t("async Task"),
--     }),
--     i(0),
--   }))
-- table.insert(snippets, test)

local trig =  s("trig", c(1, {
 	t("Ugh boring, a text node"),
 	i(nil, "At least I can edit something now..."),
 	f(function(args) return "Still only counts as text!!" end, {})
 }))table.insert(snippets, trig)





return snippets, autosnippets
