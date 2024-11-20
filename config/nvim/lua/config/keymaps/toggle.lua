local map = Util.map
local del = vim.keymap.del

Snacks.toggle.option("cursorline", { name = "Cursorline" }):map("<leader>u-")
Snacks.toggle.option("ignorecase", { name = "Ignorecase" }):map("<leader>uC")

-- del("n", "<leader>uT")
-- Snacks.toggle.treesitter():map("<leader>uh")
Snacks.toggle.inlay_hints():map("<leader>ui")

del("n", "<leader>uI")
map("n", "<leader>uIp", vim.show_pos, "Inspect Pos")
map("n", "<leader>uIt", "<cmd>InspectTree<cr>", "Inspect Tree")
map("n", "<leader>uIn", function()
  local node = vim.treesitter.get_node():type()
  -- copy(node)
  vim.notify('Treesitter node under cursor is "' .. node .. '". Name copied.')
end, "Inspect Treesitter Ndoe under Cursor")

Snacks.toggle({
  name = "Diagnostics (Inline)",
  get = function()
    return vim.diagnostic.config().virtual_text ~= false
  end,
  set = function(enabled)
    vim.cmd("Corn toggle")
  end,
}):map("<leader>uD")

Snacks.toggle({
  name = "Modified",
  get = function()
    return vim.bo[0].modifiable
  end,
  set = function(_)
    local bo = vim.bo[0]
    bo.modifiable = not bo.modifiable
  end,
}):map("<leader>um")

Snacks.toggle.zoom():map("<leader>z")

Snacks.toggle({
  name = "Always Center",
  get = function()
    return vim.wo.scrolloff > 100
  end,
  set = function(enabled)
    vim.wo.scrolloff = 999 - vim.o.scrolloff
    if not enabled then -- Now it is enabled
      local buf_star_line = 0
      local buf_end_line = vim.api.nvim_buf_line_count(0)
      local current_line = vim.fn.line(".")

      local win_info = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
      local shown_lines = win_info.botline - win_info.topline + 1
      local offset = shown_lines / 2

      if (current_line - buf_star_line > offset) and (buf_end_line - current_line > offset) then
        vim.cmd("normal! zz")
      end
    end
  end,
}):map("<leader>u<cr>")

-- LazyVim.ui.maximize():map("<leader>zM")

-- stylua: ignore start
map("n", "<leader>u<Tab>", function()
  vim.ui.input({ prompt = "Enter Indent Width: " }, function(input)
    if not input then
      return
    end
    vim.bo.tabstop = tonumber(input)
    vim.bo.shiftwidth = tonumber(input)
    vim.notify("Set Indent Width to " .. input)
  end)
end,   "Set Indent Width" )
-- stylua: ignore end

local file_detail = function()
  local home = vim.fn.getenv("HOME")
  -- local filename = vim.fn.expand("%:p:t")
  -- local repo_root = vim.fn.system("git rev-parse --show-toplevel")
  --     :gsub(home, "~")
  --     :gsub("\n", "")
  -- local filedir = vim.fn.expand("%:p:h")
  --     :gsub(home, "~")
  --     :gsub(repo_root, "")
  local relative_file_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
  local msg = string.format(
    [[
Working Dir: %s
  File Path: %s
  File Type: %s
  Buffer Nr: %s
  Window Id: %s]],
    vim.fn.getcwd():gsub(home, "~"),
    "/" .. relative_file_path,
    vim.bo.filetype,
    vim.api.nvim_get_current_buf(),
    vim.api.nvim_get_current_win()
  )
  require("notify")(msg, vim.log.levels.INFO, { title = "File Info", timeout = 3000 })
end
map("n", "<leader>li", file_detail, "File Info")

-- Lazy
del("n", "<leader>l")
map("n", "<leader>nz", "<cmd>Lazy<cr>", "Lazy")
-- stylua: ignore
map("n", "<leader>nZ", function() LazyVim.news.changelog() end, "LazyVim Changelog")
