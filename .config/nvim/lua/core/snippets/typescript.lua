local ls = require("luasnip")
local snippet_collection = require("luasnip.session.snippet_collection")
local extras = require("luasnip.extras")

local i = ls.insert_node
local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local t = ls.text_node
local c = ls.choice_node
local rep = extras.rep

snippet_collection.clear_snippets("typescript")

-- Todo: the import should check if there is already a line which imports react if so the import should be added to that line
-- Todo: should be able to automatically fill in props automatically based on interface details
-- Probably possible to parse it with treesitter, but how do I add an unknown amount of keys in the interface?

ls.add_snippets("typescript", {
	s("cl", fmt("console.log({});", i(1))),
	s(
		"fc",
		fmt(
			[[
    import {{ FC }} from 'react';

    {}interface {}Props {{
      {}
    }}
    
    export const {}: FC<{}Props> ({{ {} }}) => {{ 
      return(<div/>);
    }};

  ]],
			{
				c(1, { t("export "), t("") }),
				i(2),
				i(3),
				rep(2),
				rep(2),
				i(0),
			}
		)
	),
})
