return {
  "akinsho/toggleterm.nvim",
  event = "VeryLazy",
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        local height = vim.o.lines * 0.2
        return height >= 20 and height or 20
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    float_opts = {
      width = math.floor(0.9 * vim.o.columns),
      height = math.floor(0.9 * vim.o.lines),
      winblend = 10, -- transparent
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
    local new_termimal = function()
      -- local session_name = require("possession.session").get_session_name()
      -- local cmd = session_name and "zellij attach -c " .. session_name or "zellij"
      local termimal = require("toggleterm.terminal").Terminal:new({
        -- cmd = cmd,
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "single",
        },
      })
      return termimal
    end
    local map = Util.map
    local toggle_cmd = function(...)
      local args = { ... } -- Capture varargs
      return function()
        if not _G.TOGGLETERM then
          _G.TOGGLETERM = new_termimal()
        end
        _G.TOGGLETERM:toggle(table.unpack(args))
      end
    end
    map({ "n", "t" }, "<C-\\>", toggle_cmd(nil, "float"), "Terminal")
    map({ "n", "t" }, "<C-M-\\>", toggle_cmd(nil, "horizontal"), "Terminal")
  end,
}
