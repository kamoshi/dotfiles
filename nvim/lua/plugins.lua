return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "neovim/nvim-lspconfig",
    config = require "configs/lspconfig",
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

