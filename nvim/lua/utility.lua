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

---@class KeymapOpts
---@field [1] string? Shorthand description
---@field desc string? Description
---@field [2] number|boolean? Shorthand buffer
---@field buffer number|boolean? Buffer

---Wrapper around `vim.keymap.set`
---@param modes string|string[]
function M.keymap(modes)
  ---@param lhs string
  return function(lhs)
    ---@param rhs string|function
    return function(rhs)
      ---@param opts string|KeymapOpts
      return function(opts)
        local supplied = type(opts)
        local options
        if supplied == "string" then
          options = vim.tbl_extend("force", def_opts, {desc=opts})
        elseif supplied == "table" then
          opts.desc = opts[1] or opts.desc
          opts.buffer = opts[2] or opts.buffer
          opts[1], opts[2] = nil, nil
          options = vim.tbl_extend("force", def_opts, opts)
        end
        vim.keymap.set(modes, lhs, rhs, options)
      end
    end
  end
end

return M
