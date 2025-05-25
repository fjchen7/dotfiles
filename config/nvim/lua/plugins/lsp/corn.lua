local M = {
  -- Show Diagnostic in right hand side
  "RaafatTurki/corn.nvim",
  event = "BufReadPost",
  enabled = false,
}

local enabled_diagnostics_opts = {
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 1,
    source = "if_many",
    prefix = "●",
  },
  severity_sort = true,
}

local disabled_diagnostics_opts = {
  underline = true,
  virtual_text = false,
}

M.dependencies = {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = disabled_diagnostics_opts,
    },
  },
}

M.opts = {
  auto_cmds = false,
  on_toggle = function(is_hidden)
    -- Turn on builtin inline diagnostics when corn is hidden, and vice versa
    local opts = is_hidden and disabled_diagnostics_opts or enabled_diagnostics_opts
    vim.diagnostic.config(opts)
  end,
  icons = {
    error = LazyVim.config.icons.diagnostics.Error,
    warn = LazyVim.config.icons.diagnostics.Warn,
    hint = LazyVim.config.icons.diagnostics.Hint,
    info = LazyVim.config.icons.diagnostics.Info,
  },
}

M.config = function(_, opts)
  require("corn").setup(opts)
  vim.cmd([[
    hi! DiagnosticVirtualTextError guibg=none
    hi! DiagnosticVirtualTextWarn guibg=none
    hi! DiagnosticVirtualTextHint guibg=none
    hi! DiagnosticVirtualTextInfo guibg=none
  ]])
  -- vim.cmd("Corn toggle")
end

return M
