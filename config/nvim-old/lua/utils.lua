local M = {}

M.non_code_filetypes = {
  "help",
  "git",
  "gitcommit",
  "quickfix",
  "fugitive",
  "fugitiveblame",
  "symbols-outline",
  "nvim-dap-ui",
  "lspsagaoutline",
  "qf",
  "spectre_panel",
  "Trouble",
  "calltree",
  "TelescopePrompt",
  "notify",
  "harpoon",
  "NvimTree",
  "fzf",
  "toggleterm",
  "sagarename",
  "DressingInput",
  "DressingSelect",
  "sagacodeaction",
  "DiffviewFiles",
  "startify",
  ""
}

M.is_non_code_filetype = function(filetype)
  return M.is_in_table(M.non_code_filetypes, filetype)
end

M.get_non_code_filetypes = function(added_filetypes, removed_filetypes)
  local filetypes = {}
  for _, filetype in ipairs(M.non_code_filetypes) do
    table.insert(filetypes, filetype)
  end
  for _, filetype in ipairs(added_filetypes) do
    table.insert(filetypes, filetype)
  end
  for _, filetype in ipairs(removed_filetypes) do
    table.remove(filetypes, filetype)
  end
  return filetypes
end

-- https://github.com/stevearc/resession.nvim/blob/master/lua/resession/init.lua#L531
_G.filter_buf = function(bufnr)
  local buftype = vim.bo[bufnr].buftype
  if buftype == "help" then
    return true
  end
  if buftype ~= "" and buftype ~= "acwrite" then
    return false
  end
  if vim.api.nvim_buf_get_name(bufnr) == "" then
    return false
  end
  return vim.bo[bufnr].buflisted
end

_G.copy = function(...)
  local msg = "empty params"
  local params = {}
  if next({ ... }) then
    -- get the count of the params
    for i = 1, select('#', ...) do
      -- select the param
      local param = select(i, ...)
      table.insert(params, vim.inspect(param))
    end
  else
  end
  if #params > 0 then
    msg = table.concat(params, "\n")
  end
  vim.fn.setreg("+", msg)
end
_G.set = vim.keymap.set
_G.inspect = vim.inspect
_G.Utils = M