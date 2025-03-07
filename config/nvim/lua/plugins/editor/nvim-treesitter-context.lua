return {
  -- Show function context in first line
  "nvim-treesitter/nvim-treesitter-context",
  config = function(_, opts)
    require("treesitter-context").setup(opts)
    -- set TreesitterContext to Normal's guibg
    -- vim.schedule(function()
    --   vim.cmd([[hi! TreesitterContext guibg=none gui=bold]])
    --   vim.cmd([[hi! link TreesitterContextLineNumber Normal]])
    --   -- vim.cmd([[hi! TreesitterContextLineNumber guifg=#e78285]])
    -- end)
  end,
}
