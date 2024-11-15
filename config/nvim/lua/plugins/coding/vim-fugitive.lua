return {
  "tpope/vim-fugitive",
  dependencies = {
    "tpope/vim-rhubarb", -- Support :Browse of fugitive
  },
  event = "VeryLazy",
  cmd = { "Git", "GRemove" },
  keys = {
    {
      "<leader>gg",
      -- "<cmd>Git<cr><cmd>wincmd L<cr><cmd>vertical resize 60<cr><cmd>6<cr>",
      "<cmd>Git<cr>",
      desc = "Git (fugitive)",
    },
    -- { "<leader>gB", "<cmd>Git blame --date=relative<cr>", desc = "File Blame (fugitive)" },
    {
      "<leader>gB",
      "<cmd>Git blame --date=format:'%Y-%m-%d %H:%M'<cr>",
      desc = "File Blame (fugitive)",
    },
    -- {
    --   mode = "n",
    --   "<leader>go",
    --   function()
    --     local clipboard = vim.fn.getreg("+")
    --     vim.cmd([[silent! GBrowse!]])
    --     local url = vim.fn.getreg("+")
    --     local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
    --     url = url .. [[\#L]] .. tonumber(line)
    --     vim.cmd([[silent! !open "]] .. url .. [["]])
    --     vim.fn.setreg("+", clipboard)
    --   end,
    --   desc = "Open File's GitHub URL",
    -- },
    {
      mode = "n",
      "<leader>go",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Open File's GitHub URL",
    },
    {
      mode = "n",
      "<leader>gy",
      function()
        vim.cmd([[silent! GBrowse!]])
        local url = vim.fn.getreg("+")
        local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
        url = url .. [[#L]] .. tonumber(line)
        vim.fn.setreg("+", url)
        vim.notify("Copied to clipboard: " .. url, "info", { title = "vim-fugitive" })
      end,
      desc = "Copy File's GitHub URL",
    },
    { mode = "x", "<leader>go", [["vy<cmd>'<,'>GBrowse<cr>]], desc = "Open File's Ranged GitHub URL" },
    { mode = "x", "<leader>gy", [["vy<cmd>'<,'>GBrowse!<cr>]], desc = "Copy File's Ranged GitHub URL" },
    { mode = "n", "<leader>ga", [[<cmd>Git absorb<cr>]], desc = "Git absorb" },
    {
      mode = "n",
      "<leader>ld",
      function()
        local filename = vim.api.nvim_buf_get_name(0)
        vim.cmd("GRemove")
        require("mini.bufremove").delete()
        vim.notify("Delete " .. filename .. " from Git")
      end,
      desc = "[G] Delete File",
    },
    {
      mode = "n",
      "<leader>lD",
      function()
        local filename = vim.api.nvim_buf_get_name(0)
        vim.cmd("GRemove!")
        require("mini.bufremove").delete()
        vim.notify("Delete " .. filename .. " from Git forcely")
      end,
      desc = "[G] Delete File Forcely",
    },
    -- stylua: ignore end
    {
      mode = "n",
      "<leader>lm",
      function()
        vim.ui.input({
          prompt = "[G] Move File to: ",
          default = "./" .. vim.fn.expand("%:."),
        }, function(input)
          if not input then
            return
          end
          vim.cmd("GMove " .. input)
        end)
      end,
      desc = "[G] Move File",
    },
    {
      mode = "n",
      "<leader>lr",
      function()
        vim.ui.input({
          prompt = "[G] Enter New File Name: ",
          default = vim.fn.expand("%:t"),
        }, function(input)
          if not input then
            return
          end
          vim.cmd("GRename " .. input)
        end)
      end,
      desc = "[G] Rename File",
    },
  },
  init = function()
    local help_tags = {
      ["fugitiveblame"] = "Git_blame",
      ["fugitive"] = "fugitive-map",
    }
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "fugitiveblame", "fugitive" },
      callback = function(opts)
        local cmd = string.format("<cmd>h %s<cr>", help_tags[vim.bo.filetype])
        vim.keymap.set("n", "?", cmd, { buffer = true, silent = true })
        vim.keymap.set("n", "<Tab>", "dv", { remap = true, buffer = true, silent = true }) -- Diff
        vim.bo[opts.buf].buflisted = false
      end,
    })
  end,
}
