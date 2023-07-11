return {
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      local configs = require("nvim-treesitter.configs");
      configs.setup({
        ensure_installed = {
          -- nvim
          "vim", "vimdoc", "lua",
          -- shell
          "bash", "fish", -- "nu",
          -- rust
          "rust", "toml",
          -- python
          "python",
          -- webdev
          "html", "css", "scss", "javascript", "jsdoc", "typescript", "tsx", "astro", "svelte", "vue",
          -- markdown
          "markdown", "markdown_inline",
          -- nix
          "nix",
          -- haskell
          "haskell",
          -- latex
          "latex", "bibtex",
          -- misc
          "gitignore", "diff", "dockerfile", "json", "yaml", "regex",
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
    build = ":TSUpdate",
    init = function()
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },
  -- LSP Configs
  {
    "neovim/nvim-lspconfig",
    config = require "configs/lspconfig",
  },
  -- Snippet engine
  {
    "saadparwaiz1/cmp_luasnip",
    dependencies = {
      "L3MON4D3/LuaSnip",
    }
  },
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    config = require "configs/cmp",
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  {
    "hrsh7th/cmp-nvim-lsp",
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
    config = function()
      local configs = require("presence").setup({
        main_image = "file",
        buttons = false,
        show_time = false,
      })
    end,
  },
  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local config = require("lualine")
      config.setup({})
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  -- Editor theme
  {
    "rebelot/kanagawa.nvim",
    init = function()
      vim.cmd("colorscheme kanagawa")
    end,
  }
}

