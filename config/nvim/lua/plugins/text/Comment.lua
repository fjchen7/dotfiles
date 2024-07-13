return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      lazy = true,
      opts = {
        enable_autocmd = false,
      },
    },
  },
  init = function()
    require("which-key").add({ { "gc", group = "+comment" } })
  end,
  keys = {
    -- need vim-textobj-comment
    { "gcu", "gcic", remap = true, desc = "Uncomment" },
    -- { "gcd", "dax", remap = true, desc = "Delete Comment" },
    { "gcd", "dac", remap = true, desc = "Delete Comment" },
    { "gcv", "gvgc<C-o>", remap = true, desc = "Comment Last Visual" },
    { "gcF", "gcoFIX: ", desc = "Add FIX below", remap = true },
    { "gcf", "gcOFIX: ", desc = "Add FIX above", remap = true },
    { "gcT", "gcoTODO: ", desc = "Add TODO below", remap = true },
    { "gct", "gcOTODO: ", desc = "Add TODO above", remap = true },
  },
  config = function(_, opts)
    local opts = {
      toggler = {
        line = "gcc",
        block = "gCC",
      },
      opleader = {
        line = "gc",
        block = "gC",
      },
      extra = {
        above = "gcO",
        below = "gco",
        eol = "gcA",
      },
      mappings = {
        basic = true,
        extra = true,
      },
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    }
    require("Comment").setup(opts)
  end,
}
