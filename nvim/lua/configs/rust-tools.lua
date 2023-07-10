return function()
  local rt = require "rust-tools"
  rt.setup({
    server = {
      on_attach = function(client, bufnr)
        vim.keymap.set('n', "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
        vim.keymap.set('n', "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })

        local buf_opts = { noremap = true, silent = true, buffer = buf_number }
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
    }
  })
end

