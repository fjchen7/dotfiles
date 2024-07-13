local M = {
  "neovim/nvim-lspconfig",
}

M.init = function()
  -- Override keymaps:
  -- https://github.com/LazyVim/LazyVim/blob/879e29504d43e9f178d967ecc34d482f902e5a91/lua/lazyvim/plugins/lsp/keymaps.lua#L15
  -- https://www.lazyvim.org/plugins/lsp#%EF%B8%8F-customizing-lsp-keymaps
  local goto_preview = function(method, opts)
    return function()
      require("goto-preview")[method](opts)
    end
  end
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local keymaps = {
    { "<leader>cl", false },
    { "<leader>nl", "<cmd>LspInfo<cr>", desc = "Print LSP Info" },
    -- {
    --   "<leader>nL",
    --   ":lua print(vim.inspect(vim.lsp.get_active_clients()[1].config.settings))<CR>",
    --   desc = "Print LSP Configuration",
    -- },
    {
      "<leader>nl",
      ":lua = copy(vim.lsp.get_active_clients()[1])<CR>",
      desc = "Print and Copy LSP Configuration",
    },

    -- { "gd", vim.lsp.buf.definition, desc = "Go Definition", has = "definition" },
    { "gD", vim.lsp.buf.declaration, desc = "Go Declaration" },
    -- { "gb", vim.lsp.buf.type_definition, desc = "Go Type Definition" },

    -- Split
    {
      "g<C-D>",
      function()
        vim.cmd("vs")
        vim.schedule(function()
          vim.lsp.buf.definition()
        end)
      end,
      desc = "Go Definition (Split)",
      has = "definition",
    },
    {
      "g<C-y>",
      function()
        vim.cmd("vs")
        vim.schedule(function()
          vim.lsp.buf.type_definition()
        end)
      end,
      desc = "Go Type Definition (Split)",
    },
    {
      "g<C-r>",
      function()
        vim.cmd("vs")
        vim.schedule(function()
          vim.lsp.buf.references()
        end)
      end,
      desc = "Go References (Split)",
    },
    {
      "g<C-i>",
      function()
        vim.cmd("vs")
        vim.schedule(function()
          vim.lsp.buf.implementation()
        end)
      end,
      desc = "Go Implementation (Split)",
    },
    -- {
    --   "gr",
    --   function()
    --     -- Exclude declaration. See: https://www.reddit.com/r/neovim/comments/r4y1jt/comment/hmjmmb9
    --     vim.lsp.buf.references({ includeDeclaration = false })
    --   end,
    --   desc = "Go References",
    -- },
    -- { "gr", "<cmd>Trouble lsp_references refresh=false<cr>", desc = "Go References" },
    -- { "gI", vim.lsp.buf.implementation, desc = "Go Implementation" },

    -- { "g<C-d>", goto_preview("goto_preview_definition"), desc = "Go Definition (Preview)", has = "definition" },
    -- { "g<C-S-d>", goto_preview("goto_preview_declaration"), desc = "Go Declaration (Preview)" },
    -- { "g<C-y>", goto_preview("goto_preview_type_definition"), desc = "Go Type Definition (Preview)" },

    -- goto-preview show references and implementations by telescope. I don't like.
    -- { "gr", goto_preview("goto_preview_references"), desc = "Go References" },
    -- { "gI", goto_preview("goto_preview_implementation"), desc = "Go Implementation" },

    -- { "K", false },
    {
      -- Mapping K in visual mode to avoid annoying v_K
      mode = { "n", "x" },
      "K",
      function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        -- :h ufo.txt
        if winid then
          local buf = vim.api.nvim_win_get_buf(winid)
          local ufo_keys = { "a", "i", "o", "A", "I", "O", "gd", "gr" }
          for _, k in ipairs(ufo_keys) do
            vim.keymap.set("n", k, "<CR>" .. k, { noremap = false, buffer = buf })
          end
        else
          vim.lsp.buf.hover()
        end
      end,
      desc = "Hover / Peek Fold",
    },

    { "gK", false },
    { "<C-k>", mode = "i", false },
    -- { "<M-s>", vim.lsp.buf.signature_help, mode = { "i", "n" }, desc = "Signature Help", has = "signatureHelp" },

    { "<leader>ca", false },
    { "<M-cr>", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v", "i" }, has = "codeAction" },
    { "<leader>cA", false },
    {
      "<M-S-cr>",
      function()
        vim.lsp.buf.code_action({
          context = {
            only = {
              "source",
            },
            diagnostics = {},
          },
        })
      end,
      desc = "Source Action",
      has = "codeAction",
    },

    { "<F2>", "<leader>cr", desc = "Rename", remap = true },
  }

  local keys = require("lazyvim.plugins.lsp.keymaps").get()
  for _, keymap in ipairs(keymaps) do
    keys[#keys + 1] = keymap
  end
end

M.opts = {
  -- :h vim.diagnostic.config()
  diagnostics = {
    -- :h vim.diagnostic.open_float
    float = {
      border = "single", -- 'single' | 'double' | 'shadow' | 'curved'
      focusable = true,
      -- focus = true,
    },
  },
  inlay_hints = {
    enabled = true,
  },
  codelens = {
    enabled = false,
  },
}

LazyVim.lsp.on_attach(function(client, buffer)
  if client.supports_method("textDocument/hover") then
    client.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "single",
      width = 80,
      title = "Hover",
    })
  end
end)

return M
