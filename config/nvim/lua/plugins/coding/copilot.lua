return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  -- enabled = not vim.env.KITTY_SCROLLBACK_NVIM,
  enabled = true,
  keys = {
    { mode = { "i" }, "<C-y>", "<CMD>Copilot panel<CR>", desc = "[copilot] open panel" },
  },
  opts = {
    --   suggestion = {
    --     enabled = true,
    --     auto_trigger = true,
    --     keymap = {
    --       accept = false,
    --       accept_word = false,
    --       accept_line = false,
    --       next = "<M-]>",
    --       prev = "<M-[>",
    --       dismiss = false,
    --     },
    --   },
    panel = {
      enabled = true,
      keymap = {
        jump_next = "]]",
        jump_prev = "[[",
        accept = "<CR>",
        refresh = "r",
        open = "<M-CR>",
      },
    },
    --   filetypes = {
    --     markdown = true,
    --     help = true,
    --   },
  },
}
