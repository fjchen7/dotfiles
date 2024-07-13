return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  enabled = false,
  keys = {
    {
      "<C-r>z",
      function()
        require("yazi").toggle()
      end,
      desc = "Open Yazi",
    },
    {
      -- Open in the current working directory
      "<C-r>Z",
      function()
        require("yazi").yazi()
      end,
      desc = "Open Yazi and Locate",
    },
  },
  ---@type YaziConfig
  opts = {
    -- if you want to open yazi instead of netrw,? see below for more info
    open_for_directories = false,

    -- enable these if you are using the latest version of yazi
    -- use_ya_for_events_reading = true,
    -- use_yazi_client_id_flag = true,

    keymaps = {
      show_help = "?",
    },
    hooks = {
      yazi_opened = function(preselected_path, yazi_buffer_id, config)
        vim.keymap.set("n", "q", function()
          pcall(require("yazi").toggle)
        end, { buffer = yazi_buffer_id })
        vim.keymap.set("n", "<Esc>", "<Esc><Esc>", { buffer = yazi_buffer_id })
      end,
    },
  },
}
