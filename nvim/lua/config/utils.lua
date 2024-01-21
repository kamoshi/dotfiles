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
        local type = type(opts)
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


---@class AugroupOpts
---@field [1] string Name
---@field clear? boolean Clear existing commands if the group already exists

---Wrapper around `vim.api.nvim_create_augroup`
---@param opts string|AugroupOpts
---@return number
function M.augroup(opts)
  local type = type(opts)
  local name, options
  if type == 'string' then
    name, options = opts, {}
  elseif type == 'table' then
    name, options = opts[1], opts
    options[1] = nil
  end
  return vim.api.nvim_create_augroup(name, options)
end


---@class AutocmdOpts
---@field [1]? string Shorthand desc
---@field desc? string Description for this autocommand
---@field group? string|number
---@field callback? function

---Wrapper around `vim.api.nvim_create_autocmd`
---@param event string|string[]
function M.autocmd(event)
  ---@param opts AutocmdOpts
  return function(opts)
    opts.desc = opts[1] or opts.desc
    opts[1] = nil
    ---@param callback? function
    return function(callback)
      opts.callback = callback
      vim.api.nvim_create_autocmd(event, opts)
    end
  end
end


---@param config LazyPluginSpec
function M.as_extendable(config)
---@param base LazyPluginSpec
---@return LazyPluginSpec
  return function(base)
    return vim.tbl_extend('keep', base, config)
  end
end

return M
