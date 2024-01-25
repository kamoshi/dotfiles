local defaults = { noremap = true, silent = true }

---@class KeymapOpts
---@field [1]? string Shorthand description
---@field desc? string Description
---@field [2]? number|boolean Shorthand buffer
---@field buffer? number|boolean Buffer

---Wrapper around `vim.keymap.set`
---@param modes string|string[]
return function(modes)
  ---@param lhs string
  return function(lhs)
    ---@param rhs string|function
    return function(rhs)
      ---@param opts string|KeymapOpts
      return function(opts)
        local kind = type(opts) ---@cast kind 'string'|'table'
        ---@type table
        local options

        if kind == 'string' then
          options = vim.tbl_extend('force', defaults, {desc=opts})
        else
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
