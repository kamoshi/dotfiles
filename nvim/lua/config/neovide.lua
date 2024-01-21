local options = {
  scroll_animation_far_lines = 100,
  scroll_animation_length    = 0.05,
  cursor_animation_length    = 0.05,
}

for key, val in pairs(options) do
  vim.g['neovide_' .. key] = val
end

-- Japanese IME compat
local function set_ime(args)
  if args.event:match 'Enter$' then
    vim.g.neovide_input_ime = true
  else
    vim.g.neovide_input_ime = false
  end
end

local ime_input = vim.api.nvim_create_augroup('ime_input', { clear = true })

vim.api.nvim_create_autocmd({ 'InsertEnter', 'InsertLeave' }, {
  group = ime_input,
  pattern = '*',
  callback = set_ime
})

vim.api.nvim_create_autocmd({ 'CmdlineEnter', 'CmdlineLeave' }, {
  group = ime_input,
  pattern = '[/\\?]',
  callback = set_ime
})
