-- New bytecode cache
vim.loader.enable()

-- Setup global config
require("global")

-- Only run this if inside Neovide
if vim.g.neovide then
  require("neovide")
end

-- Bootstrap Lazy
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

-- Bootstrap Fennel
do
  local hotpotpath = vim.fn.stdpath("data") .. "/lazy/hotpot.nvim"
  if not vim.loop.fs_stat(hotpotpath) then
    vim.notify("Bootstrapping hotpot.nvim...", vim.log.levels.INFO)
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--single-branch",
      -- You may with to pin a known version tag with `--branch vX.Y.Z`
      "https://github.com/rktjmp/hotpot.nvim.git",
      hotpotpath,
    })
  end
  vim.opt.rtp:prepend(hotpotpath)
end

-- Load Fennel
require("hotpot")

-- Load lazy
local lazy_ok, lazy = pcall(require, "lazy")
if lazy_ok then
  lazy.setup(require("plugins"))
  vim.keymap.set('n', '<leader>pm', lazy.home, { desc = "Package manager: open" })
else
  print("(init) Couldn't load Lazy")
end

