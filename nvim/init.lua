-- Is new loader available?
if vim.loader then
  vim.loader.enable()
end

-- Setup default options
require "options"
require "keymaps"

-- Are we inside Neovide?
if vim.g.neovide then
  require "neovide"
end

-- Are we outside VSCode?
if not vim.g.vscode then
  -- Bootstrap Lazy
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  -- Load lazy
  local ok, err = pcall(function()
    local plugins = require "plugins"
    local lazy    = require "lazy"

    lazy.setup(plugins)
  end)

  if not ok and err then
    vim.cmd "colorscheme slate"

    vim.schedule(function()
      vim.notify(err, vim.log.levels.ERROR)
    end)
  end
end

