local ls = require("luasnip")
local snippet_collection = require "luasnip.session.snippet_collection"

local s = ls.s
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

snippet_collection.clear_snippets "rust"

ls.add_snippets("rust",{
s(
    "modtest",
    fmt(
      [[
      #[cfg(test)]
      mod test {{
          use super::*;
          {}
      }}
    ]],
      i(0)
    )
  ),
 s(
    { trig = "test" },
    fmt(
      [[
  #[test]
  fn {}(){}{{
    {}
  }}
  ]],
      {
        i(1, "testname"),
        c(2, {
          t "",
          t " -> Result<()> ",
          -- fmt(" -> {}<()> ", { i(nil, "Result") }),
        }),
        i(0),
      }
    )
  ),
  s("eq", fmt("assert_eq!({}, {});{}", { i(1), i(2), i(0) })),
  s("enum", {
    t { "#[derive(Debug, PartialEq)]", "enum " },
    i(1, "Name"),
    t { " {", "  " },
    i(0),
    t { "", "}" },
  }),

  s("struct", {
    t { "#[derive(Debug, PartialEq)]", "struct " },
    i(1, "Name"),
    t { " {", "    " },
    i(0),
    t { "", "}" },
  }),
})
