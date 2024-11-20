local M = {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  },
}

M.keys = function()
  local function pick(kind)
    return function()
      local actions = require("CopilotChat.actions")
      local items = actions[kind .. "_actions"]()
      if not items then
        LazyVim.warn("No " .. kind .. " found on the current line")
        return
      end
      local ok = pcall(require, "fzf-lua")
      require("CopilotChat.integrations." .. (ok and "fzflua" or "telescope")).pick(items)
    end
  end

  local ask_something_fn = function(system_prompt, input_title)
    return function()
      local on_confirm = function(input)
        if vim.fn.empty(input) ~= 1 then
          require("CopilotChat").ask(input, {
            system_prompt = system_prompt .. "\n无论我用什么语言提问，都请用中文回答。",
          })
        end
      end
      vim.ui.input({ prompt = input_title }, on_confirm)
    end
  end

  return {
    { "<leader>k", "", desc = "+Copilot Chat", mode = { "n", "v" } },
    { mode = { "n", "x", "i" }, "<C-CR>", "<cmd>CopilotChatToggle<CR>", desc = "Toggle Copilot Chat" },
    { mode = { "n", "x" }, "<leader>kx", "<cmd>CopilotChatReset<CR>", desc = "Reset Copilot Chat" },
    {
      "<leader>k<Tab>",
      function()
        local options = { "vertical", "horizontal", "float" }
        vim.ui.select(options, {
          prompt = "Change CopilotChat Layout:",
        }, function(choice)
          if not choice then
            return
          end
          local layout = choice:lower()
          local chat = require("CopilotChat")
          chat.config.window = vim.tbl_deep_extend("force", chat.config.window, {
            layout = layout,
            height = layout == "horizontal" and 0.4 or 0.6,
          })
          chat.close()
          chat.open()
        end)
      end,
      desc = "Change Layout",
    },
    {
      "<leader>kl",
      mode = { "n", "x" },
      function()
        local questions = {
          ["Explain Code"] = "CopilotChatExplain",
          ["Generate Documentations"] = "CopilotChatDocs",
          ["Generate Tests"] = "CopilotChatTests",
          ["Optimize Code"] = "CopilotChatOptimize",
          ["Review Code"] = "CopilotChatReview",
          ["Fix Problem"] = "CopilotChatFix",
          ["Fix Diagnostic"] = "CopilotChatFixDiagnostic",
          ["Write Commit Message"] = "CopilotChatCommit",
          -- ["Write Commit"] = "CopilotChatCommitStaged",
        }
        local options = {
          "Explain Code",
          "Fix Diagnostic",
          "Fix Problem",
          "Generate Documentations",
          "Generate Tests",
          "Optimize Code",
          "Review Code",
          "Write Commit Message",
        }
        for i, option in ipairs(options) do
          options[i] = tostring(i) .. ") " .. option
        end
        local callback = function(choice)
          if not choice then
            return
          end
          choice = string.sub(choice, 4)
          local fn = questions[choice]
          if type(fn) == "string" then
            vim.cmd(fn)
          else
            fn()
          end
        end
        vim.ui.select(options, { prompt = "Select an CopilotChat Action:" }, callback)
      end,
      desc = "Action (Explain, Diagnostic, Generate Doc or Test ...)",
    },
    {
      mode = { "n", "x" },
      "<leader>kn",
      ask_something_fn(
        [[你是一个精通Neovim和Lua的专家。我会问你Lua和Neovim的问题，请用简单易懂的语言为我回答，并尽量用lua api实现我的需求。]],
        "请输入neovim和lua的问题："
      ),
      desc = "Ask about Neovim/Lua",
    },
    {
      mode = { "n", "x" },
      "<leader>kr",
      ask_something_fn(
        [[你是一个精通Rust的专家。我会问你有关Rust的问题，请用简单易懂的语言为我回答。]],
        "请输入Rust的问题："
      ),
      desc = "Ask about Rust",
    },
    {
      mode = { "n", "v" },
      "<leader>kk",
      ask_something_fn([[]], "请输入你的问题："),
      desc = "Quick Chat (CopilotChat)",
    },
    -- {
    --   mode = { "n", "x" },
    --   "<leader>kc",
    --   function()
    --     local mode = vim.fn.mode()
    --     if mode == "n" then
    --       local total_lines = vim.api.nvim_buf_line_count(0)
    --       local max_lines = 600
    --       if total_lines > max_lines then
    --         local answer =
    --           vim.fn.input(string.format("当前文件的行数超过 %d 行, 是否继续？(y/n): ", max_lines))
    --           -- stylua: ignore
    --           if answer:lower() ~= "y" then return end
    --       end
    --     end
    --     local prompt = string.format("/COPILOT_EXPLAIN 解释这段 %s 代码", vim.bo.filetype)
    --     require("CopilotChat").ask(prompt, {
    --       prompt = prompt,
    --       selection = function(source)
    --         local select = require("CopilotChat.select")
    --         return select.visual(source) or select.buffer(source)
    --       end,
    --     })
    --   end,
    --   desc = "Explain Code",
    -- },
    -- { "<leader>kd", pick("help"), desc = "Diagnostic Action", mode = { "n", "v" } },
    -- { "<leader>kp", pick("prompt"), desc = "Prompt Actions", mode = { "n", "v" } },
  }
end

M.opts = {
  question_header = " User ",
  answer_header = "  Copilot ",
  auto_follow_cursor = true,
  auto_insert_mode = false,
  selection = function(source)
    local select = require("CopilotChat.select")
    return select.visual(source) or select.buffer(source)
  end,
  window = {
    layout = "vertical",
    relative = "cursor",
    width = 0.45,
    height = 0.6,
    row = 1,
    col = -10,
  },
  mappings = {
    reset = {
      normal = "<BS>",
      insert = "",
    },
    submit_prompt = {
      normal = "<CR>",
      insert = "<CR>",
    },
    close = {
      normal = "q",
    },
  },
}

M.config = function(_, opts)
  local prompts = require("CopilotChat.prompts")
  -- system_prompt: prompts.COPILOT_INSTRUCTIONS
  for key, prompt in pairs(prompts) do
    prompts[key] = prompt
      .. "\nYou must reply in Chinese unless the answer is documentations, comments, code or git commit message.\n"
  end

  local chat = require("CopilotChat")
  -- https://github.com/CopilotC-Nvim/CopilotChat.nvim#tips
  if pcall(require, "cmp") then
    require("CopilotChat.integrations.cmp").setup()
  end

  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "copilot-chat",
    callback = function(opts)
      local columns = vim.o.columns
      local win_width = vim.api.nvim_win_get_width(0)
      local is_horizontal = win_width == columns
      if is_horizontal then
        vim.opt_local.number = true
        vim.opt_local.signcolumn = "auto"
      else
        vim.opt_local.number = false
        vim.opt_local.signcolumn = "no"
      end
      -- local map = Util.map
      -- local bufnr = opts.buf
      -- map("i", "<S-CR>", "<CR>", nil, { buffer = bufnr })
    end,
  })
  chat.setup(opts)
end

return M
