local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")
local pf = require("snippets.util").postfix

local util = require("snippets.util")

local new_lint = function(lint)
  return s({
    trig = "#[" .. lint .. "(…)]",
    desc = "lint levels " .. lint,
  }, {
    t("#[" .. lint .. "("),
    i(1, "dead_code"),
    n(1, ", "),
    i(2, "unused-variables"),
    n(2, ", "),
    i(0),
    t(")]"),
  }, { condition = conds_expand.line_begin })
end

return {
  s({
    trig = "#[derive(…)]",
    desc = "",
    docstring = "#[derive(Debug, Copy, Clone, Default, Eq, PartialEq, Ord, PartialOrd)]",
  }, {
    t("#[derive(Debug, "),
    i(1, "Copy, Clone"),
    n(1, ", "),
    i(2, "Default"),
    n(2, ", "),
    i(3, "Eq, PartialEq, Ord, PartialOrd"),
    n(3, ", "),
    i(0),
    t(")]"),
  }, { condition = conds_expand.line_begin }),
  new_lint("allow"),
  new_lint("warn"),
  new_lint("deny"),
  s(
    {
      trig = 'r#" … "#',
      desc = "",
      docstring = "literal string",
    },
    fmt(
      [[
  r#"
  {}
  "#
  ]],
      {
        i(1, "literal string"),
      }
    )
  ),
  s({
    trig = "Arc::new(…)",
    desc = "Constructs a new `Arc<T>`.",
  }, fmt("Arc::new({}){}", { i(1), i(0) })),
  s({
    trig = "Box::new(…)",
    desc = "Move variable to heap.",
  }, fmt("Box::new({}){}", { i(1), i(0) })),
  s({
    trig = "String::from(…)",
    desc = "Create a `String` from a literal string.",
  }, fmt("String::from({}){}", { i(1), i(0) })),
}
