--[[
  File: mason.lua
  Description: Mason plugin configuration (with lspconfig)
  See: https://github.com/williamboman/mason.nvim
]]

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason.setup({
  ensure_installed = {
    "stylua",     -- Formatter Lua
    "shfmt",      -- Formatter Shell Scripts
    "fixjson",    -- Formatter Json
    "black",      -- Formatter Pyhton
    "isort",      -- Formatter Pyhton
    "prettierd",  -- Formatter many
    "write-good", -- Markdown Linter
    "flake8",     -- Python Linter
    "tsc",        -- typescript Linter
    "selene",     -- Lua Linter
    "shellchek",  -- Shill Script Linter
  }
})
mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",    -- LSP for Lua language
    "tsserver",  -- LSP for Typescript and Javascript
    "emmet_ls",  -- LSP for Emmet (Vue, HTML, CSS)
    "cssls",     -- LSP for CSS
    "pyright",   -- LSP for Python
    "gopls",     -- LSP for Go
    "omnisharp", -- LSP for C#
  }
});

-- Setup every needed language server in lspconfig
mason_lspconfig.setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {
    }
  end,

  ["lua_ls"] = function()
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      }
    }
  end,
  ["omnisharp"] = function()
    lspconfig.omnisharp.setup {
      capabilities = {
        semanticTokenProviders = {
          full = vim.empty_dict(),
          legend = {
            tokenModifiers = { "static_symbol" },
            tokenTypes = {
              "comment",
              "excluded_code",
              "identifier",
              "keyword",
              "keyword_control",
              "number",
              "operator",
              "operator_overloaded",
              "preprocessor_keyword",
              "string",
              "whitespace",
              "text",
              "static_symbol",
              "preprocessor_text",
              "punctuation",
              "string_verbatim",
              "string_escape_character",
              "class_name",
              "delegate_name",
              "enum_name",
              "interface_name",
              "module_name",
              "struct_name",
              "type_parameter_name",
              "field_name",
              "enum_member_name",
              "constant_name",
              "local_name",
              "parameter_name",
              "method_name",
              "extension_method_name",
              "property_name",
              "event_name",
              "namespace_name",
              "label_name",
              "xml_doc_comment_attribute_name",
              "xml_doc_comment_attribute_quotes",
              "xml_doc_comment_attribute_value",
              "xml_doc_comment_cdata_section",
              "xml_doc_comment_comment",
              "xml_doc_comment_delimiter",
              "xml_doc_comment_entity_reference",
              "xml_doc_comment_name",
              "xml_doc_comment_processing_instruction",
              "xml_doc_comment_text",
              "xml_literal_attribute_name",
              "xml_literal_attribute_quotes",
              "xml_literal_attribute_value",
              "xml_literal_cdata_section",
              "xml_literal_comment",
              "xml_literal_delimiter",
              "xml_literal_embedded_expression",
              "xml_literal_entity_reference",
              "xml_literal_name",
              "xml_literal_processing_instruction",
              "xml_literal_text",
              "regex_comment",
              "regex_character_class",
              "regex_anchor",
              "regex_quantifier",
              "regex_grouping",
              "regex_alternation",
              "regex_text",
              "regex_self_escaped_character",
              "regex_other_escape",
            },
          },
          range = true,
        },
      },
    }
  end,
}
