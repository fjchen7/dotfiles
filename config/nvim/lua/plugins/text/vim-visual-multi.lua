return {
  "mg979/vim-visual-multi",
  event = "VeryLazy",
  enabled = true,
  init = function()
    -- Tips: after entering to multi mode by <C-g>
    -- * n/N find next/prev matched
    -- * q skip current
    --
    -- Tips: start multi-cursor mode
    -- * \\ add under cursor
    -- * \/ select by regex
    -- * \A select all
    --
    -- vim.g.VM_default_mappings = false
    vim.g.VM_leader = "\\"
    -- :h vim-visual-multi
    -- :h vm-faq-custom-mappings
    -- :h vm-faq-mappings
    -- :h vm-mappings-all
    --
    vim.g.VM_maps = {
      ["Add Cursor Down"] = "<C-n>",
      ["Add Cursor Up"] = "<C-p>",
      ["Find Under"] = "<C-g>",
      ["Find Subword Under"] = "<C-g>",
      ["Select All"] = "<C-S-g>",
      ["Visual All"] = "<C-S-g>",
      -- NOTE: mouse not work in zellij
      ["Mouse Cursor"] = "<M-LeftMouse>",
      ["Mouse Word"] = "<M-RightMouse>",
      -- ["Mouse Column"] = "<M-LeftMouse>",
      -- ["VM Select h"] = "<S-left>",
      -- ["VM Select l"] = "<S-right>",
    }

    -- hslens mess up highlighting
    vim.api.nvim_create_autocmd("User", {
      pattern = "visual_multi_start",
      callback = function(args)
        vim.cmd([[HlSearchLensDisable]])
      end,
    })
    vim.api.nvim_create_autocmd("User", {
      pattern = "visual_multi_exit",
      callback = function(args)
        vim.cmd([[HlSearchLensEnable]])
      end,
    })

    -- Help: :h vm-highlight
    -- vim.g.VM_theme = "neon"
    vim.defer_fn(function()
      vim.cmd([[
        hi! link VM_Mono CurSearch
        hi! link VM_Extend CurSearch
        hi! link VM_Cursor CurSearch
        hi! VM_Insert guibg=#F977C2 guifg=#111111  " Same as my cursor
      ]])
    end, 1000)
  end,
}
