return {
  -- Shortcuts to toggle kitty-scrollback:
  -- * Cmd+Shift+b (default is <C-S-h>) for all content in terminal screent
  -- * Cmd+b (default is <C-S-g>) for last command output
  -- See more: https://github.com/mikesmithgh/kitty-scrollback.nvim#-features
  "mikesmithgh/kitty-scrollback.nvim",
  enabled = true,
  lazy = true,
  cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
  event = { "User KittyScrollbackLaunch" },
  opts = {},
  config = function(_, opts)
    require("kitty-scrollback").setup(opts)

    vim.api.nvim_create_autocmd({ "FileType" }, {
      group = vim.api.nvim_create_augroup("KittyScrollbackNvimFileType", { clear = true }),
      pattern = { "kitty-scrollback" },
      callback = function(_opts)
        vim.opt.number = true
        local set = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { buffer = _opts.bufnr })
        end
        set("n", "q", "<Plug>(KsbQuitAll)")
        set("n", "<CR>", "<Plug>(KsbPasteCmd)")
        return true
      end,
    })
  end,
}
