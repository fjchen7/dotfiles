return {
  "NeogitOrg/neogit",
  event = "BufReadPost",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    {
      "<leader>gi",
      "<cmd>Neogit kind=auto<cr>",
      desc = "Git (neogit)",
    },
  },
  opts = {
    sections = {
      untracked = {
        folded = true,
      },
    },
    mappings = {
      status = {
        ["<esc>"] = "Close",
        -- ["<leader>i"] = "Close",
        --     ["<space>"] = "Toggle",
        --     ["<tab>"] = "",
      },
    },
  },
}
