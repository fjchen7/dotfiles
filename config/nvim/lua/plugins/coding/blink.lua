vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuOpen",
  callback = function()
    require("copilot.suggestion").dismiss()
    vim.b.copilot_suggestion_hidden = true
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuClose",
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})

return {
  "saghen/blink.cmp",
  -- https://github.com/Saghen/blink.cmp#advantages
  opts = {
    keymap = {
      -- https://cmp.saghen.dev/configuration/keymap#enter
      preset = "super-tab",
      ["<C-e>"] = { "fallback" },
      ["<C-c>"] = { "hide" },
      -- Hide completion menu and toggle copilot suggestion
      ["<M-\\>"] = {
        function(cmp)
          cmp.hide()
          require("copilot.suggestion").accept()
        end,
      },
      ["<CR>"] = { "accept", "fallback" },
    },
    fuzzy = {
      -- https://cmp.saghen.dev/recipes.html#always-prioritize-exact-matches
      -- defaults is {"score", "sort_text"}
      sorts = {
        "exact",
        "score",
        "sort_text",
      },
    },
    -- sources = {
    --   cmdline = { "buffer", "path" },
    -- },
  },
}
