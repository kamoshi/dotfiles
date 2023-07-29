return function()
  local rt = require "rust-tools"
  local mason = require "mason-registry"
  local capabilities = require "cmp_nvim_lsp"

  local lsp_root = mason.get_package("codelldb"):get_install_path() .. "/extension/"
  local lsp_path = lsp_root .. "adapter/codelldb"
  local lib_path = lsp_root .. "lldb/lib/liblldb.so"

  local opts = {
    server = {
      standalone = true,
      -- capabilities = capabilities,
      on_attach = function(client, bufnr)
        local buf_opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', "<C-b>", rt.hover_actions.hover_actions, buf_opts)
        vim.keymap.set('n', "<Leader>a", rt.code_action_group.code_action_group, buf_opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, buf_opts)
      end,
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        checkOnSave = {
          -- default: `cargo check`
          command = "clippy",
          allFeatures = true,
        }
      }
    },
    dap = {
      adapter = require("rust-tools.dap").get_codelldb_adapter(lsp_path, lib_path),
    },
  }

  rt.setup(opts)
end

