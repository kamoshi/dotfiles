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
    config = require "configs/lsp",
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
  -- DAP
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      vim.keymap.set('n', "<leader>b", dap.toggle_breakpoint)
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    config = require "configs/debugging",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  -- Mason
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
          "rust_analyzer",  -- Rust
          "hls",            -- Haskell
          "tsserver",       -- TypeScript
          "astro",          -- Astro
          "svelte",         -- Svelte
          "lua_ls",         -- Lua
        },
      })
    end,
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    config = function()
      require("mason-nvim-dap").setup({
        automatic_installation = true,
        ensure_installed = {
          "codelldb",       -- Rust
        },
      })
    end,
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
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
  -- File tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },
  -- Diff view
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  -- Discord presence
  {
    "andweeb/presence.nvim",
    config = function()
      require("presence").setup({
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

