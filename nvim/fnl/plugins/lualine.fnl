{
  1 "nvim-lualine/lualine.nvim"
  :dependencies [
    "nvim-tree/nvim-web-devicons"
  ]
  :config (fn []
    (local lualine (require "lualine"))
    (lualine.setup)
  )
}

