local M = { "MagicDuck/grug-far.nvim" }

M.keys = function()
  local replace = function(path)
    local is_visual = vim.fn.mode():lower():find("v")
    if is_visual then -- needed to make visual selection work
      vim.cmd([[normal! v]])
    end
    local grug = require("grug-far");
    (is_visual and grug.with_visual_selection or grug.open)({
      prefills = {
        paths = path,
      },
    })
  end

  return {
    {
      "<leader>rr",
      function()
        local path = vim.fn.expand("%")
        replace(path)
      end,
      mode = { "n", "v" },
      desc = "Replace in Buffer",
    },
    {
      "<leader>rR",
      function()
        replace()
      end,
      mode = { "n", "v" },
      desc = "Replace in Global",
    },
    {
      "<leader>rw",
      function()
        require("grug-far").open({
          prefills = {
            search = vim.fn.expand("<cword>"),
            paths = vim.fn.expand("%"),
          },
        })
      end,
      desc = "Replace Word under Cursor",
    },
    {
      "<leader>rW",
      function()
        require("grug-far").open({
          prefills = {
            search = vim.fn.expand("<cWORD>"),
            paths = vim.fn.expand("%"),
          },
        })
      end,
      desc = "Replace WORD under Cursor",
    },
  }
end

-- https://github.com/MagicDuck/grug-far.nvim/blob/main/lua/grug-far/opts.lua
M.opts = {
  startInInsertMode = false,
  engines = {
    -- see https://github.com/BurntSushi/ripgrep
    ripgrep = {
      extraArgs = "--smart-case",
      placeholders = {
        flags = "ex: --help --case-sensitive (-s) --replace= (empty replace) --multiline (-U)",
      },
    },
  },
}

return M
