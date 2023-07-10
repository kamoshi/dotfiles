return function() 
  local configs = require("lspconfig")
  local on_attach = function(client, buf_number)
    local buf_opts = { noremap = true, silent = true, buffer = buf_number }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, buf_opts)
  end

  configs.tsserver.setup({
    on_attach = on_attach
  })
  configs.astro.setup({
    on_attach = on_attach
  })
end

