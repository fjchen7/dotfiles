return {
  "MagicDuck/grug-far.nvim",
  keys = {
    {
      "<leader>sb",
      function()
        local is_visual = vim.fn.mode():lower():find("v")
        if is_visual then -- needed to make visual selection work
          vim.cmd([[normal! v]])
        end
        local path = vim.fn.fnameescape(vim.fn.expand("%:p:."))
        local grug = require("grug-far");
        (is_visual and grug.with_visual_selection or grug.grug_far)({
          prefills = { filesFilter = path },
        })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace in Buffer",
    },
  },
}
