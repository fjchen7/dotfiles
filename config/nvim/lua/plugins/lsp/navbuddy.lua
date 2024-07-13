-- NOTE: experimental
return {
  -- Symbol popup for operation
  "SmiteshP/nvim-navbuddy",
  event = "BufReadPost",
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
    "numToStr/Comment.nvim", -- Optional
    "nvim-telescope/telescope.nvim", -- Optional
  },
  keys = {
    {
      "<leader>ii",
      "<CMD>Navbuddy<CR>",
      desc = "Select Symbols (Navbuddy)",
    },
  },
  opts = function()
    local actions = require("nvim-navbuddy.actions")
    return {
      window = {
        sections = {
          mid = {
            size = "30%",
          },
          right = {
            preview = "always", -- Right section can show previews too.
            -- Options: "leaf", "always" or "never"
          },
        },
      },

      lsp = {
        -- ISSUE: can't open symbols for dependency source, notify "No lsp servers attached"
        auto_attach = true,
      },
      mappings = {
        ["<F1>"] = actions.help(),
        ["?"] = actions.help(),
        ["<M-i>"] = actions.close(),
      },
    }
  end,
}
