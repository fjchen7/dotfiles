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

local M = {
  s(
    {
      trig = "function",
      name = "function() … end",
      desc = "function()\n\t…\nend",
    },
    fmt(
      [[
  function({})
    {}
  end
  ]],
      { i(1), i(0) }
    )
  ),
  s(
    { trig = "local … = function", name = "local … = function", desc = "local … = function()\n\t…\nend" },
    fmt(
      [[
  local {} = function({})
    {}
  end
  ]],
      { i(1), i(2), i(0) }
    )
  ),
  s({
    trig = "for",
    name = "for … do … end",
  }, {
    t("for "),
    c(1, {
      sn(
        nil,
        fmt(" {}, {} in pairs({})", {
          i(2, "key"),
          i(3, "value"),
          i(1, "table"),
        }),
        nil,
        "pairs"
      ),
      sn(
        nil,
        fmt(" {}, {} in pairs({})", {
          i(2, "idx"),
          i(3, "value"),
          i(1, "list"),
        }),
        nil,
        "ipairs"
      ),
      sn(
        nil,
        fmt(" {} = {}, {}", {
          i(2, "i"),
          i(3, "1"),
          i(1, "10"),
        }),
        nil,
        "x,y"
      ),
    }, {}),
    t({ " do", "\t" }),
    i(0),
    t({ "", "end" }),
  }),
  s({
    trig = "require",
    name = "require(…)",
    desc = "require(…)",
  }, fmt("require({})", { i(1) })),
  s({
    trig = "return",
    name = "return",
    desc = "return …",
  }, fmt("return {}", { i(1) }), {}),
  s("local … = …", fmt("local {} = {}", { i(1), i(2) })),
  s(
    { trig = "if … then … end", desc = "if then" },
    fmt(
      [[
    if {} then
      {}
    end]],
      { i(1, "true"), i(2) }
    ),
    { condition = conds_expand.line_begin }
  ),
  s(
    "else",
    fmt(
      [[
else
  {}]],
      { i(2) }
    )
  ),
  s(
    { trig = "elseif", name = "elseif … then …" },
    fmt(
      [[
elseif {} then
  {}]],
      { i(1, "true"), i(2) }
    )
  ),
  s(
    { trig = "pcall", name = "pcall(f, arg1, …)" },
    fmt("{}{}pcall({}, {})", {
      c(1, {
        util.empty_sn(),
        sn(nil, { t("local") }, nil, "local"),
      }),
      d(2, function(args)
        if args[1][1] ~= "" then
          return sn(nil, {
            t(" "),
            i(1, "ok"),
            t(", "),
            i(2, "value"),
            t(" = "),
          })
        else
          return sn(nil, { t("") })
        end
      end, { 1 }),
      i(3, "func"),
      i(4, "args"),
    })
  ),
}

return M
