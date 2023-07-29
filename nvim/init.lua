-- Setup global config
require("global")

-- Setup Neovide config
-- Only run this if inside Neovide
if vim.g.neovide then
  require("neovide")
end

-- Bootstrap package manager
do
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
end

-- Load lazy
local lazy_ok, lazy = pcall(require, "lazy")
if lazy_ok then
  lazy.setup(require("plugins"))
  vim.keymap.set('n', '<leader>pm', lazy.home, { desc = "Package manager: open" })
else
  print("(init) Couldn't load Lazy")
end

