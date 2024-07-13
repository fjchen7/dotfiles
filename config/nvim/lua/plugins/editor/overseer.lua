return {
  -- Run frequently-used tasks in background
  "stevearc/overseer.nvim",
  -- keys = e
  --   { "<leader>co", "<cmd>OverseerRun<cr><cmd>OverseerOpen<cr>", desc = "Build / Run (Overseer)" },
  --   { "<leader>cO", "<cmd>OverseerToggle<cr>", desc = "Toggle build / Run Result (Overseer)" },
  -- },
  keys = {
    { "<leader>oq", false },
    { "<leader>or", "<cmd>OverseerQuickAction<cr>", desc = "Quick Action" },
    { "<leader>ow", "<cmd>OverseerToggle<cr>", desc = "Toggle Task Window" },
    {
      "<leader>ol",
      function()
        local overseer = require("overseer")
        local tasks = overseer.list_tasks({ recent_first = true })
        if vim.tbl_isempty(tasks) then
          vim.notify("No tasks found", vim.log.levels.WARN)
        else
          overseer.run_action(tasks[1], "restart")
        end
      end,
      desc = "Run Last Task",
    },
  },
  opts = {
    task_list = {
      direction = "bottom",
      max_width = { 250, 0.5 },
      min_width = { 100, 0.2 },
      max_height = { 100, 0.3 },
      bindings = {
        ["<C-l>"] = false,
        ["<C-h>"] = false,
        ["l"] = "IncreaseDetail",
        ["h"] = "DecreaseDetail",
        ["<C-j>"] = false,
        ["<C-k>"] = false,
        ["K"] = "ScrollOutputUp",
        ["J"] = "ScrollOutputDown",
      },
    },
    task_editor = {
      bindings = {
        n = {
          ["<Esc>"] = "Cancel",
        },
        i = {
          ["<Esc>"] = "Cancel",
          ["<C-/>"] = "ShowHelp",
        },
      },
    },
  },
  config = function(_, opts)
    require("overseer").setup(opts)
    -- require("neotest").setup({
    --   consumers = {
    --     overseer = require("neotest.consumers.overseer"),
    --   },
    -- })
  end,
}
