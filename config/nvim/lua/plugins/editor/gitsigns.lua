-- Override default gitsigns
-- https://github.com/LazyVim/LazyVim/blob/879e29504d43e9f178d967ecc34d482f902e5a91/lua/lazyvim/plugins/editor.lua#L334-L368
local M = {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
}

M.opts = {
  signs_staged_enable = false,
  attach_to_untracked = true,
  word_diff = false,
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 200,
  },
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
    end

    local prev_hunk = function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end

    local next_hunk = function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end

    local next_hunk_repeat, prev_hunk_repeat = Util.make_repeatable_move_pair(next_hunk, prev_hunk)
    map({ "n", "x", "o" }, ")", next_hunk_repeat, "[G] Next Git Change")
    map({ "n", "x", "o" }, "(", prev_hunk_repeat, "[G] Prev Git Change")

      -- stylua: ignore start
      map("n", "<M-a>", gitsigns.stage_hunk, "[G] Stage Git Hunk")
      map("v", "<M-a>", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "[G] Stage Git Hunk")
      map("n", "<M-S-a>", function()
        gitsigns.stage_buffer()
        vim.notify("Stage Buffer", "info", { title = "Gitsigns" })
      end, "[G] Stage Buffer")
      map("n", "<leader><M-a>", function()
        gitsigns.undo_stage_hunk()
        vim.notify("Undo Stage Hunk", "info", { title = "Gitsigns" })
      end, "[G] Undo Stage Hunk")

      map("n", "<M-u>", gitsigns.reset_hunk, "[G] Reset Hunk")
      map("v", "<M-u>", function() gitsigns.reset_hunk ({ vim.fn.line('.'), vim.fn.line('v') }) end, "[G] Reset Hunk")
      map("n", "<M-S-u>", function()
        gitsigns.reset_buffer()
        vim.notify("Reset Buffer", "warn", { title = "Gitsigns" })
      end, "[G] Reset Buffer")

      map("n", "g<CR>", gitsigns.preview_hunk, "[G] Preview Hunk")

      map("n", "<leader>gb", function() gitsigns.blame_line({ full = true }) end, "Git Blame Line (Gitsigns)")
      map("n", "<leader>gd", gitsigns.diffthis, "Diff With Staging Area")
      map("n", "<leader>gD", function() gitsigns.diffthis("~1") end, "Diff With Last Commit")

      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "[G] Git Hunk")
  end,
}

M.config = function(_, opts)
  local gitsigns = require("gitsigns")
  local config = require("gitsigns.config").config
  gitsigns.setup(opts)
  vim.defer_fn(function()
    LazyVim.toggle.map("<leader>ub", {
      name = "Inline Git Blame",
      get = function()
        return config.current_line_blame
      end,
      set = function(_)
        gitsigns.toggle_current_line_blame()
      end,
    })
    LazyVim.toggle.map("<leader>ug", {
      name = "Inline Git Diff",
      get = function()
        return config.word_diff
      end,
      set = function(_)
        gitsigns.toggle_word_diff()
      end,
    })
    LazyVim.toggle.map("<leader>uG", {
      name = "Inline Git Deleted",
      get = function()
        return config.show_deleted
      end,
      set = function(_)
        gitsigns.toggle_deleted()
      end,
    })
    -- vim.cmd([[
    --   hi! GitSignsChangeInline guibg=#656149
    --   hi! GitSignsChangeLnInline guifg=none
    -- ]])
  end, 100)
end

return M
