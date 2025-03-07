return {
  "saghen/blink.cmp",
  -- https://github.com/Saghen/blink.cmp#advantages
  opts = {
    keymap = {
      -- https://cmp.saghen.dev/configuration/keymap#enter
      preset = "super-tab",
      ["<C-e>"] = { "fallback" },
      ["<C-c>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },
    -- sources = {
    --   cmdline = { "buffer", "path" },
    -- },
  },
}
