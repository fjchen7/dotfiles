local map = Util.map
local del = function(...)
  pcall(vim.keymap.del, ...)
end

-- Tabs
-- https://github.com/LazyVim/LazyVim/blob/879e29504d43e9f178d967ecc34d482f902e5a91/lua/lazyvim/config/keymaps.lua#L164
del("n", "<leader><tab>l")
del("n", "<leader><tab>f")
del("n", "<leader><tab><tab>")
del("n", "<leader><tab>]")
del("n", "<leader><tab>d")
del("n", "<leader><tab>[")
del("n", "<leader><tab>o")

local remap_ctrl_key = function(prefix)
  for char = string.byte("a"), string.byte("z") do
    local letter = string.char(char)
    local fromMapping = string.format("<c-%s><c-%s>", prefix, letter)
    local toMapping = string.format("<c-%s>%s", prefix, letter)
    map("n", fromMapping, toMapping, nil, { remap = true })
  end
end

map("n", "<C-->", "<cmd>tabp<cr>", "Prev Tab")
map("n", "<C-=>", "<cmd>tabn<cr>", "Next Tab")
map("n", "<C-t>-", "<cmd>-tabmove<cr>", "Move Tab to Prev")
map("n", "<C-t>=", "<cmd>+tabmove<cr>", "Move Tab to Next")
map("n", "<c-t>N", "<Cmd>tabnew<Cr>", "New Tab")
map("n", "<c-t>n", "<Cmd>tabedit %<Cr>", "New Tab (Break Out)")
map("n", "<c-t>d", "<cmd>tabclose<cr>", "Close Tab")
map("n", "<c-t>o", "<cmd>tabonly<cr>", "Close Other Tabs")
map("n", "<C-t>t", "g<Tab>", "Go to Last Visited Tab (<M-t>)")
remap_ctrl_key("t")

-- Buffers
del("n", "[b")
del("n", "]b")
del("n", "<leader>`")
del("n", "<leader>bb")
del("n", "<leader>bd")
del("n", "<leader>bD")
map("n", "<C-w>V", "<cmd>vs #<cr>", "Split Alternative Buffer Vertically")
map("n", "<C-w>S", "<cmd>sp #<cr>", "Split Alternative Buffer")
remap_ctrl_key("b")
remap_ctrl_key("r")

-- Windows
del("n", "<leader>w")
del("n", "<leader>wd")
del("n", "<leader>bo")
-- del("n", "<leader>wm")
del("n", "<leader>-")
del("n", "<leader>|")
map("n", "<C-w>n", "<CMD>vnew<CR>", "New Window")
map("n", "<C-w>N", "<CMD>new<CR>", "New Window Vertically")
-- map("n", "<C-w>w", "<CMD>wincmd p<CR>", "Alternative Window")
-- map("n", "<C-w><C-w>", "<CMD>wincmd p<CR>", nil, { remap = true })
map({ "n", "t" }, "<M-tab>", function()
  local current_win_id = vim.api.nvim_get_current_win()
  local alternative_win_id = vim.api.nvim_eval('win_getid(winnr("#"))')
  if current_win_id == alternative_win_id then
    vim.cmd("wincmd w")
  else
    vim.cmd("wincmd p")
  end
end, "Alternative Window", { remap = true })
-- map("n", "<C-w>V", "<cmd>vs #<cr>", "Split Alternative Buffer")
-- map("n", "<C-w>S", "<cmd>sp #<cr>", "Split Alternative Buffer (Vertical)")

-- https://github.com/LazyVim/LazyVim/blob/879e29504d43e9f178d967ecc34d482f902e5a91/lua/lazyvim/config/keymaps.lua#L132
-- del("n", "<leader>qq")
-- Lazygit
-- del("n", "<leader>gg")
del("n", "<leader>gG")
del("n", "<leader>gl")
del("n", "<leader>gL")

map("n", "<leader>gh", function()
  Snacks.lazygit({ args = { "log" }, cwd = LazyVim.root.git() })
end, "Commits History (LazyGit)")
-- map("n", "<leader>gH", function()
--   LazyVim.lazygit({ args = { "log" } })
-- end, "Commits History (cwd)")
