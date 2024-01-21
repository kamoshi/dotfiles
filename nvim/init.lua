-- Is new loader available?
if vim.loader then
  vim.loader.enable()
end

-- Setup default options
require 'config.options'
require 'config.keymaps'

-- Are we inside Neovide?
if vim.g.neovide then
  require 'config.neovide'
end

-- Try load package manager
local ok, err = pcall(function()
  require 'config.manager'
end)

if not ok and err then
  vim.cmd 'colorscheme slate'

  vim.schedule(function()
    vim.notify(err, vim.log.levels.ERROR)
  end)
end
