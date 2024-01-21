local utils = require 'config.utils'
local map, augroup, autocmd = utils.keymap, utils.augroup, utils.autocmd
local n, t, nv = map 'n', map 't', map {'n', 'v'}


n '<leader>mn'  ':Explore ~/.config/nvim/<cr>' 'Meta: open Neovim config'

n '<Leader>ex'  ':Explore<CR>'              'Netrw: open'
n '<Leader>hl'  ':nohl<CR>'                 'Hide highlights'

n 'j'           'gj'                        'Move: down by line'
n 'k'           'gk'                        'Move: up by line'

n '<Leader>bn'  ':bn<CR>'                   'Buffer: next'
n '<Leader>bp'  ':bp<CR>'                   'Buffer: previous'
n '<Leader>bd'  ':bd<CR>'                   'Buffer: delete'

t '<Esc><Esc>'  [[<C-\><C-n>]]              'Exit from terminal mode'

n '<C-h>'       '<C-w>h'                    'Window: move left'
n '<C-j>'       '<C-w>j'                    'Window: move down'
n '<C-k>'       '<C-w>k'                    'Window: move up'
n '<C-l>'       '<C-w>l'                    'Window: move right'

-- Diagnostics
n '<leader>e'   (vim.diagnostic.open_float) 'Open error diagnostics'
n '[d'          (vim.diagnostic.goto_prev)  'Previous diagnostic message'
n ']d'          (vim.diagnostic.goto_next)  'Next diagnostic message'
n '<leader>dl'  (vim.diagnostic.setloclist) 'Diagnostic: list messages'

-- LSP
autocmd 'LspAttach' {'LSP actions', group=augroup 'UserLspConfig'} (function(ev)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

  local function workspaces_list()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end

  local function format()
    vim.lsp.buf.format({async = true})
  end

  local buffer = ev.buf
  n  'K'          (vim.lsp.buf.hover)                     {'Show hover help', buffer}
  n  'gD'         (vim.lsp.buf.declaration)               {'Go to declaration', buffer}
  n  'gd'         (vim.lsp.buf.definition)                {'Go to definition', buffer}
  n  'gi'         (vim.lsp.buf.implementation)            {'Go to implementation', buffer}
  n  'gr'         (vim.lsp.buf.references)                {'Show references', buffer}
  n  '<leader>D'  (vim.lsp.buf.type_definition)           {'Go to type definition', buffer}
  n  '<C-k>'      (vim.lsp.buf.signature_help)            {'Signature help', buffer}
  n  '<leader>wa' (vim.lsp.buf.add_workspace_folder)      {'Add workspace folder', buffer}
  n  '<leader>wr' (vim.lsp.buf.remove_workspace_folder)   {'Remove workspace folder', buffer}
  n  '<leader>wl' (workspaces_list)                       {'List workspace folders', buffer}
  n  '<leader>lr' (vim.lsp.buf.rename)                    {'Rename identifier', buffer}
  nv '<leader>la' (vim.lsp.buf.code_action)               {'Show code actions', buffer}
  n  '<leader>lf' (format)                                {'Format file', buffer}
end)

