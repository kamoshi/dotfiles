---@alias Tag
---  | 'standalone'
---  | 'linux'

---@type table<Tag, boolean>
local env = {
  standalone = not vim.g.vscode,
  linux      = jit.os == 'Linux',
}

---@param tags Tag | Tag[]
local function is(tags)
  if type(tags) == 'string' then
    return env[tags] or false
  end

  for _, tag in ipairs(tags) do
    if not env[tag] then
      return false
    end
  end
  return true
end

---@param tags Tag | Tag[]
local function when(tags)
  local match = is(tags)
  ---@generic T
  ---@param table `T`
  ---@return T | nil
  return function(table)
    return match and table or nil
  end
end

return function()
  return is, when
end
