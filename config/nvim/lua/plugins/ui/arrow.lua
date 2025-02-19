return {
  "otavioschwanck/arrow.nvim",
  event = "VeryLazy",
  keys = function()
    local commands = require("arrow.commands").commands
    local arrow = require("arrow.persist")
    local statusline = require("arrow.statusline")
    local keys = {
      -- marks in local file
      { "<M-j>", commands.next_buffer_bookmark, mode = { "n", "v", "i" }, desc = "Next Mark (Arrow)" },
      { "<M-k>", commands.prev_buffer_bookmark, mode = { "n", "v", "i" }, desc = "Prev Mark (Arrow)" },
      { "<F3>", "<leader><leader>", remap = true, desc = "Bookmark" },
      {
        "<F4>",
        function()
          arrow.toggle()
          Snacks.notifier.hide()
          if statusline.is_on_arrow_file() then
            vim.notify("Add Bookmark", vim.log.levels.INFO, { title = "Arrow" })
          else
            vim.notify("Remove Bookmark", vim.log.levels.WARN, { title = "Arrow" })
          end
        end,
        desc = "Add/Remove Bookmark",
      },
    }
    for i = 1, 9 do
      table.insert(keys, {
        "<leader>" .. i,
        function()
          arrow.go_to(i)
        end,
        desc = i == 1 and "Navigate File 1 (Arrow)" or "which_key_ignore",
      })
    end
    return keys
  end,
  opts = {
    leader_key = "<leader><leader>",
    buffer_leader_key = "m",
    always_show_path = true,
    separate_save_and_remove = false,
    mappings = {
      toggle = "m", -- used as save if separate_save_and_remove is true
      remove = "X", -- only used if separate_save_and_remove is true
      edit = "e",
      delete_mode = "d",
      clear_all_items = "D",
      open_vertical = "v",
      open_horizontal = "s",
      quit = "q",
      next_item = "l",
      prev_item = "h",
    },
    per_buffer_config = {
      lines = 5,
    },
  },
}
