---@class VisualArea
---@field sr number Start row
---@field sc number Start col
---@field er number End row
---@field ec number End col

---Get current visual selection area
---@return VisualArea
return function()
  local select = vim.fn.getpos 'v'
  local cursor = vim.fn.getpos '.'
  local sr, er = select[2], cursor[2]
  local sc, ec = select[3], cursor[3]

  if sc > ec then sc, ec = ec, sc end
  if sr > er then sr, er = er, sr end

  return { sr = sr, sc = sc, er = er, ec = ec }
end
