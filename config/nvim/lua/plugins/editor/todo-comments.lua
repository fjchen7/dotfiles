return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = "LazyFile",
  -- If keys is a function, then it override but not merge with the default keys
  keys = function()
    return {
      -- {
      --   "<leader>qtb",
      --   function()
      --     local path = vim.fn.expand("%:p")
      --     vim.cmd("Trouble todo cwd=" .. path)
      --   end,
      --   desc = "Buffer TODOs",
      -- },
      {
        "<leader>dt",
        function()
          Snacks.picker.todo_comments({ keywords = { "TODO" } })
        end,
        desc = "Todo/Fix/Fixme",
      },
      -- { "<leader>dt", "<cmd>Trouble todo toggle filter = {tag = {TODO}}<cr>", desc = "Workspace TODOs" },
      -- { "<leader>dT", "<cmd>TodoTelescope keywords=TODO<cr>", desc = "Workspace TODOs (Telescope)" },

      -- {
      --   "<leader>qfb",
      --   function()
      --     local path = vim.fn.expand("%:p")
      --     vim.cmd("TodoTrouble cwd=" .. path)
      --   end,
      --   desc = "Buffer TODO/FIX",
      -- },
      {
        "<leader>dT",
        function()
          Snacks.picker.todo_comments()
        end,
        desc = "Todo/Fix/Fixme",
      },
      -- { "<leader>df", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Workspace TODO/FIX" },
      -- {
      --   "<leader>dF",
      --   "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",
      --   desc = "Workspace TODO/FIX (Telescope)",
      -- },
    }
  end,
  opts = {
    keywords = {
      TODO = { color = "#8caaef" },
    },
    highlight = {
      keyword = "bg",
    },
  },
  config = function(_, opts)
    local todo_comments = require("todo-comments")
    todo_comments.setup(opts)
    local next_todo_repeat, prev_todo_repeat =
      Util.make_repeatable_move_pair(todo_comments.jump_next, todo_comments.jump_prev)
    local map = Util.map
    map({ "n", "x", "o" }, "]t", next_todo_repeat, "Next TODO")
    map({ "n", "x", "o" }, "[t", prev_todo_repeat, "Prev TODO")
  end,
}
