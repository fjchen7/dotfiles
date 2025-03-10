return {
  "echasnovski/mini.indentscope",
  opts = {
    -- symbol = "┃",
    -- draw = {
    --   delay = 100,
    --   animation = require("mini.indentscope").gen_animation.none(),
    -- },
    mappings = {
      object_scope = "ii",
      object_scope_with_border = "ai",
      goto_top = "[i",
      goto_bottom = "]i",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "man",
        "alpha",
        "dashboard",
        "fzf",
        "help",
        "lazy",
        "lazyterm",
        "mason",
        "neo-tree",
        "notify",
        "toggleterm",
        "Trouble",
        "trouble",

        "qf",
        "aerial",
        "oil",
        "oil_preview",
        "dropbar_menu",
        "grug-far-help",
        "rnvimr",
        "neo-tree-popup",
        "neotest-summary",
        "neotest-output",
        "neotest-output-panel",
        "yazi",
        "OverseerForm",
        "kitty-scrollback",
        "copilot-chat",
        "copilot-chat-selection",
        "",
      },
      callback = function(opts)
        vim.b[opts.buf].miniindentscope_disable = true
      end,
    })
  end,
  -- config = function(_, opts)
  --   local indentscopt = require("mini.indentscope")
  --   indentscopt.setup(opts)
  --
  --   local move = function(...)
  --     vim.cmd([[normal! m`]])
  --     indentscopt.move_cursor(...)
  --   end
  --   local map = Util.map
  --   map({ "x", "o" }, "ii", nil, "Indent Scope")
  --   map({ "x", "o" }, "ai", nil, "Indent Scope")
  --   -- stylua: ignore start
  --   local next_indent_inner, prev_indent_inner = Util.make_repeatable_move_pair(
  --     function() move("bottom", false) end,
  --     function() move("top", false) end)
  --   local next_indent_outer, prev_indent_outer = Util.make_repeatable_move_pair(
  --     function() move("bottom", true) end,
  --     function() move("top", true) end)
  --   -- stylua: ignore end
  --   map({ "n", "x", "o" }, "]i", next_indent_inner, "Indent End")
  --   map({ "n", "x", "o" }, "[i", prev_indent_inner, "Indent Start")
  --   map({ "n", "x", "o" }, "]I", next_indent_outer, "Indent End (Outer)")
  --   map({ "n", "x", "o" }, "[I", prev_indent_outer, "Indent Start (Outer)")
  --
  --   -- Darker highlight of IndentBlanklineChar
  --   vim.cmd([[hi! MiniIndentscopeSymbol guifg=#757a90]])
  -- end,
}
