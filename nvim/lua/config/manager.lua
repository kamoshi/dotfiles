local data = vim.fn.stdpath 'data'
local path = data .. '/lazy/lazy.nvim'


-- Bootstrap
if not vim.loop.fs_stat(path) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    path,
  }
end
vim.opt.rtp:prepend(path)

-- Load
local plugins = require 'config.plugins'
local lazy    = require 'lazy'

-- Init
lazy.setup(plugins)
