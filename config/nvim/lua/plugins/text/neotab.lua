return {
  -- neotab doesn't use treesitter, which is more accurate
  "kawre/neotab.nvim",
  event = "InsertEnter",
  enabled = true,
  dependencies = {
    {
      "abecodes/tabout.nvim",
      enabled = false,
    },
  },
  opts = {
    act_as_tab = false,
    behavior = "closing",
  },
}
