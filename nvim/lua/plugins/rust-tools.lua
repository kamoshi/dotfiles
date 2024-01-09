local util = require 'utility'
local n    = util.keymap 'n'


vim.g.rustaceanvim = function()
  local mason  = require 'mason-registry'
  local tools  = require 'rustaceanvim'
  local config = require 'rustaceanvim.config'

  local lsp_root = mason.get_package('codelldb'):get_install_path() .. '/extension/'
  local lsp_path = lsp_root .. 'adapter/codelldb'
  local lib_path = lsp_root .. 'lldb/lib/liblldb.so'

  ---@type RustaceanOpts
  return {
    server = {
      on_attach = function(_, bufnr)
        n '<C-b>'      (tools.hover_actions.hover_actions)         {buffer=bufnr}
        n '<Leader>a'  (tools.code_action_group.code_action_group) {buffer=bufnr}
      end,
    },
    dap = {
      adapter = config.get_codelldb_adapter(lsp_path, lib_path),
    },
  }
end
