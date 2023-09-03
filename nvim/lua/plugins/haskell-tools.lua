local nmap = require("utility").curried_keymap('n')
local M = {}


function M.init()
  vim.g.haskell_tools = {
    hls = {
      on_attach = function(_, buffer, ht)
        nmap "<leader>hs" (ht.hoogle.hoogle_signature)  {"Hoogle: search", buffer}
        nmap "<leader>ha" (ht.lsp.buf_eval_all)         {"Haskell: eval all", buffer}
      end
    }
  }
end

function M.config()
  local ht = require "haskell-tools"
  local buffer = vim.api.nvim_get_current_buf()

  local function repl_file()
    local name = vim.api.nvim_buf_get_name(0)
    ht.repl.toggle(name)
  end

  nmap "<leader>rr" (ht.repl.toggle)  {"Repl: Toggle GHCi for the current package", buffer}
  nmap "<leader>rf" (repl_file)       "Repl: Toggle GHCi for the current buffer"
  nmap "<leader>rq" (ht.repl.quit)    {"Repl: Quit", buffer}

  -- Detect nvim-dap launch configurations
  -- (requires nvim-dap and haskell-debug-adapter)
  -- ht.dap.discover_configurations(bufnr)
end


return M
