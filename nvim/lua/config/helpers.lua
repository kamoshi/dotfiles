local M = {}


local defaults = { noremap = true, silent = true }

---@class KeymapOpts
---@field [1]? string Shorthand description
---@field desc? string Description
---@field [2]? number|boolean Shorthand buffer
---@field buffer? number|boolean Buffer

---Wrapper around `vim.keymap.set`
---@param modes string|string[]
function M.keymap(modes)
  ---@param lhs string
  return function(lhs)
    ---@param rhs string|function
    return function(rhs)
      ---@param opts string|KeymapOpts
      return function(opts)
        -- Either 'string' or 'table'
        local type = type(opts)
        ---@type table
        local options
        if type == 'string' then
          options = vim.tbl_extend('force', defaults, {desc=opts})
        elseif type == 'table' then
          opts.desc = opts[1] or opts.desc
          opts.buffer = opts[2] or opts.buffer
          opts[1], opts[2] = nil, nil
          options = vim.tbl_extend('force', defaults, opts)
        end
        vim.keymap.set(modes, lhs, rhs, options)
      end
    end
  end
end


return M
