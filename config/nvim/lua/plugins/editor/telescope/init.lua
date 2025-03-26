local M = {
  "nvim-telescope/telescope.nvim",
}

local function get_file_root_path()
  local path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  return path:gsub(vim.env.HOME, "~")
end

local function get_pwd_path()
  local path = vim.fn.getcwd()
  return path:gsub(vim.env.HOME, "~")
end

local function shorten_path(path)
  path = path:gsub(vim.env.HOME, "~")
  local start = math.max(1, #path - 19)
  if start > 1 then
    path = "..." .. path:sub(start)
  end
  return path
end

M.keys = function()
  -- stylua: ignore
  return {
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fB", function()
      Snacks.picker.buffers({ hidden = true, nofile = true, tittle = "Buffers (all)" })
    end, desc = "Buffers (all)" },
    -- {
    --   "<leader>ff",
    --   LazyVim.pick("files", { cwd = nil, hidden = false, no_ignore = false, follow = true, }),
    --   desc = "Find Files",
    -- },
    { "<Tab>", "<leader>ff", remap = true },
    { "<leader>ff", function()
      local path = get_pwd_path()
      local short_path = shorten_path(path)
      -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#files
      LazyVim.pick("files", {
        cwd = path,
        title = "Files in " .. short_path,
      })()
    end, desc = "Find Files (CWD)" },
    { "<leader>fF", function()
      local path = get_file_root_path()
      local short_path = shorten_path(path)
      LazyVim.pick("files", {
        cwd = path,
        title = "Files in " .. short_path .. " (File Root)"
      })()
    end,desc = "Find Files (File Root)" },
    -- { "<leader>fF", LazyVim.pick("files", { root = false, title = "Files (cwd)" }), desc = "Find Files (File Root)" },
    -- { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>fg", function()
      Snacks.picker.git_files( { untracked = true } )
    end, desc = "Find Files (Git)" },
    {
      "<leader>fr",
      function() Snacks.picker.recent({ title = "Recent Files" }) end,
      desc = "Recent Files",
    },
    {
      "<leader>fR",
      function() Snacks.picker.recent({ filter = { cwd = true }, title = "Recent (cwd)" }) end,
      desc = "Recent Files (CWD)",
    },
    { "<leader>pp", function() Snacks.picker.projects() end, desc = "Projects" },

    { "<C-f>", function()
      local path = get_pwd_path()
      local short_path = shorten_path(path)
      LazyVim.pick("live_grep", {
        dirs = { path },
        title = "Grep in " .. short_path
      })()
    end, desc = "Grep (Root)" },
    { "<C-f>", function()
      local path = get_pwd_path()
      local short_path = shorten_path(path)
      LazyVim.pick("grep_word", {
        dirs = { path },
        title = "Grep in " .. short_path
      })()
    end, desc = "Grep Selection (Root)", mode = { "x" } },
    { "<C-M-f>", function()
      local path = get_file_root_path()
      local short_path = shorten_path(path)
      LazyVim.pick("live_grep", {
        dirs = { path },
        title = "Grep in " .. short_path .. " (File Root)"
      })()
    end, desc = "Grep (File Root)" },
    { "<C-M-f>", function()
      local path = get_file_root_path()
      local short_path = shorten_path(path)
      LazyVim.pick("grep_word", {
        dirs = { path },
        title = "Grep in " .. short_path .. " (File Root)"
      })()
    end, desc = "Grep Selection (File Root)", mode = { "x" } },

    { "<leader>nZ", function() Snacks.picker.lazy() end, desc = "Search LazyVim Plugin" },
    { "<leader>nC", LazyVim.pick.config_files(), desc = "Find Config File" },

    -- git
    -- { "<leader>gf", "<cmd>Telescope git_bcommits<CR>", desc = "Show File Commits" },
    -- { "<leader>gF", "<cmd>Telescope git_commits<CR>", desc = "Project Commits" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    { "<leader>gr", function() Snacks.picker.git_branches() end, desc = "Git Branch" },
    { "<leader>gl", function() Snacks.picker.git_log_file() end, { desc = "Git Log (File)" } },
    { "<leader>gL", function() Snacks.picker.git_log({ cwd = LazyVim.root.git() }) end, { desc = "Git Log (Project)" } },
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (hunks)" },

    -- { "<leader>qj", "<cmd>Telescope marks<cr>", desc = "Jump to Mark (Telescope)" },

    { "<leader><Tab>", function() Snacks.picker.resume() end, desc = "Resume" },
    { "<F1>", function() Snacks.picker.help() end, desc = "List Help", },
    { "<leader>nh", function() Snacks.picker.highlights() end, desc = "Highlights", },
    { "<leader>na", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<leader>nk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>nc", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    { "<leader>nm", function() Snacks.picker.man() end, desc = "Man Pages" },
    { '<leader>"', function() Snacks.picker.registers() end, desc = "Registers" },
    -- { "<leader>nM", "<cmd>norm! K<cr>", desc = "Man Page under Cursor Word" },
    { "<leader>nf", "<CMD>Telescope filetypes<CR>", desc = "Set Filetype" },
    -- { "<leader>no", "<cmd>Telescope vim_options<cr>", desc = "List Vim Options" },

    -- Search Text
    -- { "<leader>/", LazyVim.pick("live_grep", { cwd = false }), desc = "Grep (cwd)" },
    -- { "<C-f>", LazyVim.pick("live_grep", { cwd = false }), desc = "Grep (cwd)" },
    -- { "<C-f>", LazyVim.pick("grep_string", { cwd = false }), mode = "v", desc = "Grep (cwd)" },
    -- { "<C-M-f>", LazyVim.pick("live_grep"), desc = "Grep (root dir)" },
    -- { "<C-M-f>", LazyVim.pick("grep_string"), mode = "v", desc = "Grep (root dir)" },

    -- { "<leader><C-f>", LazyVim.pick("grep_string", { cwd = false, word_match = "-w" }), desc = "Grep Word under Cursor (cwd)", },
    -- { "<leader><C-M-f>", LazyVim.pick("grep_string", { word_match = "-w" }), desc = "Grep Word under Cursor (root dir)" },

    -- Symbols
    -- {
    --   "<leader>it",
    --   function()
    --     require("telescope.builtin").lsp_dynamic_workspace_symbols({
    --       symbols = { "Class", "Enum", "Interface", "Struct", "Trait", "TypeParameter" },
    --       prompt_title = "LSP Workspace Symbols (Type)",
    --     })
    --   end,
    --   desc = "List Types",
    -- },
    -- {
    --   "<leader>iT",
    --   function()
    --     require("telescope.builtin").lsp_document_symbols({
    --       symbols = { "Class", "Enum", "Interface", "Struct", "Trait", "TypeParameter" },
    --       prompt_title = "LSP Workspace Symbols (Type) in Buffer",
    --     })
    --   end,
    --   desc = "List Types in Buffer",
    -- },
    -- {
    --   "<leader>if",
    --   function()
    --     require("telescope.builtin").lsp_dynamic_workspace_symbols({
    --       symbols = { "Function", "Method", "Constructor" },
    --       prompt_title = "LSP Workspace Symbols (Function)",
    --     })
    --   end,
    --   desc = "List Functions",
    -- },
    -- {
    --   "<leader>iF",
    --   function()
    --     require("telescope.builtin").lsp_document_symbols({
    --       symbols = { "Function", "Method", "Constructor" },
    --       prompt_title = "LSP Workspace Symbols (Function) in Buffer",
    --     })
    --   end,
    --   desc = "List Functions in Buffer",
    -- },
    -- {
    --   "<leader>il",
    --   function()
    --     require("telescope.builtin").lsp_dynamic_workspace_symbols({
    --       symbols = { "Package", "Namespace", "Module" },
    --       prompt_title = "LSP Workspace Symbols (Module)",
    --     })
    --   end,
    --   desc = "List Modules",
    -- },
    -- {
    --   "<leader>ic",
    --   function()
    --     require("telescope.builtin").lsp_dynamic_workspace_symbols({
    --       -- symbols = require("lazyvim.config").get_kind_filter(),
    --       symbols = { "Constant", "String", "Number", "Boolean" },
    --       prompt_title = "LSP Workspace Symbols (Constant)",
    --     })
    --   end,
    --   desc = "List Constants",
    -- },
    -- {
    --   "<leader>ia",
    --   function()
    --     require("telescope.builtin").lsp_dynamic_workspace_symbols({
    --       -- List: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#documentSymbolParams
    --       -- symbols = require("lazyvim.config").get_kind_filter(),
    --       prompt_title = "LSP Workspace Symbols (All)",
    --     })
    --   end,
    --   desc = "List All Symbols",
    -- },
  }
end

M.opts = function()
  local actions = require("telescope.actions")

  local open_with_trouble = require("trouble.sources.telescope").open
  local add_to_trouble = require("trouble.sources.telescope").add

  return {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = {
        "truncate", -- truncate long file name
        -- "smart",
        "filename_first",
      },
      results_title = false, -- hide results title
      dynamic_preview_title = true, -- Use dynamic preview title if avaliable
      wrap_results = false,
      -- sorting_strategy = "ascending", -- cursor starts from top result
      -- layout_strategy = "vertical", -- flex, bottom_pane, curcor, center, horizontal, vertical
      layout_config = {
        -- prompt_position = "top",
        flex = {
          -- use vertical layout when window column < filp_columns
          flip_columns = 160,
        },
        vertical = {
          height = 0.8,
          width = 120,
          preview_height = 0.4,
          mirror = true, -- flip location of results/prompt and preview windows
          -- prompt_position = "top",
        },
        horizontal = {
          -- mirror = true,
          width = 0.85,
          preview_width = 0.6,
        },
        center = {
          -- mirror = true,
        },
        bottom_pane = {
          height = { 0.5, min = 25, max = 50 },
        },
      },
      preview = {
        hide_on_startup = false,
      },

      file_ignore_patterns = { "node_modules", "/dist", "target" },

      -- open files in the first window that is an actual file.
      -- use the current window if no other window is available.
      get_selection_window = function()
        local wins = vim.api.nvim_list_wins()
        table.insert(wins, 1, vim.api.nvim_get_current_win())
        for _, win in ipairs(wins) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].buftype == "" then
            return win
          end
        end
        return 0
      end,

      mappings = {
        i = {
          ["<Esc>"] = actions.close, -- disable normal mode
          -- ["<CR>"] = actions.select_default + actions.center,
          ["<CR>"] = actions.select_default,
          ["<C-s>"] = actions.select_horizontal,
          ["<C-\\>"] = require("telescope.actions.layout").toggle_preview,
          -- qflist / loclist
          -- ["<C-t>"] = open_with_trouble,
          -- ["<M-t>"] = add_to_trouble,
          -- ["<M-q>"] = open_selected_with_qflist,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.smart_add_to_qflist + actions.open_qflist,
          ["<C-l>"] = actions.smart_send_to_loclist + actions.open_loclist,
          ["<M-l>"] = actions.smart_add_to_loclist + actions.open_loclist,
          -- Navigation
          -- ["<C-Down>"] = actions.cycle_previewers_next,
          -- ["<C-Up>"] = actions.cycle_previewers_prev,
          ["<C-j>"] = actions.cycle_history_next,
          ["<C-k>"] = actions.cycle_history_prev,
          ["<C-S-n>"] = actions.results_scrolling_down,
          ["<C-S-p>"] = actions.results_scrolling_up,
          ["<M-n>"] = actions.preview_scrolling_down,
          ["<M-p>"] = actions.preview_scrolling_up,
          -- Disable defaults
          ["<C-x>"] = false, -- select_horizontal
          ["<PageUp>"] = false, -- results_scrolling_up
          ["<Pagedown>"] = false, -- results_scrolling_down
          ["<C-u>"] = false, -- preview_scrolling_up
          ["<C-d>"] = false, -- preview_scrolling_down
          ["<C-f>"] = false, -- preview_scrolling_left
          ["<M-f>"] = false, -- results_scrolling_left
        },
        n = {
          ["q"] = actions.close,
        },
      },
    },
    pickers = require("plugins.editor.telescope.pickers"),
  }
end

M.config = function(_, opts)
  require("telescope").setup(opts)
  -- Show line number and cursorline in preview: https://github.com/nvim-telescope/telescope.nvim/issues/1186
  vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
  vim.cmd("autocmd User TelescopePreviewerLoaded setlocal cursorline")
  -- Wrap Preview
  vim.cmd([[autocmd User TelescopePreviewerLoaded setlocal wrap]])
end

return M
