return {
  -- Smooth scroll
  "karb94/neoscroll.nvim",
  enabled = false,
  opts = {
    -- stylua: ignore
    mappings = {
      "<C-u>", "<C-d>",
      "<C-y>", "<C-e>",
      "zt", "zz", "zb",
    },
    duration_multiplier = 0.7,
  },
}
