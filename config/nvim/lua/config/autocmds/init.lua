-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

require("config.autocmds.auto-save")
require("config.autocmds.cursorline")

-- Jump to last visited place when entering a bufer
-- * https://this-week-in-neovim.org/2023/Jan/02#tips
-- * https://www.reddit.com/r/neovim/comments/1abd2cq/comment/kjmv9jz
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      -- pcall(vim.api.nvim_win_set_cursor, 0, mark)
      vim.api.nvim_win_set_cursor(0, mark)
      -- set mark ` to last visited place as well
      vim.api.nvim_buf_set_mark(0, "`", mark[1], mark[2], {})
    end
  end,
})

-- Set files under certain directories unmodifiable
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = {
    "**/.cargo/registry/**",
    "**/.cargo/git/**",
    "**/.local/share/nvim/lazy/**",
  },
  callback = function(opts)
    local bufnr = opts.buf
    vim.bo[bufnr].modifiable = false
    -- vim.bo[bufnr].readonly = true
    -- vim.bo[bufnr].buflisted = false
    -- vim.bo[bufnr].swapfile = false
  end,
})

-- https://www.reddit.com/r/neovim/comments/1kq8jxb/comment/mt52t75
_G.shift_k_enabled = false
vim.api.nvim_create_augroup("LspGroup", {})

vim.api.nvim_create_autocmd("CursorHold", {
  group = "LspGroup",
  callback = function()
    if not _G.shift_k_enabled then
      vim.diagnostic.open_float(nil, {
        -- scope = "cursor",
        focusable = false,
        close_events = {
          "CursorMoved",
          "CursorMovedI",
          "BufHidden",
          "InsertCharPre",
          "WinLeave",
        },
      })
    end
  end,
  desc = "Show diagnostic error info on CursorHold",
})
vim.api.nvim_create_autocmd({ "CursorMoved", "BufEnter" }, {
  callback = function()
    _G.shift_k_enabled = false
  end,
})
function _G.show_docs()
  _G.shift_k_enabled = true
  vim.api.nvim_command("doautocmd CursorMovedI") -- Run autocmd to close diagnostic window if already open

  local cw = vim.fn.expand("<cword>")
  if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
    vim.api.nvim_command("h " .. cw)
  else
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    -- :h ufo.txt
    if winid then
      local buf = vim.api.nvim_win_get_buf(winid)
      local ufo_keys = { "a", "i", "o", "A", "I", "O", "gd", "gr" }
      for _, k in ipairs(ufo_keys) do
        vim.keymap.set("n", k, "<CR>" .. k, { noremap = false, buffer = buf })
      end
    else
      vim.lsp.buf.hover({
        -- :h winborder
        border = "rounded",
        width = 80,
        title = "Hover",
      })
    end
  end
end
