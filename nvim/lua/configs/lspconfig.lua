return function() 
  local configs = require("lspconfig")
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  local on_attach = function(client, buf_number)
    local buf_opts = { noremap = true, silent = true, buffer = buf_number }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, buf_opts)
  end

  configs.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
  configs.astro.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

