return {
  "akinsho/toggleterm.nvim",
  event = "BufReadPost",
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        local height = vim.o.lines * 0.45
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
    insert_mappings = true,
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

    -- local direction = "horizontal"
    local DIRECTION = "horizontal"
    local real_direction = function(direction)
      if direction == "auto" then
        return vim.o.columns > 125 and "vertical" or "horizontal"
      else
        return direction
      end
    end
    local close = function()
      _G.TOGGLETERM:close()
    end
    local open = function(size)
      local direction = real_direction(DIRECTION)
      _G.TOGGLETERM:open(size, direction)
      vim.defer_fn(function()
        vim.cmd("startinsert!")
      end, 100)
    end
    local toggle = function(size)
      vim.schedule(function()
        if _G.TOGGLETERM:is_open() and _G.TOGGLETERM.direction ~= DIRECTION and DIRECTION ~= "auto" then
          close()
        end
        if _G.TOGGLETERM:is_open() then
          close()
        else
          open(size)
        end
      end)
    end
    local map = Util.map
    map({ "n", "t" }, "<C-\\>", toggle, "Terminal")
    map({ "n", "t" }, "<C-M-\\>", function()
      local options = {
        "auto",
        "float",
        "vertical",
        "horizontal",
      }
      local callback = function(choice)
        if not choice then
          return
        end
        DIRECTION = choice:lower()
        if _G.TOGGLETERM:is_open() then
          close()
        end
        open(nil)
      end
      vim.ui.select(options, { prompt = "Select Terminal Layout:" }, callback)
    end, "Terminal Layout")
    vim.defer_fn(function()
      _G.TOGGLETERM = new_termimal()
      _G.TOGGLETERM:open()
      _G.TOGGLETERM:close()
    end, 0)
  end,
}
