return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "norg", "rmd", "org", "copilot-chat" },
  opts = {
    file_types = { "markdown", "copilot-chat" },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)
    vim.treesitter.language.register("markdown", "copilot-chat")
    LazyVim.toggle.map("<leader>uM", {
      name = "Render Markdown",
      get = function()
        return require("render-markdown.state").enabled
      end,
      set = function(enabled)
        local m = require("render-markdown")
        if enabled then
          m.enable()
        else
          m.disable()
        end
      end,
    })
  end,
}
