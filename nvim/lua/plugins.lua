return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = require "configs/treesitter",
    build = ":TSUpdate",
    init = function()
      vim.treesitter.language.register("markdown", "mdx")
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = require "configs/lspconfig",
  },
  {
    "simrat39/rust-tools.nvim",
    config = require "configs/rust-tools",
  },
  {
    "mrcjkb/haskell-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    branch = "1.x.x",
  },
  {
    "andweeb/presence.nvim",
    config = require "configs/presence",
  },
  {
    "nvim-lualine/lualine.nvim",
    config = require "configs/lualine",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "rebelot/kanagawa.nvim",
    init = function()
      vim.cmd("colorscheme kanagawa")
    end
  }
}

