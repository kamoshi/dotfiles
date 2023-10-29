local nmap = require("utility").keymap('n')
local M = {}


function M.config()
  local tools = require "rust-tools"
  local mason = require "mason-registry"
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  local lsp_root = mason.get_package("codelldb"):get_install_path() .. "/extension/"
  local lsp_path = lsp_root .. "adapter/codelldb"
  local lib_path = lsp_root .. "lldb/lib/liblldb.so"

  local opts = {
    server = {
      standalone = true,
      capabilities = capabilities,
      on_attach = function(_, bufnr)
        nmap "<C-b>"      (tools.hover_actions.hover_actions)         {buffer=bufnr}
        nmap "<Leader>a"  (tools.code_action_group.code_action_group) {buffer=bufnr}
      end,
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        checkOnSave = {
          -- default = "cargo check",
          command = "clippy",
          allFeatures = true,
        }
      }
    },
    dap = {
      adapter = require("rust-tools.dap").get_codelldb_adapter(lsp_path, lib_path),
    },
  }

  tools.setup(opts)
end


---@param config table
---@return table
return function(config)
  return vim.tbl_extend("keep", config, M)
end
