local U = require 'utility'
local n = U.keymap 'n'


---@param buffer number
---@param ht HaskellTools
local function on_attach(_, buffer, ht)
  n '<leader>hc' (vim.lsp.codelens.run)          {'Run codelens', buffer}
  n '<leader>hs' (ht.hoogle.hoogle_signature)    {'Hoogle: search', buffer}
  n '<leader>he' (ht.lsp.buf_eval_all)           {'Haskell: eval all', buffer}

  local function repl_file()
    local name = vim.api.nvim_buf_get_name(0)
    ht.repl.toggle(name)
  end

  n '<leader>rf' (repl_file)       'Repl: Toggle GHCi for the current buffer'
  n '<leader>rr' (ht.repl.toggle)  {'Repl: Toggle GHCi for the current package', buffer}
  n '<leader>rq' (ht.repl.quit)    {'Repl: Quit', buffer}

  -- Detect nvim-dap launch configurations
  -- (requires nvim-dap and haskell-debug-adapter)
  -- ht.dap.discover_configurations(bufnr)
end


return U.as_extendable {
  init = function()
    vim.g.haskell_tools = {
      ---@type HaskellLspClientOpts`
      hls = { on_attach = on_attach }
    }
  end
}
