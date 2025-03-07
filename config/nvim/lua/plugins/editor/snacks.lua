local M = {
  "folke/snacks.nvim",
}

local load_session = function()
  require("telescope").extensions.possession.list(require("telescope.themes").get_dropdown({
    layout_config = { mirror = true },
  }))
end

local open_config = function()
  -- Set winminwidth and winminwidth to 1 to avoid error
  vim.opt.winminheight = 1
  vim.opt.winminwidth = 1
  vim.cmd("PossessionLoad config")
end

local find_files = function()
  -- require("telescope").extensions.smart_open.smart_open({
  --   prompt_title = "Smart Open",
  --   cwd_only = true,
  --   filename_first = true,
  -- })
  LazyVim.pick("files")()
end

M.opts = {
  dashboard = {
    preset = {
      -- stylua: ignore
      keys = {
        -- { action = "Telescope find_files",      desc = " Find File",       icon = " ", key = "f" },
        -- { action = frecency,                    desc = " Find File",       icon = " ", key = "f" },
        -- { action = "Telescope oldfiles",        desc = " Old File",        icon = " ", key = "o" },
        -- { action = "Telescope live_grep",       desc = " Find text",       icon = " ", key = "g" },
        -- { icon = " ", desc = "Search Text",  key = "s", action = ":Telescope live_grep_args" },
        { icon = " ", desc = "Session",      key = "p", action = load_session },
        { icon = " ", desc = "Find File",    key = "f", action = find_files },
        { icon = " ", desc = "New File",     key = "n", action = ":ene | startinsert" },
        { icon = " ", desc = "Search Text",  key = "s", action = LazyVim.pick("live_grep") },
        { icon = " ", desc = "Recent Files", key = "r", action = function() Snacks.picker.recent({ title = "Recent Files" }) end, },
        { icon = " ", desc = "Git Project",  key = "g", action = function() Snacks.picker.projects() end },
        { icon = " ", desc = "Config",       key = "c", action = open_config },
        { icon = "󰒲 ", desc = "Lazy",         key = "z", action = ":Lazy" },
        { icon = " ", desc = "Quit",         key = "q", action = ":qa" },
      },
    },
  },
  picker = {
    enabled = true,
    win = {
      input = {
        -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#%EF%B8%8F-config
        keys = {
          ["<Esc>"] = { "cancel", mode = { "n", "i" } },
          ["<C-c>"] = { "<Esc>", mode = { "n", "i" }, expr = true },
          ["<C-u>"] = { "<c-u>", mode = { "i" }, expr = true, desc = "clean line" },
          -- ["<C-a>"] = { "<c-a>", mode = { "i" }, expr = true, desc = "Start" },
          -- ["<C-e>"] = { "<c-e>", mode = { "i" }, expr = true, desc = "end" },
          ["<C-/>"] = { "toggle_help_input", mode = { "n", "i" } },
          ["<c-a-p>"] = { "list_scroll_up", mode = { "i", "n" } },
          ["<c-a-n>"] = { "list_scroll_down", mode = { "i", "n" } },
        },
      },
    },
  },
  zen = {
    enabled = true,
    toggles = {
      dim = false,
    },
    show = {
      statusline = true,
      tabline = true,
    },
  },
  scroll = {
    enabled = true,
    animate = {
      duration = { step = 1, total = 250 },
    },
  },
  input = { enabled = true },
  styles = {
    zoom_indicator = {
      text = "▍ zoom  󰊓",
      row = 1,
      col = -1,
    },
    input = {
      height = 1,
      relative = "editor",
      row = 20,
    },
  },
}

M.keys = function()
  -- stylua: ignore
  return {
      -- { "<leader><cr>",  function() Snacks.zen() end, desc = "Zen Mode" },
      { "<leader>z",  function() Snacks.zen.zoom()end, desc = "Zoom Mode (Maximize)" },

      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      -- { "<leader><A-.>",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },

      { "<leader>nn", function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    }
end

return M
