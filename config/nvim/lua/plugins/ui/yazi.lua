return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  enabled = true,
  keys = {
    {
      "<C-r>y",
      function()
        require("yazi").toggle()
      end,
      desc = "Open Yazi",
    },
    {
      -- Open in the current working directory
      "<C-r>Y",
      function()
        require("yazi").yazi()
      end,
      desc = "Open Yazi and Locate",
    },
  },
  ---@type YaziConfig
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = "f1",
      open_file_in_horizontal_split = "<c-s>",
      grep_in_directory = "<c-f>",
    },
  },
}
