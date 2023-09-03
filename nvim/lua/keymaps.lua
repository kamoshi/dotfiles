local map = require("utility").curried_keymap
local n, t = map 'n', map 't'


n "<leader>mn" ":Explore ~/.config/nvim/<cr>" "Meta: open Neovim config"

n "<Leader>ex" ":Explore<CR>" "Netrw: open"
n "<Leader>hl" ":nohl<CR>" "Hide highlights"

n "j" "gj" "Move: down by line"
n "k" "gk" "Move: up by line"

n "<Leader>bn" ":bn<CR>" "Buffer: next"
n "<Leader>bp" ":bp<CR>" "Buffer: previous"
n "<Leader>bd" ":bd<CR>" "Buffer: delete"

t "<Esc><Esc>" [[<C-\><C-n>]] "Exit from terminal mode"

n "<C-h>" "<C-w>h" "Window: move left"
n "<C-j>" "<C-w>j" "Window: move down"
n "<C-k>" "<C-w>k" "Window: move up"
n "<C-l>" "<C-w>l" "Window: move right"

-- Diagnostic
n "<leader>de"  (vim.diagnostic.open_float) "Diagnostic: open float"
n "[d"          (vim.diagnostic.goto_prev)  "Previous diagnostic message"
n "]d"          (vim.diagnostic.goto_next)  "Next diagnostic message"
n "<leader>dl"  (vim.diagnostic.setloclist) "Diagnostic: list messages"

