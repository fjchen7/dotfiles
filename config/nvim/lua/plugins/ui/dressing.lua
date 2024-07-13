return {
  "stevearc/dressing.nvim",
  opts = {
    input = {
      start_in_insert = true,
    },
    select = {
      -- backend = { "nui" },
      get_config = function(opts)
        if opts.kind == "codeaction" then
          return {
            backend = "telescope",
            telescope = require("telescope.themes").get_dropdown({
              layout_config = {
                width = { 0.8, min = 50, max = 140 },
              },
            }),
          }
        end
      end,
    },
  },
  config = function(_, opts)
    require("dressing").setup(opts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "DressingSelect", "DressingInput" },
      callback = function(event)
        local map = Util.map
        local callback_opts = { buffer = event.buf }
        map("n", "q", "<cmd>q<cr>", nil, callback_opts)
      end,
    })
  end,
}
