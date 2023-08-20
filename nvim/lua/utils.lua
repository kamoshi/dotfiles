local M = {}


--- Loads plugin config
---@param path string
---@return fun(meta: table): table
function M.plugin(path)
  local loaded = require(path)
  return function(meta)
    return vim.tbl_extend("keep", meta, loaded)
  end
end

return M

