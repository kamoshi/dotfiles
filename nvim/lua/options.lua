local U = require("utility")
local autocmd = U.autocmd
local g, opt = vim.g, vim.opt


-- Providers
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0
g.loaded_node_provider = 0

-- General
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.swapfile = false          -- Don't use swapfiles
opt.completeopt = "menuone,noinsert,noselect" -- Completion behavior
opt.termguicolors = true

-- Indentation
opt.tabstop = 2               -- 1 tab = 2 spaces
opt.smartindent = true        -- Autoindent new lines
opt.shiftwidth = 2            -- Shift 2 spaces when tab
opt.expandtab = true          -- Use spaces instead of tabs

-- Visual
opt.number = true             -- Show current line number
opt.relativenumber = true     -- Show relative line numbers
opt.colorcolumn = "80"        -- Show soft char limit
opt.list = true               -- Show punctuation
opt.listchars = {             -- Punctuation marks
  trail = '·',
  nbsp = '␣',
  tab = '→→',
}

-- Trailing whitespace
autocmd "BufWritePre" {} (function()
  if vim.bo.filetype == "markdown" then return end
  vim.cmd([[%s/\s\+$//e]])
end)

-- Additional filetypes
vim.filetype.add {
  extension = {
    mdx   = "mdx",
    typ   = "typst",
    purs  = "purescript",
  }
}

