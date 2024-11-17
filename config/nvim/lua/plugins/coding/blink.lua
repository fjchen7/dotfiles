return {
  "saghen/blink.cmp",
  -- https://github.com/Saghen/blink.cmp#advantages
  opts = {
    keymap = {
      preset = "enter",
      ["<C-e>"] = { "fallback" },
      ["<C-c>"] = { "hide", "fallback" },
    },
    windows = {
      autocomplete = {
        border = "none",
        winblend = 0,
      },
    },
  },
}
