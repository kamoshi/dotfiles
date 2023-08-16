local g = vim.g
local o = vim.o
local opt = vim.opt

-- Debug
-- vim.lsp.set_log_level('debug')

-- Indentation
opt.tabstop = 2
opt.smartindent = true
opt.shiftwidth = 2
opt.expandtab = true

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Helper punctuation
opt.list = true
opt.listchars = {
  trail = '·',
  nbsp = '␣',
  tab = '→→',
}

-- Trailing whitespace
-- vim.fn.matchadd("errorMsg", [[\s\+$]])
vim.api.nvim_create_autocmd("BufWritePre", { command = [[%s/\s\+$//e]] })

vim.filetype.add({
  extension = {
    mdx = "mdx",
    typ = "typst",
    purs = "purescript",
  }
})


-- Keymap
vim.keymap.set('n', "<leader>e", vim.diagnostic.open_float, {})


-- Workaround: https://github.com/neovim/neovim/issues/21856
vim.api.nvim_create_autocmd({ "VimLeave" }, {
  callback = function()
    -- vim.fn.jobstart('notify-send "hello"', {detach=true})
    vim.cmd([[sleep 10m]])
  end,
})

