return {
  "echasnovski/mini.pairs",
  config = function(_, opts)
    LazyVim.mini.pairs(opts)
    local pairs = require("mini.pairs")
    local open = pairs.open
    pairs.open = function(pair, neigh_pattern)
      local o, c = pair:sub(1, 1), pair:sub(2, 2)
      -- Disable ' pairs in rust
      if o == "'" and vim.bo.filetype == "rust" then
        return "'"
      end
      return open(pair, neigh_pattern)
    end
  end,
}
