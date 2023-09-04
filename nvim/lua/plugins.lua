local U = require("utility")

return {

  -- Editor theme
  {
    "rebelot/kanagawa.nvim",
    lazy     = false,
    priority = 1000,
    config   = function()
      vim.cmd("colorscheme kanagawa")
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local lualine = require("lualine")
      lualine.setup({})
    end
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {"nvim-telescope/telescope-fzf-native.nvim", build = "make"}
    },
    config = function()
      local telescope = require "telescope"
      local builtin = require "telescope.builtin"
      telescope.setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      })
      telescope.load_extension("fzf")
      local nmap = U.keymap 'n'
      nmap "<leader>ff" (builtin.find_files)  "Telescope: find files"
      nmap "<leader>fb" (builtin.buffers)     "Telescope: find buffers"
      nmap "<leader>fg" (builtin.live_grep)   "Telescope: grep content"
      nmap "<leader>fh" (builtin.help_tags)   "Telescope: search docs"
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },

  -- File tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },

  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      local config = require("bufferline")
      config.setup()
    end
  },

  -- Git diffviewer
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gitsigns = require("gitsigns")
      gitsigns.setup({})
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs");
      configs.setup({
        sync_install = false,
        ensure_installed = {
          -- nvim
          "vim", "vimdoc", "lua",
          -- misc
          "comment", "dockerfile", "json", "yaml", "toml", "regex",
          -- git
          "gitcommit", "gitignore", "diff",
          -- shell
          "bash",
          -- markdown
          "markdown", "markdown_inline",
          -- python
          "python",
          -- rust
          "rust",
          -- webdev
          "html", "css", "scss", "javascript", "jsdoc", "typescript", "tsx", "astro", "svelte",
          -- haskell
          "haskell",
          -- nix
          "nix",
          -- literate
          "latex", "bibtex",
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
    init = function()
      vim.treesitter.language.register("markdown", "mdx")
      vim.treesitter.language.register("haskell", "purescript")
    end,
  },

  -- LS configs
  U.plugin("plugins.lspconfig") {
    "neovim/nvim-lspconfig",
  },

  -- Snippet engine
  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
  },

  -- Completion
  U.plugin("plugins.cmp") {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
    },
  },

  -- Debugger adapter support
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      vim.keymap.set('n', "<leader>b", dap.toggle_breakpoint)
    end,
  },

  -- Debugger UI
  U.plugin("plugins.dap-ui") {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },

  -- Mason
  {
    "williamboman/mason.nvim",
    config = function()
      local mason = require("mason")
      mason.setup()
    end,
  },

  -- Automatic language server install
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local config = require("mason-lspconfig")
      config.setup({
        automatic_installation = true,
        -- NOTE
        -- Haskell: Use GHCup installation instead of hls
        ensure_installed = {
          "lua_ls",         -- Lua
          "rust_analyzer",  -- Rust
          "html",           -- HTML
          "cssls",          -- CSS / SCSS
          "tsserver",       -- TypeScript
          "astro",          -- Astro
          "svelte",         -- Svelte
          "pyright",        -- Python
          "rnix",           -- Nix
          "purescriptls",   -- Purescript
          "ltex",           -- Literate - LaTeX, Markdown, etc.
        },
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      config.setup_handlers({
        function(server)
          lspconfig[server].setup({
            single_file_support = true,
            capabilities = capabilities,
          })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            single_file_support = true,
            capabilities = capabilities,
            settings = { Lua = { diagnostics = { globals = { "vim" } } } },
          })
        end,
      })
    end,
  },

  -- Automatic debugger install
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
    config = function()
      local config = require("mason-nvim-dap")
      config.setup({
        automatic_installation = true,
        ensure_installed = {
          "codelldb",       -- Rust
        },
      })
    end,
  },

  -- Tools for Rust
  U.plugin("plugins.rust-tools") {
    "simrat39/rust-tools.nvim",
    ft = "rust",
  },

  -- Tools for Haskell
  U.plugin("plugins.haskell-tools") {
    "mrcjkb/haskell-tools.nvim",
    branch = "2.x.x",
    ft = {"haskell", "lhaskell", "cabal", "cabalproject"},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

}

