-- Is new loader available?
if vim.loader then
  vim.loader.enable()
end

-- Setup default options
require("options")

-- Are we inside Neovide?
if vim.g.neovide then
  require("neovide")
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
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  -- Load lazy
  local ok, err = pcall(function()
    local plugins, lazy = require("plugins"), require("lazy")
    lazy.setup(plugins)
    vim.keymap.set('n', '<leader>pm', lazy.home, { desc = "Package manager: open" })
  end)

  if not ok then
    -- save my eyes
    vim.cmd("colorscheme slate")
    vim.schedule(function()
      vim.notify(err, vim.log.levels.ERROR)
    end)
  end
end

