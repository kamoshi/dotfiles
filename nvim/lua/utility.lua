local M = {}

local def_opts = {noremap = true, silent = true}

---Loads plugin config
---@param path string
function M.plugin(path)
  local loaded = require(path)
  ---@param meta table
  ---@return table
  return function(meta)
    return vim.tbl_extend("keep", meta, loaded)
  end
end

---Wrapper around `vim.keymap.set`
---@param modes string|string[]
function M.curried_map(modes)
  ---@param lhs string
  return function(lhs)
    ---@param rhs string|function
    return function(rhs)
      ---@param opts string|table
      return function(opts)
        local supplied = type(opts)
        local options
        if supplied == "string" then
          options = vim.tbl_extend("force", def_opts, {desc=opts})
        else
          options = vim.tbl_extend("force", def_opts, opts)
        end
        vim.keymap.set(modes, lhs, rhs, options)
      end
    end
  end
end

return M
