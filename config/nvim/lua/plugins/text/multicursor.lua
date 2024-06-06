return {
  "smoka7/multicursors.nvim",
  event = "VeryLazy",
  enabled = false,
  dependencies = {
    "nvimtools/hydra.nvim",
  },
  cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
  keys = {
    { mode = { "v" }, "<C-g>", "<cmd>MCstart<cr>", desc = "Multi Cursor on Text" },
    { mode = { "n" }, "<C-g>", "<cmd>MCunderCursor<cr>", desc = "Multi Cursor" },
  },
  init = function()
    vim.defer_fn(function()
      vim.cmd([[
        hi! MultiCursor guibg=#F977C2 guifg=#111111
        hi! MultiCursorMain guibg=#F977C2 guifg=#111111
      ]])
    end, 1000)
  end,
  opts = {
    -- hint_config = {
    --   float_opts = {
    --     border = "rounded",
    --   },
    --   position = "bottom-right",
    -- },
    generate_hints = {
      normal = true,
      insert = false,
      extend = true,
      config = {
        column_count = 2,
      },
    },
  },
}
