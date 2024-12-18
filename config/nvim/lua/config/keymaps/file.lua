local map = vim.keymap.set
local del = vim.keymap.del

-- map("n", "<leader>l<CR>", function()
--   local path = vim.fn.expand("%:p")
--   vim.cmd("silent !open " .. path)
-- end, { desc = "Open File by Default APP" })
map("n", "<leader>le", function()
  local path = vim.fn.getcwd()
  vim.cmd("silent !open " .. path)
end, { desc = "Reveal CWD in Explorer" })
map("n", "<leader>lo", function()
  local path = vim.fn.expand("%:p")
  vim.cmd("silent !code " .. path)
end, { desc = "Open File by VSCode" })
map("n", "<leader>lO", function()
  local path = vim.fn.getcwd()
  vim.cmd("silent !code " .. path)
end, { desc = "Open CWD by VSCode" })
map("n", "<leader>lR", function()
  local path = vim.fn.getcwd()
  vim.cmd([[silent !open -na "RustRover.app" --args ]] .. path)
end, { desc = "Open Project by RustRover" })
map("n", "<leader>lc", function()
  local path = vim.fn.expand("%:p:h")
  vim.cmd("silent cd " .. path)
  vim.notify("cd to " .. path:gsub(vim.fn.getenv("HOME"), "~"))
end, { desc = "cd to File Directory" })
map("n", "<leader>lC", function()
  vim.cmd("Gcd")
  vim.notify("cd to Git repo root " .. vim.fn.getcwd():gsub(vim.fn.getenv("HOME"), "~"))
end, { desc = "cd to Repo Root" })
map("n", "<leader>lp", function()
  local file_path = vim.fn.expand("%:p")
  vim.fn.setreg("+", file_path)
  vim.notify("File Path Copied\n" .. file_path, vim.log.levels.INFO)
end, { desc = "Copy File Path" })
