return function()
  local configs = require("lspconfig")
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  local on_attach = function(client, buf_number)
    local buf_opts = { noremap = true, silent = true, buffer = buf_number }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, buf_opts)
  end

  configs.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = {
          globals = {
            "vim"
          }
        }
      }
    },
  })

  local opts = { on_attach = on_attach, capabilities = capabilities }

  configs.tsserver.setup(opts)
  configs.astro.setup(opts)
  configs.svelte.setup(opts)
end

