local M = {
  -- Auto resize focused window
  "nvim-focus/focus.nvim",
  enabled = true,
  -- stylua: ignore
  keys = {
    { "<C-w>\\", function() vim.cmd("FocusToggle") end, desc = "Toggle Windows Autoresize (Focus)", },
  },
}

M.init = function()
  -- Disable autoresize for certain filetypes/buftypes
  -- https://github.com/nvim-focus/focus.nvim#disabling-focus
  local ignore_filetypes = { "neo-tree" }
  local ignore_buftypes = { "nofile", "prompt", "popup" }

  local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })
  vim.api.nvim_create_autocmd("WinEnter", {
    group = augroup,
    callback = function(_)
      if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
        vim.w.focus_disable = true
      else
        vim.w.focus_disable = false
      end
    end,
    desc = "Disable focus autoresize for BufType",
  })
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    callback = function(_)
      if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
        vim.b.focus_disable = true
      else
        vim.b.focus_disable = false
      end
    end,
    desc = "Disable focus autoresize for FileType",
  })
end

M.opts = {
  autoresize = {
    enable = true,
    minwidth = 40,
    minheight = 30,
  },
  ui = {
    signcolumn = false, -- Display signcolumn in the focussed window only
    cursorline = true,
  },
}

return M
