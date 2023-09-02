local map = require("utility").curried_map
local n, t = map 'n', map 't'


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

n "<Leader>e" ":Explore<CR>" "Netrw: open"
