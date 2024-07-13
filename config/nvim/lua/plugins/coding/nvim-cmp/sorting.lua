local compare = require("cmp.config.compare")

-- local luasnip_postfix = function(entry1, entry2)
--   if not entry1.context.cursor_before_line then
--     return
--   end
--   if entry1.source.name == "luasnip" and entry2.source.name == "luasnip" then
--     -- vim.notify(entry1.context.cursor_before_line, vim.log.levels.INFO, { title = "" })
--     if entry1.context.cursor_before_line:match("@[%S%.]+$") then
--       local label1 = entry1.completion_item.label
--       local label2 = entry2.completion_item.label
--       if label1 and label1:sub(1, 1) == "@" then
--         return true
--       end
--       if label2 and label2:sub(1, 1) == "@" then
--         return false
--       end
--     end
--   end
--   return nil
-- end

local luasnip_choice = function(entry1, entry2)
  -- e = entry1
  if entry1.source.name == "luasnip_choice" and entry2.source.name == "luasnip_choice" then
    return entry1.completion_item.index < entry2.completion_item.index
  end
  return nil
end

-- If entry1 and entry2 are both exact, then rank luasnip higher if it is.
-- reference method: compare.exact
local luasnip_exact = function(entry1, entry2)
  if entry1.source.name == "luasnip" and entry1.exact then
    return true
  elseif entry2.source.name == "luasnip" and entry2.exact then
    return false
  end

  if entry1.exact ~= entry2.exact then
    return entry1.exact
  end
  return nil
end

local luasnip_offset = function(entry1, entry2)
  if entry1.source.name == "luasnip" then
    return true
  elseif entry2.source.name == "luasnip" then
    return false
  end
  return compare.offset(entry1, entry2)
end

local copilot_first = function(entry1, entry2)
  local is_copilot1 = entry1.source.name == "copilot"
  local is_copilot2 = entry2.source.name == "copilot"
  if is_copilot1 and is_copilot2 then
    return nil
  elseif is_copilot1 then
    return true
  elseif is_copilot2 then
    return false
  end
end

local luasnip_first = function(entry1, entry2)
  local is_luasnip1 = entry1.source.name == "luasnip"
  local is_luasnip2 = entry2.source.name == "luasnip"

  if is_luasnip1 and is_luasnip2 then
    -- local is_postfix_luasnip1 = entry1.completion_item.label:sub(1, 1) == "@"
    -- local is_postfix_luasnip2 = entry2.completion_item.label:sub(1, 1) == "@"
    -- if is_postfix_luasnip1 and not is_postfix_luasnip2 then
    --   return true
    -- elseif not is_postfix_luasnip1 and is_postfix_luasnip2 then
    --   return false
    -- end

    local exact_len = function(cursor_before_line, label)
      cursor_before_line = string.lower(cursor_before_line)
      label = string.lower(label)
      local len = 0
      while len < #label do
        local prefix = string.sub(label, 1, len + 1)
        local postfix = string.sub(cursor_before_line, -(len + 1))
        if postfix ~= prefix then
          break
        end
        len = len + 1
      end
      return len
    end

    local cursor_before_line = entry1.context.cursor_before_line
    local len1 = exact_len(cursor_before_line, entry1.completion_item.label)
    local len2 = exact_len(cursor_before_line, entry2.completion_item.label)

    if len1 == len2 then
      return nil
      -- return #entry1.completion_item.label < #entry2.completion_item.label
      -- return entry1.id < entry2.id
    else
      return len1 > len2
    end
  elseif is_luasnip1 then -- luasnip first
    return true
  elseif is_luasnip2 then
    return false
  end

  return nil
end

-- From: https://www.reddit.com/r/neovim/comments/1f406tx/comment/lki5z2p
local types = require("cmp.types")
local priority_map = {
  [types.lsp.CompletionItemKind.EnumMember] = 1,
  [types.lsp.CompletionItemKind.Variable] = 2,
  [types.lsp.CompletionItemKind.Text] = 100,
}

local kind = function(entry1, entry2)
  local kind1 = entry1:get_kind()
  local kind2 = entry2:get_kind()
  kind1 = priority_map[kind1] or kind1
  kind2 = priority_map[kind2] or kind2
  if kind1 ~= kind2 then
    if kind1 == types.lsp.CompletionItemKind.Snippet then
      return true
    end
    if kind2 == types.lsp.CompletionItemKind.Snippet then
      return false
    end
    local diff = kind1 - kind2
    if diff < 0 then
      return true
    elseif diff > 0 then
      return false
    end
  end
end

-- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua#L62-L76
-- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/compare.lua
return {
  comparators = {
    copilot_first,
    luasnip_first,
    luasnip_choice,
    compare.offset,
    compare.exact,
    compare.score,
    kind,
    compare.recently_used,
    compare.locality,
    compare.kind,
    -- compare.sort_text,
    compare.length,
    compare.order,
  },
}
