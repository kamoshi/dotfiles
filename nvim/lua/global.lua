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
  tab = '~→',
}

-- Trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", { command = [[%s/\s\+$//e]] })

-- Additional filetypes
vim.filetype.add({
  extension = {
    mdx = "mdx",
    typ = "typst",
  }
})

-- Keymap
vim.keymap.set('n', "<leader>e", vim.diagnostic.open_float, {})

