-- Setup default options
require 'config.options'
require 'config.keymaps'
require 'config.autocmd'

-- Are we inside Neovide?
if vim.g.neovide then
  require 'config.neovide'
end

-- Try load package manager
local ok, err = pcall(require, 'config.manager')

if not ok then
  vim.cmd 'colorscheme slate'

  vim.schedule(function()
    vim.notify(err, vim.log.levels.ERROR)
  end)
end
