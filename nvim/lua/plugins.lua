return {
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    config = require "configs/treesitter",
    build = ":TSUpdate",
    init = function()
      vim.treesitter.language.register("markdown", "mdx")
    end
  },
  -- LSP Configs
  {
    "neovim/nvim-lspconfig",
    config = require "configs/lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp"
    },
  },
  -- Snippet engine
  {
    "L3MON4D3/LuaSnip",
  },
  {
    "saadparwaiz1/cmp_luasnip",
  },
  -- Completion
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "hrsh7th/cmp-buffer",
  },
  {
    "hrsh7th/cmp-path",
  },
  {
    "hrsh7th/cmp-cmdline",
  },
  {
    "hrsh7th/nvim-cmp",
    config = require "configs/cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  -- Rust tools
  {
    "simrat39/rust-tools.nvim",
    config = require "configs/rust-tools",
  },
  -- Haskell tools
  {
    "mrcjkb/haskell-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    branch = "1.x.x",
  },
  -- Discord presence
  {
    "andweeb/presence.nvim",
    config = require "configs/presence",
  },
  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    config = require "configs/lualine",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  -- Editor theme
  {
    "rebelot/kanagawa.nvim",
    init = function()
      vim.cmd("colorscheme kanagawa")
    end
  }
}

