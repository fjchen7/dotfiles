local M = {
  "folke/which-key.nvim",
}

M.opts = function()
  return {
    plugins = {
      marks = false,
      briefmarks = false, -- my which-key plugins
      spelling = true,
      presets = {
        -- text_objects = false,
        -- operators = false,
        -- motions = false,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    icons = {
      -- Default rules: https://github.com/folke/which-key.nvim/blob/main/lua/which-key/icons.lua#L16
      rules = {
        { pattern = "copilot", icon = " ", color = "green" },
        { pattern = "replace", icon = " ", color = "green" },
      },
    },
  }
end

M.config = function(_, opts)
  local wk = require("which-key")
  wk.setup(opts)

  local ignored = "which_key_ignore"
  wk.add({
    mode = { "n", "v" },
    { "g", mode = { "n", "o" }, group = "goto" },
    -- FIX: s can't invoke cheatsheet
    { "s", "<Nop>", mode = { "n", "o", "v" }, group = "misc" },
    { "]", mode = { "n", "o" }, group = "next" },
    { "[", mode = { "n", "o" }, group = "prev" },
    -- ["<leader><tab>"] = { group = "+tabs" },
    { "<C-t>", group = "tab" },
    { "<C-r>", group = "neo-tree" },
    { "<leader>", group = "leader" },
    { "<leader>c", group = "code" },
    { "<leader>f", group = "find" },
    { "<leader>g", group = "git" },
    { "<leader>l", group = "file/directory/path" },
    { "<leader>d", group = "diagnostic/todos" },
    { "<leader>u", group = "toggle" },
    { "<leader>uI", group = "inspect" },
    -- { "<leader>h", group = "quickfix/trouble" },
    { "<leader>e", group = "debug print" },
    { "<leader>r", group = "refactor/replace" },
    -- { "<leader>s", group = "search" },
    { "<leader>o", group = "overseer" },
    { "<leader>t", group = "test" },
    { "<leader>s", group = "symbols" },
    { "<leader>ss", desc = "List Symbol (Buffer)" },
    { "<leader>sS", desc = "List Symbol (Workspace)" },
    { "<leader>p", group = "session" },
    { "<leader>n", group = "nvim config" },
    { "{", desc = "Prev Blank Line" },
    { "}", desc = "Next Blank Line" },
    { "<C-Left>", desc = "Decrease Window Width (←↑→↓)" },
  }, {})

  vim.defer_fn(function()
    -- stylua: ignore
    local ignored_keys = {
      "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
      "<C-e>", "<C-y>", "<C-d>", "<C-u>", "<C-u>", "<C-u>",
      "w", "b", "e", "ge", "f", "F", "h", "j", "k", "l", "V", "G", "U", "Y", "<C-Y>", "^", "$", "t", "T", "c", "d", "y",
      "gg",
      ",", ";",
      "<C-Right>", "<C-Up>", "<C-Down>",
      -- Hide some LazyVim default keymaps
      "<leader>wm", "<leader>uz", "<leader>uZ"
    }
    for _, key in ipairs(ignored_keys) do
      wk.add({ { key, hidden = true }, mode = { "n", "x", "o" } })
    end
  end, 1000)

  -- require("plugins.editor.which-key.presets")

  -- Get back to original poistion from visual mode
  -- Use case: after vib to select and <esc> to cancel the visual, <C-o> can jump back
  local map = Util.map
  map("n", "v", "m`v")
  map("n", "vv", "m`v$o")
  map("n", "V", "m`V")
  map("n", "<C-V>", "m`<C-V>")
  -- Use ` to compatible with treesitter incremental_selection which marks v continusouly
  map("n", "gv", "m`gv")
end

return M
