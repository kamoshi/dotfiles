local U = require "utility"
local n = U.keymap "n"


---@type LazySpec
return {

  -- Theme
  {
    "rebelot/kanagawa.nvim",
    lazy     = false,
    priority = math.huge,
    config = function()
      vim.cmd "colorscheme kanagawa"
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local lualine = require "lualine"
      lualine.setup {}
    end
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function()
      local telescope = require "telescope"
      local builtin   = require "telescope.builtin"
      local ext       = telescope.extensions

      telescope.load_extension "fzf"
      telescope.load_extension "notify"
      telescope.setup {
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      }

      n "<leader>ff" (builtin.find_files) "Telescope: find files"
      n "<leader>fb" (builtin.buffers)    "Telescope: find buffers"
      n "<leader>fg" (builtin.live_grep)  "Telescope: grep content"
      n "<leader>fh" (builtin.help_tags)  "Telescope: search docs"
      n "<leader>fn" (ext.notify.notify)  "Telescope: find notifications"
    end,
  },

  -- Shortcut hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },

  -- Notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require "notify"
    end
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
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      local config = require "bufferline"
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
      local gitsigns = require "gitsigns"
      gitsigns.setup()
    end,
  },

  {
    "andweeb/presence.nvim",
    config = function()
      local presence = require "presence"

      presence.setup {
        main_image  = "file",
        show_time   = false,
        buttons     = false,
      }
    end
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require "nvim-treesitter.configs"

      config.setup {
        modules          = {},
        auto_install     = false,
        sync_install     = false,
        ignore_install   = {},
        ensure_installed = {
          -- neovim
          "vimdoc", "lua", "query",
          -- data
          "json", "xml", "yaml", "toml", "dhall",
          -- markdown
          "markdown", "markdown_inline",
          -- latex
          "latex", "bibtex",
          -- git
          "gitcommit", "gitignore", "diff",
          -- misc
          "comment", "dockerfile", "regex",
          -- shell
          "bash",
          -- julia
          "julia",
          -- python
          "python",
          -- rust
          "rust",
          -- webdev
          "html", "css", "scss", "javascript", "jsdoc", "typescript", "tsx", "astro", "svelte",
          -- haskell
          "haskell", "purescript", "nix",
        },
        highlight = { enable = true },
        indent    = { enable = true },
      }
    end,
    init = function()
      local lang = vim.treesitter.language

      lang.register("markdown", "mdx")
    end,
  },

  -- LS configs
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lsp = require "lspconfig"

      lsp.nushell.setup {}
    end
  },

  -- Snippet engine
  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
  },

  -- Completion
  require "plugins.nvim-cmp" {
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
      local dap = require "dap"

      n "<leader>b" (dap.toggle_breakpoint) "DAP: Toggle breakpoint"
    end,
  },

  -- Debugger UI
  require "plugins.nvim-dap-ui" {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },

  -- Mason
  {
    "williamboman/mason.nvim",
    config = function()
      local mason = require "mason"
      mason.setup()
    end,
  },

  -- Automatic LSP server setup for Mason
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local config  = require "mason-lspconfig"
      local lsp     = require "lspconfig"
      local cmp     = require "cmp_nvim_lsp"

      config.setup {
        automatic_installation = true,
        -- NOTE
        -- Haskell: Use GHCup installation instead of hls
        ensure_installed = {
          "lua_ls",         -- Lua
          "bashls",         -- Bash
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
          "julials",        -- Julia
        },
      }

      config.setup_handlers {
        function(server)
          lsp[server].setup {
            single_file_support = true,
            capabilities = cmp.default_capabilities(),
          }
        end,
      }
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
      local config = require "mason-nvim-dap"

      config.setup {
        automatic_installation = true,
        ensure_installed = {
          "codelldb",
        },
      }
    end,
  },

  -- Tools for Neovim
  {
    "folke/neodev.nvim",
    ft = "lua",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    config = function()
      local neodev  = require "neodev"
      local lsp     = require "lspconfig"

      neodev.setup()
      lsp.lua_ls.setup {
        settings = {
          Lua = { completion = { callSnippet = "Replace" } }
        }
      }
    end
  },

  -- Tools for Rust
  require "plugins.rust-tools" {
    "simrat39/rust-tools.nvim",
    ft = "rust",
  },

  -- Tools for Haskell
  require "plugins.haskell-tools" {
    "mrcjkb/haskell-tools.nvim",
    version = "^3",
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

}
