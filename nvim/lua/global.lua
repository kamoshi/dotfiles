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

-- LSP hotkeys
local cmds_lsp = vim.api.nvim_create_augroup("cmds_lsp", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = cmds_lsp,
  desc = "LSP actions",
  callback = function()
    local buf_opts = { noremap = true, silent = true, buffer = true }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, buf_opts)
    vim.keymap.set('n', "<space>rn", vim.lsp.buf.rename, buf_opts)
  end
})

-- Workaround: https://github.com/neovim/neovim/issues/21856
vim.api.nvim_create_autocmd({ "VimLeave" }, {
  callback = function()
    vim.fn.jobstart('notify-send "hello"', {detach=true})
  end,
})

