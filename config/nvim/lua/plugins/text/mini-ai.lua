return {
  "echasnovski/mini.ai",
  event = "BufReadPost",
  init = function()
    -- fix lazyVim register which-key for mini.ai.
    -- see: https://github.com/LazyVim/LazyVim/issues/3720
    if not vim.g.vscode then
      LazyVim.mini.ai_whichkey = function() end
    end
  end,
  opts = function()
    local gen_spec = require("mini.ai").gen_spec
    local ai = require("mini.ai")
    return {
      -- search_method = "cover", -- No find next
      n_lines = 500,
      mappings = {
        around = "a",
        inside = "i",
        around_next = "",
        inside_next = "",
        around_last = "",
        inside_last = "",
        -- Keep it consistent with normal ] and [ move
        goto_left = "",
        goto_right = "",
      },
      custom_textobjects = {
        o = ai.gen_spec.treesitter({ -- code block
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }),
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
        C = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
        t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
        m = gen_spec.function_call({ name_pattern = "[%w_:%.]" }),
        -- k = { { "%b<>" }, "^.().*().$" },
      },
    }
  end,
  config = function(_, opts)
    require("mini.ai").setup(opts)
    -- ]a and [a move to start at parameter. Defaults stay at end.
    local next_para_repeat, prev_para_repeat = Util.make_repeatable_move_pair(function()
      require("mini.ai").move_cursor("right", "i", "a", { search_method = "next" })
    end, function()
      require("mini.ai").move_cursor("left", "i", "a", { search_method = "prev" })
    end)
    local map = Util.map
    map({ "n", "x", "o" }, "]a", next_para_repeat, "Next Parameter")
    map({ "n", "x", "o" }, "[a", prev_para_repeat, "Prev Parameter")

    if vim.g.vscode then
      return
    end

    -- register all text objects with which-key
    local ai_whichkey = function()
      local objects = {
        [" "] = "Whitespace",
        _ = "Underscore",
        a = "Argument",
        b = "(...), [...], {...}",
        B = "{...}",
        q = "`...`, \"...\" '...'",
        p = "Paragraph",
        o = "Block, Condition, Loop",
        f = "Function Body",
        C = "Class Body",
        m = "Function Call Arguments",
        t = "Tag",
        ["?"] = "User Prompt",
      }
      for _, v in ipairs({ '"', "'", "`", "(", ")", ">", "<lt>", "[", "]", ",", "}", "{", "w", "W" }) do
        objects[v] = "which_key_ignore"
      end
      local ret = { mode = { "o", "x" } }
      for prefix, name in pairs({
        i = "inside",
        a = "around",
      }) do
        ret[#ret + 1] = { prefix, group = name }
        for obj, desc in pairs(objects) do
          ret[#ret + 1] = { prefix .. obj, desc = desc }
        end
      end

      require("which-key").add(ret, { notify = false })
    end
    ai_whichkey()
  end,
}
