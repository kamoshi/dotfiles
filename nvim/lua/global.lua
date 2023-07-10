local g = vim.g
local o = vim.o
local opt = vim.opt

-- Indentation
opt.tabstop = 2
opt.smartindent = true
opt.shiftwidth = 2
opt.expandtab = true

-- Line numbers
opt.number = true

vim.filetype.add({
  extension = {
    mdx = "mdx"
  }
})

