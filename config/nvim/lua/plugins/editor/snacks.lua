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

local smart_open = function()
  require("telescope").extensions.smart_open.smart_open({
    prompt_title = "Smart Open",
    cwd_only = true,
    filename_first = true,
  })
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
        { icon = " ", desc = "Session",      key = "p", action = load_session },
        { icon = " ", desc = "Find File",    key = "f", action = smart_open },
        { icon = " ", desc = "New File",     key = "n", action = ":ene | startinsert" },
        { icon = " ", desc = "Recent Files", key = "r", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        { icon = " ", desc = "Search Text",  key = "s", action = ":Telescope live_grep_args" },
        { icon = " ", desc = "Git Project",  key = "g", action = ":Telescope project" },
        { icon = " ", desc = "Config",       key = "c", action = open_config },
        { icon = "󰒲 ", desc = "Lazy",         key = "z", action = ":Lazy" },
        { icon = " ", desc = "Quit",         key = "q", action = ":qa" },
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
  indent = { enabled = true },
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
