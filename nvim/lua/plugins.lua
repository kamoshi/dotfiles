return {

  -- Editor theme
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
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
      lualine.setup()
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end,
  },

  -- Discord presence
  {
    "andweeb/presence.nvim",
    config = function()
      local presence = require("presence")
      presence.setup({
        main_image = "file",
        buttons = false,
        show_time = false,
      })
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
          "comment", "gitignore", "diff", "dockerfile", "json", "yaml", "toml", "regex",
          -- shell
          "bash", -- "fish", "nu",
          -- markdown
          "markdown", "markdown_inline",
          -- python
          "python",
          -- rust
          "rust", "toml",
          -- webdev
          "html", "css", "scss", "javascript", "jsdoc", "typescript", "tsx", "astro", "svelte", "vue",
          -- haskell
          "haskell",
          -- nix
          "nix",
          -- literate
          "latex", "bibtex", -- "typst",
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
    end,
  },

  -- LS configs
  {
    "neovim/nvim-lspconfig",
    -- TODO: config here
    -- https://github.com/neovim/nvim-lspconfig#suggested-configuration
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
      local mason = require "mason-lspconfig"
      mason.setup({
        automatic_installation = true,
        ensure_installed = {
          "lua_ls",         -- Lua
          "rust_analyzer",  -- Rust
          -- "hls",         -- use GHCup instead
          "html",           -- HTML
          "cssls",          -- CSS / SCSS
          "tsserver",       -- TypeScript
          "astro",          -- Astro
          "svelte",         -- Svelte
          "pyright",        -- Python
          "typst_lsp",      -- Typst
          "rnix",           -- Nix
        },
      })

      local lsp = require "lspconfig"
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      mason.setup_handlers({
        function(server)
          lsp[server].setup({
            single_file_support = true,
            capabilities = capabilities,
          })
        end,
        ["lua_ls"] = function()
          lsp.lua_ls.setup({
            single_file_support = true,
            capabilities = capabilities,
            settings = {
              Lua = { diagnostics = { globals = { "vim" } } }
            },
          })
        end,
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
  -- Typst
  {
    "kaarmu/typst.vim",
    ft = "typst",
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
  -- Git
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
}

