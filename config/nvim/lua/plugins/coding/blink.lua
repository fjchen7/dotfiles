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
    completion = {
      menu = {
        border = "none",
        winblend = 5,
      },
    },
    -- LazyVim disable this
    cmdline = {
      enabled = true,
      sources = function()
        local type = vim.fn.getcmdtype()
        -- Search forward and backward
        if type == "/" or type == "?" then
          return { "buffer" }
        end
        -- Commands
        if type == ":" or type == "@" then
          return { "cmdline" }
        end
        return {}
      end,
      completion = {
        menu = { auto_show = true },
      },
    },
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
