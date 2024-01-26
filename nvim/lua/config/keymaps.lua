local indent = require 'config.keymaps.indent'
local map = require 'config.helpers.keymap'
local n   = map 'n'
local v   = map 'v'
local t   = map 't'
local nv  = map {'n', 'v'}



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


-- Indentation
v '>'           '>gv'                       'Indent right'
v '<'           '<gv'                       'Indent left'
v '|'           (indent.normalize)          'Indent normalize'


-- Diagnostics
n '<leader>e'   (vim.diagnostic.open_float)     'Open error diagnostics'
n '[d'          (vim.diagnostic.goto_prev)      'Previous diagnostic message'
n ']d'          (vim.diagnostic.goto_next)      'Next diagnostic message'
n '<leader>dl'  (vim.diagnostic.setloclist)     'Diagnostic: list messages'


-- Meta
local function open_config()
  vim.fn.chdir '~/.config/nvim'
  vim.cmd 'Explore'
end

n '<leader>mn' (open_config) 'Meta: neovim config'


-- LSP
do
  local group = vim.api.nvim_create_augroup('UserLspConfig', {})

  local function setup_lsp_keymaps(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local function format()
      vim.lsp.buf.format({ async = true })
    end

    local function workspaces_list()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end

    local buffer = ev.buf
    n  'K'          (vim.lsp.buf.hover)                     {'LSP: show hover help', buffer}
    n  '<C-k>'      (vim.lsp.buf.signature_help)            {'LSP: signature help', buffer}
    n  '<Leader>ld' (vim.lsp.buf.definition)                {'LSP: definition', buffer}
    n  '<Leader>lD' (vim.lsp.buf.declaration)               {'LSP: declaration', buffer}
    n  '<Leader>li' (vim.lsp.buf.implementation)            {'LSP: implementation', buffer}
    n  '<Leader>lR' (vim.lsp.buf.references)                {'LSP: references', buffer}
    n  '<Leader>lt' (vim.lsp.buf.type_definition)           {'LSP: type definition', buffer}
    n  '<leader>lr' (vim.lsp.buf.rename)                    {'LSP: rename identifier', buffer}
    nv '<leader>la' (vim.lsp.buf.code_action)               {'LSP: code actions', buffer}
    n  '<leader>lf' (format)                                {'LSP: format file', buffer}
    n  '<leader>wa' (vim.lsp.buf.add_workspace_folder)      {'LSP: add workspace folder', buffer}
    n  '<leader>wr' (vim.lsp.buf.remove_workspace_folder)   {'LSP: remove workspace folder', buffer}
    n  '<leader>wl' (workspaces_list)                       {'LSP: list workspace folders', buffer}
  end

  vim.api.nvim_create_autocmd('LspAttach', {
    group    = group,
    callback = setup_lsp_keymaps
  })
end
