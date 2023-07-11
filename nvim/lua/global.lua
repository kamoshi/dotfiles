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
    mdx = "mdx",
    typ = "typst",
  }
})

-- Workaround: https://github.com/neovim/neovim/issues/21856
vim.api.nvim_create_autocmd({ "VimLeave" }, {
  callback = function()
    vim.fn.jobstart('notify-send "hello"', {detach=true})
  end,
})

