return {
  "saghen/blink.cmp",
  -- https://github.com/Saghen/blink.cmp#advantages
  opts = {
    keymap = {
      -- https://cmp.saghen.dev/configuration/keymap#enter
      preset = "enter",
      ["<C-e>"] = { "fallback" },
      ["<C-c>"] = { "hide", "fallback" },
    },
    -- sources = {
    --   cmdline = { "buffer", "path" },
    -- },
  },
}
