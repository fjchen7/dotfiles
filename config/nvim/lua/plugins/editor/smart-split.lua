local M = {
  -- Individual buffers for each tab
  "mrjones2014/smart-splits.nvim",
  event = "VeryLazy",
  build = "./kitty/install-kittens.bash",
  enabled = vim.fn.getenv("TMUX_PANE") ~= vim.NIL,
}

local fn = function(method)
  return function()
    -- Disable windows move in floating windows
    -- https://www.reddit.com/r/neovim/comments/17tu64y/comment/k91vg89
    local win = vim.api.nvim_get_current_win()
    local win_is_floating = vim.api.nvim_win_get_config(win).relative ~= ""
    if win_is_floating then
      return
    end
    if vim.fn.mode():find("[Vv]") then
      local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
      vim.api.nvim_feedkeys(esc, "x", false)
    end
    require("smart-splits")[method]()
  end
end

local ignored = "which_key_ignore"

M.keys = {
  { mode = { "n", "t" }, "<C-Left>", fn("resize_left"), desc = "Window Resize Left (HJKL)" },
  { mode = { "n", "t" }, "<C-Down>", fn("resize_down"), desc = ignored },
  { mode = { "n", "t" }, "<C-Up>", fn("resize_up"), desc = ignored },
  { mode = { "n", "t" }, "<C-Right>", fn("resize_right"), desc = ignored },

  { mode = { "n", "x", "t" }, "<C-h>", fn("move_cursor_left"), desc = "Navigate to Window Left (HJKL)" },
  { mode = { "n", "x", "t" }, "<C-j>", fn("move_cursor_down"), desc = ignored },
  { mode = { "n", "x", "t" }, "<C-k>", fn("move_cursor_up"), desc = ignored },
  { mode = { "n", "x", "t" }, "<C-l>", fn("move_cursor_right"), desc = ignored },

  { mode = { "n" }, "<C-M-h>", "<CMD>wincmd H<CR>", desc = "Move Window to Left (HJKL)" },
  { mode = { "n" }, "<C-M-j>", "<CMD>wincmd J<CR>", desc = ignored },
  { mode = { "n" }, "<C-M-k>", "<CMD>wincmd K<CR>", desc = ignored },
  { mode = { "n" }, "<C-M-l>", "<CMD>wincmd L<CR>", desc = ignored },
}

M.opts = {
  default_amount = 5,
}
return M
