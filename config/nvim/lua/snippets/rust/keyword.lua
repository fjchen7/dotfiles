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

local for_choice_c = function(pos)
  return c(pos, {
    -- sn(nil, { i(1, "true") }, nil, "true"),
    sn(
      nil,
      fmt("Some({}) = {}", {
        d(2, function(args)
          return sn(nil, { i(1, args[1][1]) })
        end, { 1 }),
        i(1, "foo"),
      }),
      nil,
      "Some(…) = …",
      true
    ),
    sn(
      nil,
      fmt("Ok({}) = {}", {
        d(2, function(args)
          return sn(nil, { i(1, args[1][1]) })
        end, { 1 }),
        i(1, "foo"),
      }),
      nil,
      "Ok(…) = …",
      true
    ),
    sn(
      nil,
      fmt("{} = {}", {
        i(2, "Foo::Bar"),
        i(1, "foo"),
      }),
      nil,
      "Enum:Foo = …",
      true
    ),
  })
end

-- local M1 = {
--   s(
--     { trig = "l", desc = "let" },
--     fmt("let {} = {};{}", {
--       i(1),
--       i(2),
--       i(0),
--     }),
--     { condition = conds_expand.line_begin }
--   ),
--   s(
--     { trig = "lm", desc = "let mut" },
--     fmt("let mut {} = {};{}", {
--       i(1),
--       i(2),
--       i(0),
--     }),
--     { condition = conds_expand.line_begin }
--   ),
-- }
--
-- for _, value in pairs(M1) do
--   value.show_condition = function()
--     return false
--   end
-- end

local M = {
  s("Option<…>", fmt("Option<{}>{}", { i(1, "T"), i(0) })),
  s("Some(…)", fmt("Some({}){}", { i(1, "()"), i(0) })),
  s("Ok(…)", fmt("Ok({}){}", { i(1, "()"), i(0) })),
  s("Result<…, …>", fmt("Result<{}, {}>{}", { i(1, "()"), i(2, "()"), i(0) })),
  s("Err(…)", fmt("Err({}){}", { i(1, "()"), i(0) })),
  s("Default::default()", fmt("Default::default()", {})),

  s("async", { t("async ") }, { condition = conds_expand.rust_pub }),
  s("pub", { t("pub ") }, { condition = conds_expand.line_begin }),
  s("pub(crate)", { t("pub(crate) ") }, { condition = conds_expand.line_begin }),
  s("pub(super)", { t("pub(super) ") }, { condition = conds_expand.line_begin }),
  -- s({ trig = "pub", desc = "pub" }, {
  --   util.rust.modifier(1),
  --   n(1, " "),
  -- }),
  -- s("let", {
  --   t("let "),
  --   c(1, {
  --     util.empty_sn(),
  --     t("mut "),
  --   }),
  --   i(2, "foo"),
  --   t(" = "),
  --   c(3, {
  --     sn(nil, {
  --       i(1, "bar"),
  --     }, nil, "bar"),
  --     sn(nil, {
  --       util.rust.body(1, true),
  --     }, nil, "{..}"),
  --     sn(nil, {
  --       t({ "if {", "\t" }),
  --       i(1),
  --       t({ "", "else {", "\ttodo()" }),
  --       -- i(2, "todo!()"),
  --       t({ "\t", "}" }),
  --     }, nil, "if { … } else { … }"),
  --   }),
  --   t(";"),
  -- }),
  s("return …;", fmt("return {};", { i(1) }), { condition = conds_expand.line_begin }),
  s("let mut … = …;", fmt("let mut {} = {};", { i(1), i(0, "todo!()") }), { condition = conds_expand.line_begin }),
  s("let … = …;", fmt("let {} = {};", { i(1), i(0, "todo!()") }), { condition = conds_expand.line_begin }),
  s({
    trig = "for … in … { … }",
    desc = "",
    docstring = {
      "for … in … {",
      "\t…",
      "}",
    },
  }, {
    t("for "),
    d(2, function(args, snip, old_state)
      if string.find(args[1][1], "enumerate") then
        return sn(nil, { t("("), i(1, "i"), t(", "), i(2, "item"), t(")") })
      else
        return sn(nil, { i(1, "i") })
      end
    end, { 1 }),
    t(" in "),
    c(1, {
      sn(nil, {
        i(1),
        t(".iter()"),
      }, nil, ".iter()"),
      sn(nil, {
        i(1),
        t(".into_iter()"),
      }, nil, ".into_iter()"),
      sn(nil, {
        i(1),
        t(".iter().enumerate()"),
      }, nil, ".iter().enumerate()"),
      sn(nil, { i(1, "1"), t(".."), i(2, "10") }, nil, "x..y"),
    }, {}),
    t(" "),
    util.rust.body(0),
  }),
  s(
    {
      trig = "if … { … }",
      desc = "",
      docstring = { "if … {", "\t…", "}" },
    },
    fmt(
      [[
    if {} {{
        {}
    }}]],
      { i(1, "true"), i(0, "todo!()") }
    )
  ),
  s(
    {
      trig = "else { … }",
      desc = "",
      docstring = { "else {", "\t…", "}" },
    },
    fmt(
      [[
    else {{
        {}
    }}]],
      { i(0, "todo!()") }
    )
  ),
  s(
    {
      trig = "else if … { … }",
      desc = "",
      docstring = { "else if … {", "\t…", "}" },
    },
    fmt(
      [[
    else if {} {{
        {}
    }}]],
      { i(1, "true"), i(0, "todo!()") }
    )
  ),
  s(
    {
      trig = "if … { … } else { … }",
      desc = "",
      docstring = { "if … {", "\t…", "} else {", "\t…", "}" },
    },
    fmt(
      [[
    if {} {{
        {}
    }} else {{
        {}
    }}]],
      { i(1, "true"), i(2, "todo!()"), i(0, "todo!()") }
    )
  ),
  s({
    trig = "if let … = … { … }",
    desc = "",
    docstring = { "if let … = … {", "\t…", "}" },
  }, {
    t("if let "),
    for_choice_c(1),
    t(" "),
    util.rust.body(0),
  }),
  s({
    trig = "while … { … }",
    desc = "",
    docstring = { "while … {", "\t…", "}" },
  }, {
    t("while "),
    i(1, "true"),
    t(" "),
    util.rust.body(0),
  }),
  s({
    trig = "while let … = … { … }",
    desc = "",
    docstring = { "while let … = … {", "\t…", "}" },
  }, {
    t("while let "),
    for_choice_c(1),
    t(" "),
    util.rust.body(0),
  }),
  s(
    {
      trig = "match … { … }",
      desc = "",
      docstring = {
        "match … {",
        "\t… => …,",
        "\t_ => …,",
        "}",
      },
    },
    fmt(
      [[
  match {} {{
      {}
  }}]],
      { i(1), i(0) }
    )
  ),
  s(
    "fn main",
    fmt(
      [[
  fn main(){arrow}{return_type} {{
      {body}{}
  }}]],
      {
        arrow = n(1, " -> "),
        return_type = i(1, "Result<(), Box<dyn std::error::Error>>"),
        body = i(0),
        m(1, "Result", "\n\tOk(())"), -- if 1 contains "Result", then insert Ok(()) after 1
      }
    ),
    { condition = conds_expand.rust_async }
  ),
}

return M
