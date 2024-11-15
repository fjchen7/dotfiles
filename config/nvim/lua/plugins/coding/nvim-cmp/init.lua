if true then
  return {}
end
local M = {
  -- rebase two branch
  -- llllvvuu/nvim-cmp, branch feat/above
  -- yioneko/nvim-cmp, branch perf
  "hrsh7th/nvim-cmp", --   "llllvvuu/nvim-cmp",
  enabled = true,
  event = {
    "InsertEnter",
    "CmdlineEnter",
  },
  -- Do not update util the PR below is merged.
  -- Tracked features:
  -- Show completion menu above the cursor.
  --   - https://github.com/hrsh7th/nvim-cmp/issues/495
  --   - https://github.com/hrsh7th/nvim-cmp/pull/1701
  pin = true,
}

M.dependencies = {
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  -- "saadparwaiz1/cmp_luasnip",
  "fjchen7/cmp_luasnip",
  { "fjchen7/cmp-luasnip-choice", opts = {} },
  "abecodes/tabout.nvim",
  "altermo/ultimate-autopair.nvim",
  "windwp/nvim-autopairs",
}

local cmp = require("cmp")
local keymaps = require("plugins.coding.nvim-cmp.keymaps")
local format = require("plugins.coding.nvim-cmp.format")

M.opts = function(_, opts)
  table.insert(opts.sources, 1, {
    name = "luasnip_choice",
    group_index = 1,
    priority = 1000,
  })

  for i, source in ipairs(opts.sources) do
    opts.sources[i] =
      vim.tbl_deep_extend("force", source, require("plugins.coding.nvim-cmp.sources")[source.name] or {})
  end

  -- Disable keymaps from LazyVim
  opts.mapping = {}

  local override = {
    -- preselect = cmp.PreselectMode.Item,
    preselect = cmp.PreselectMode.None, -- https://www.reddit.com/r/neovim/comments/1ba6kkp/comment/ku0qwqb
    completion = {
      completeopt = "menu,menuone,noselect", -- menu,menuone,noselect
      keyword_length = 0,
    },
    experimental = {
      ghost_text = false,
      -- ghost_text = {
      --   hl_group = "CmpGhostText",
      -- },
    },

    view = {
      entries = {
        -- https://github.com/hrsh7th/nvim-cmp/pull/1701
        vertical_positioning = "above",
        follow_cursor = false,
      },
    },
    -- mapping = cmp.mapping.preset.insert(keymaps.mapping),
    mapping = keymaps.mapping,
    -- https://www.reddit.com/r/neovim/comments/1f1rxtx
    -- performance = {
    --   debounce = 10, --  60ms by default
    --   throttle = 5, --  30ms by default
    --   fetching_timeout = 20, -- 80ms by default
    -- },
    formatting = {
      expandable_indicator = false, -- Do not show ~ indicator
      -- format = format.format,
    },
    window = {
      completion = {
        border = "none",
        col_offset = 2,
      },
      documentation = {
        border = "single",
      },
    },
    sorting = require("plugins.coding.nvim-cmp.sorting"),
  }

  opts = vim.tbl_deep_extend("force", opts or {}, override)
  return opts
end

local cmdline_opts = function(override)
  local opts = {
    window = { completion = { border = "none" } },
    completion = {
      autocomplete = {
        cmp.TriggerEvent.InsertEnter,
        cmp.TriggerEvent.TextChanged,
      },
    },
    -- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/mapping.lua#L61
    mapping = cmp.mapping.preset.cmdline(keymaps.mapping_cmdline),
    formatting = {
      format = format.format_cmdline,
    },
  }
  opts = vim.tbl_deep_extend("force", opts or {}, override)
  return opts
end

M.config = function(_, opts)
  for _, source in ipairs(opts.sources) do
    source.group_index = source.group_index or 1
  end
  cmp.setup(opts)
  cmp.setup.cmdline(
    { "/", "?" },
    cmdline_opts({
      sources = { { name = "buffer" } },
    })
  )
  cmp.setup.cmdline(
    ":",
    cmdline_opts({
      sources = {
        { name = "cmdline" },
        { name = "path" },
      },
    })
  )
end

return M
