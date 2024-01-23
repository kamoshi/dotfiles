---Tags used for filtering certain features
---@alias ComposerTag
--- | 'standalone' # True if running as a standalone application
--- | 'linux'      # True if running on Linux

---@type table<ComposerTag, boolean>
local env = {
  standalone = not vim.g.vscode,
  linux      = jit.os == 'Linux',
}

---@param tags ComposerTag | ComposerTag[]
---@return boolean
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

---@param tags ComposerTag | ComposerTag[]
local function when(tags)
  local match = is(tags)
  ---@generic T
  ---@param value `T`
  ---@return T | nil
  return function(value)
    return match and value or nil
  end
end

return function()
  return is, when
end
