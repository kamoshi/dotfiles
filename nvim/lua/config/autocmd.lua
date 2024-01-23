local group = vim.api.nvim_create_augroup('UserGroup', {})


-- Remove trailing whitespace on write
vim.api.nvim_create_autocmd('BufWritePre', {
  group    = group,
  pattern  = '*',
  callback = function()
    if vim.bo.filetype == 'markdown' then return end
    vim.cmd [[%s/\s\+$//e]]
  end
})

-- Highlight yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group    = group,
  pattern  = '*',
  callback = function()
    vim.highlight.on_yank { timeout = 250 }
  end
})

-- Restore cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
  group    = group,
  callback = function(args)
    if
      vim.fn.line [['"]] >= 1 and
      vim.fn.line [['"]] < vim.fn.line '$' and
      vim.b[args.buf].filetype ~= 'commit'
    then
      vim.cmd [[normal! g`"]]
    end
  end
})

-- Set indentation for Rust
vim.api.nvim_create_autocmd('FileType', {
  pattern  = 'rust',
  callback = function()
    vim.opt_local.tabstop    = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.listchars:append { leadmultispace  = '│   ' }
  end
})
