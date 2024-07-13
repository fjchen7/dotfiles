-- More beautiful quickfix appearance
-- https://github.com/kevinhwang91/nvim-bqf#format-new-quickfix
local fn = vim.fn

function _G.qftf(info)
  local items
  local ret = {}
  -- The name of item in list is based on the directory of quickfix window.
  -- Change the directory for quickfix window make the name of item shorter.
  -- It's a good opportunity to change current directory in quickfixtextfunc :)
  --
  -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
  -- local root = getRootByAlterBufnr(alterBufnr)
  -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
  --
  if info.quickfix == 1 then
    items = fn.getqflist({ id = info.id, items = 0 }).items
  else
    items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
  end
  local limit = 30
  local fnameFmt1, fnameFmt2 = "%-" .. limit .. "s", "…%." .. (limit - 1) .. "s"
  -- local validFmt = "%s │%5d:%-3d│%s %s"
  local validFmt = "%s │ %4d │ %-s %s"
  local last_fname = nil
  local cwd = vim.fn.getcwd()
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    local fname = ""
    local str
    if e.valid == 1 then
      if e.bufnr > 0 then
        fname = fn.bufname(e.bufnr)
        -- CUSTOMIZATION: remove folder
        if string.sub(fname, 1, #cwd) == cwd then
          fname = string.sub(fname, #cwd + 2)
        end
        -- CUSTOMIZATION: remove the same file in consecution
        if fname == "" then
          fname = "[No Name]"
        else
          if last_fname == fname then
            fname = ""
          else
            last_fname = fname
            fname = fname:gsub("^" .. vim.env.HOME, "~")
          end
        end
        -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
        if #fname <= limit then
          fname = fnameFmt1:format(fname)
        else
          fname = fnameFmt2:format(fname:sub(1 - limit))
        end
      end
      local lnum = e.lnum > 99999 and -1 or e.lnum
      local col = e.col > 999 and -1 or e.col
      local qtype = e.type == "" and "" or " " .. e.type:sub(1, 1):upper()
      -- CUSTOMIZATION: remove leading space
      local text = string.gsub(e.text, "^%s+", "")
      str = validFmt:format(fname, lnum, qtype, text)
    else
      str = e.text
    end
    table.insert(ret, str)
  end
  return ret
end

vim.o.qftf = "{info -> v:lua._G.qftf(info)}"

vim.api.nvim_create_autocmd("filetype", {
  pattern = { "qf" },
  callback = function(opts)
    vim.keymap.set("n", "q", "<cmd>hide<cr>", { buffer = opts.buf })
  end,
})
