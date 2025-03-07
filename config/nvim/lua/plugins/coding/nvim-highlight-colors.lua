return {
  -- Comparation with nvim-colorizer: https://www.reddit.com/r/neovim/comments/1b5gw12/comment/kt57ft5
  -- Alternative:
  -- * NvChad/nvim-colorizer.lua
  "brenoprata10/nvim-highlight-colors",
  event = "VeryLazy",
  enabled = false,
  keys = {
    {
      "<leader>uH",
      function()
        require("nvim-highlight-colors").toggle()
      end,
      desc = "Toggle Hex Color Highlight",
    },
  },
  opts = {},
}
