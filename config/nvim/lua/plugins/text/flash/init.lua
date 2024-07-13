local M = {
  "folke/flash.nvim",
}

M.keys = function()
  -- local methods = require("plugins.text.flash.methods")
  return {
    {
      "f",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump({
          label = {
            before = false,
            after = true,
            rainbow = {
              enabled = true,
            },
          },
          jump = {
            autojump = false,
          },
        })
      end,
      desc = "Jump (Flash)",
    },
    -- {
    --   "t",
    --   mode = { "n", "x", "o" },
    --   function()
    --     methods.two_char_jump([[\(^ *\)\@<=\S]])
    --   end,
    --   desc = "Jump to Line",
    -- },
    -- {
    --   "r",
    --   mode = { "o" },
    --   function()
    --     require("flash").remote()
    --   end,
    --   desc = "Remote (Flash)",
    -- },
    -- {
    --   "R",
    --   mode = { "o", "x" },
    --   function()
    --     methods.treesitter_remote({
    --       search = { multi_window = true },
    --       label = { rainbow = { enabled = true } },
    --     })
    --   end,
    --   desc = "Treesitter Remote (Flash)",
    -- },
    {
      "r",
      mode = { "o" },
      function()
        require("flash").treesitter_search({
          label = { rainbow = { enabled = true } },
        })
      end,
      desc = "Remote Treesitter Range (Flash)",
    },
    {
      "<CR>",
      mode = { "n", "o", "x" },
      function()
        require("flash").treesitter({
          label = { rainbow = { enabled = true } },
        })
      end,
      desc = "Treesitter Range (Flash)",
    },
    -- {
    --   "g<space>",
    --   mode = { "n" },
    --   function()
    --     methods.peek_definition()
    --   end,
    --   desc = "Peek Definition Remotely (Flash)",
    -- },
    -- {
    --   "<leader>d<Tab>",
    --   mode = { "n", "x" },
    --   function()
    --     methods.peek_diagnostics({
    --       label = {
    --         after = false,
    --         -- before = true,
    --         before = { 0, 0 }, -- label on first char
    --         rainbow = {
    --           enabled = true,
    --         },
    --       },
    --       search = { max_length = 0 },
    --       highlight = {
    --         groups = {
    --           current = "",
    --           match = "",
    --         },
    --       },
    --     })
    --   end,
    --   desc = "Peek Diagnostics Remotely (Flash)",
    -- },
  }
end

vim.g.FLASH_SEARCH_ENABLED = true
M.config = function(_, opts)
  require("flash").setup(opts)
  LazyVim.toggle.map("<leader>u/", {
    name = "Search (Flash)",
    get = function()
      return vim.g.FLASH_SEARCH_ENABLED
    end,
    set = function(enabled)
      require("flash").toggle()
      vim.g.FLASH_SEARCH_ENABLED = not vim.g.FLASH_SEARCH_ENABLED
    end,
  })
end

M.opts = {
  -- labels = "dfghjklqwertyuiopcvbnm90",
  highlight = {
    -- Highlight the mated text
    groups = {
      match = "FlashCurrent",
      current = "FlashCurrent", -- Thr first matched
    },
  },
  jump = {
    inclusive = false,
  },
  search = {
    exclude = {
      "notify",
      "cmp_menu",
      "noice",
      "flash_prompt",
      "neo-tree",
      "aerial",
      function(win)
        -- exclude non-focusable windows
        return not vim.api.nvim_win_get_config(win).focusable
      end,
    },
  },
  modes = {
    search = {
      enabled = vim.g.FLASH_SEARCH_ENABLED,
    },
    char = {
      enabled = false,
      keys = { "f", "F" },
      jump_labels = true,
      -- search bidirectionally
      -- search = { wrap = true },
      label = {
        exclude = "",
        -- exclude = "hjkliardcAZTU",
        rainbow = {
          enabled = false,
        },
      },
    },
  },
}

return M
