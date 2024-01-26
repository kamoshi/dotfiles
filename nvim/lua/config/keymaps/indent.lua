local get_visual = require 'config.helpers.visual'
local M = {}


function M.normalize()
  local c = vim.fn.getpos '.'
  local s = get_visual()

  local max = 0
  for line = s.sr, s.er do
    local indent = vim.fn.indent(line)
    max = indent > max and indent or max
  end

  for line = s.sr, s.er do
    local content = vim.fn.getline(line)
    if content:len() > 0 then
      local current = vim.fn.indent(line)
      if current ~= max then
        local new = string.rep(' ', max - current)
        vim.fn.setline(line, new .. content)
      end
    end
  end

  vim.fn.setpos('.', c)
end

return M
