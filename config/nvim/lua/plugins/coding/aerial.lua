local M = {
  "stevearc/aerial.nvim",
  event = "LazyFile",
}

M.keys = function()
  local next_fn, prev_fn = Util.make_repeatable_move_pair(function()
    vim.cmd("AerialNext")
  end, function()
    vim.cmd("AerialPrev")
  end)
  return {
    -- { "<leader>ii", "m`<CMD>AerialToggle float<CR>", desc = "Symbols Popup (Aerial)" },
    -- { "t", "m`<CMD>AerialToggle float<CR>", desc = "Symbols Popup (Aerial)" },
    -- { "<leader>ii", "m`<CMD>AerialToggle float<CR>", desc = "Symbols Popup (Aerial)" },
    -- {
    --   "go",
    --   function()
    --     if vim.bo.ft == "aerial" then
    --       vim.cmd("wincmd p")
    --     else
    --       vim.cmd("AerialOpen")
    --     end
    --   end,
    --   desc = "Symbols (Aerial)",
    -- },
    -- { "go", "<CMD>AerialToggle<CR>", desc = "Symbols (Aerial)" },
    -- { "gO", "<CMD>AerialNavToggle<CR>", desc = "Navigate Symbols (Aerial)" },
    { "<leader>io", "<CMD>AerialToggle<CR>", desc = "Symbols (Aerial)" },
    { "<leader>iO", "<CMD>AerialNavToggle<CR>", desc = "Navigate Symbols (Aerial)" },
    { "]]", next_fn, desc = "Next Symbol (Aerial)" },
    { "[[", prev_fn, desc = "Prev Symbol (Aerial)" },
  }
end

-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/editor/aerial.lua
local filter_kind = {
  "Class",
  "Constructor",
  "Enum",
  "Function",
  "Interface",
  "Module",
  "Method",
  "Struct",
}

M.opts = function(_, opts)
  opts.filter_kind.rust = vim.deepcopy(opts.filter_kind._)
  table.insert(opts.filter_kind.rust, "Object")

  opts.layout.win_opts = {}
  opts = vim.tbl_deep_extend("force", opts or {}, {
    attach_mode = "window",
    layout = {
      max_width = { 80, 0.6 },
      min_width = 40,
      resize_to_content = true,
      -- default_direction = "float",
    },
    highlight_mode = "full_width",
    highlight_on_hover = true,
    highlight_on_jump = false,
    show_guides = false,
    autojump = false,
    -- post_jump_cmd = false,
    ignore = {
      unlisted_buffers = true,
    },
    keymaps = {
      ["g?"] = false,
      ["<esc>"] = "actions.close",
      ["p"] = "actions.scroll",

      ["<C-k>"] = false,
      ["<C-j>"] = false,
      ["J"] = "actions.down_and_scroll",
      ["K"] = "actions.up_and_scroll",
      -- ["K"] = "actions.prev",
      -- ["J"] = "actions.next",
    },
    float = {
      relative = "cursor", -- cursor, editor, win
    },
    nav = {
      min_height = { 10, 0.5 },
      preview = false,
      keymaps = {
        ["<Space>"] = "actions.jump",
        ["<Esc>"] = "actions.close",
      },
    },
  })
  return opts
end

M.config = function(_, opts)
  require("aerial").setup(opts)
  -- Highlight on hover
  vim.cmd("hi! AerialLine gui=bold")
  -- vim.cmd("hi! link AerialLine QuickFixLine")
  require("telescope").load_extension("aerial")
end

return M
