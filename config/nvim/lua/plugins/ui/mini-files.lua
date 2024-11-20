-- TODO: integrate with git status
-- https://www.reddit.com/r/neovim/comments/1cfd5w1/minifiles_git_status_integration/
local M = {
  "echasnovski/mini.files",
  enabled = false,
}

M.keys = {
  {
    "<C-r>m",
    function()
      local ft = vim.bo.filetype
      if ft == "minifiles" then
        MiniFiles.close()
      else
        local path = MiniFiles.get_latest_path()
        if not path and vim.bo.buflisted then
          path = vim.fn.expand("%:p") -- file path
        end
        MiniFiles.open(path)
      end
    end,
    desc = "Open Mini Files",
  },
}

M.opts = {
  -- Module mappings created only inside explorer.
  -- Use `''` (empty string) to not create one.
  mappings = {
    close = "q",
    go_in = "l",
    go_in_plus = "L",
    go_out = "h",
    go_out_plus = "H",
    reset = "\\",
    reveal_cwd = "@",
    show_help = "?",
    synchronize = "=",
    trim_left = "<",
    trim_right = ">",
  },
  -- General options
  options = {
    -- Whether to delete permanently or move into module-specific trash
    permanent_delete = false,
    -- Whether to use for editing directories
    use_as_default_explorer = true,
  },
  windows = {
    max_number = math.huge,
    preview = false,
    width_focus = 30,
    width_nofocus = 25,
    width_preview = 80,
  },
  content = {
    filter = function(fs_entry)
      return not vim.startswith(fs_entry.name, ".")
    end,
  },
}

M.config = function(_, opts)
  require("mini.files").setup(opts)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "minifiles" },
    callback = function(opts)
      local opts = { buffer = opts.buf }
      local map = Util.map
      -- map("n", "<Esc>", MiniFiles.close, nil, opts)

      map("n", "<cr>", function()
        local entry = MiniFiles.get_fs_entry()
        MiniFiles.go_in()
        if entry.fs_type == "file" then
          MiniFiles.close()
        end
      end, "Open File", opts)

      map("n", "<C-p>", function()
        if _G.mini_files_preview == nil then
          _G.mini_files_preview = MiniFiles.config.windows.preview
        end
        _G.mini_files_preview = not _G.mini_files_preview
        MiniFiles.refresh({ windows = { preview = _G.mini_files_preview } })
      end, "Toggle Preview", opts)

      map("n", "<C-f>", function()
        vim.schedule(function()
          MiniFiles.close()
        end)
        local win_id = require("window-picker").pick_window()
        if win_id then
          local buf_id = vim.api.nvim_win_get_buf(win_id)
          local path = vim.api.nvim_buf_get_name(buf_id)
          vim.schedule(function()
            MiniFiles.open(path)
          end)
          return
        end
        local path = MiniFiles.get_latest_path()
        MiniFiles.open(path)
      end, "Locate Buffer", opts)

      local show_dotfiles = false
      map("n", ".", function()
        show_dotfiles = not show_dotfiles
        local filter_show = function(fs_entry)
          return true
        end
        local filter_hide = function(fs_entry)
          return not vim.startswith(fs_entry.name, ".")
        end
        local new_filter = show_dotfiles and filter_show or filter_hide
        MiniFiles.refresh({ content = { filter = new_filter } })
      end, "Toggle Hidden Files", opts)

      local map_split = function(lhs, desc, direction)
        local rhs = function()
          local new_target_window
          local cur_target_window = require("mini.files").get_explorer_state().target_window
          vim.api.nvim_win_call(cur_target_window, function()
            vim.cmd(direction .. " split")
            new_target_window = vim.api.nvim_get_current_win()
          end)
          MiniFiles.set_target_window(new_target_window)
          MiniFiles.go_in()
          MiniFiles.close()
        end
        -- local desc = "Split " .. direction
        map("n", lhs, rhs, desc, opts)
      end
      map_split("<C-s>", "Split Below", "belowright horizontal")
      map_split("<C-v>", "Split Right", "belowright vertical")
    end,
  })

  -- https://github.com/folke/snacks.nvim/blob/main/docs/rename.md#minifiles
  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesActionRename",
    callback = function(event)
      Snacks.rename.on_rename_file(event.data.from, event.data.to)
    end,
  })
end

return M
