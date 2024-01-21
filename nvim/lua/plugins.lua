local util = require 'config.utils'
local n = util.keymap 'n'


---@type LazySpec
return {

  -- Theme
  {
    'rebelot/kanagawa.nvim',
    enabled  = not vim.g.vscode,
    lazy     = false,
    priority = math.huge,
    config = function()
      vim.cmd 'colorscheme kanagawa'
    end,
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    enabled = not vim.g.vscode,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local lualine = require 'lualine'
      lualine.setup {}
    end
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    enabled = not vim.g.vscode,
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      local telescope = require 'telescope'
      local builtin   = require 'telescope.builtin'
      local ext       = telescope.extensions

      telescope.load_extension 'fzf'
      telescope.load_extension 'notify'
      telescope.setup {
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          }
        }
      }

      n '<leader>ff' (builtin.find_files) 'Telescope: find files'
      n '<leader>fb' (builtin.buffers)    'Telescope: find buffers'
      n '<leader>fg' (builtin.live_grep)  'Telescope: grep content'
      n '<leader>fh' (builtin.help_tags)  'Telescope: search docs'
      n '<leader>fn' (ext.notify.notify)  'Telescope: find notifications'
    end,
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local configs = require 'nvim-treesitter.configs'

      configs.setup {
        modules          = {},
        auto_install     = false,
        sync_install     = false,
        ignore_install   = {},
        ensure_installed = {
          -- neovim
          'vimdoc', 'lua', 'query',
          -- data
          'json', 'xml', 'yaml', 'toml', 'dhall',
          -- markdown
          'markdown', 'markdown_inline',
          -- latex
          'latex', 'bibtex',
          -- git
          'gitcommit', 'gitignore', 'diff',
          -- misc
          'comment', 'dockerfile', 'regex',
          -- shell
          'bash',
          -- julia
          'julia',
          -- python
          'python',
          -- rust
          'rust',
          -- webdev
          'html', 'css', 'scss', 'javascript', 'jsdoc', 'typescript', 'tsx', 'astro', 'svelte',
          -- haskell
          'haskell', 'purescript', 'nix',
        },
        highlight = { enable = true },
        indent    = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection    = '<CR>',
            scope_incremental = '<CR>',
            node_incremental  = '<TAB>',
            node_decremental  = '<S-TAB>',
          },
        },
      }
    end,
    init = function()
      local lang = vim.treesitter.language

      lang.register('markdown', 'mdx')
      lang.register('markdown', 'lhaskell')
    end,
  },

  -- Git signs
  {
    'lewis6991/gitsigns.nvim',
    enabled = not vim.g.vscode,
    config = function()
      local gitsigns = require 'gitsigns'
      gitsigns.setup()
    end,
  },

  -- Comments
  {
    'numToStr/Comment.nvim',
    config = true,
  },

  -- Shortcut hints
  {
    'folke/which-key.nvim',
    enabled = not vim.g.vscode,
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },

  -- Notifications
  {
    'rcarriga/nvim-notify',
    enabled = not vim.g.vscode,
    config = function()
      vim.notify = require 'notify'
    end
  },

  -- File tree
  {
    'nvim-neo-tree/neo-tree.nvim',
    enabled = not vim.g.vscode,
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
  },

  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    enabled = not vim.g.vscode,
    version = '*',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      local config = require 'bufferline'
      config.setup()
    end
  },

  -- Git diffviewer
  {
    'sindrets/diffview.nvim',
    enabled = not vim.g.vscode,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  },

  -- LS configs
  {
    'neovim/nvim-lspconfig',
    enabled = not vim.g.vscode,
    opts = {
      inlay_hints = { enabled = true },
    },
    config = function()
      local lsp = require 'lspconfig'

      lsp.nushell.setup {}
    end,
  },

  -- Snippet engine
  {
    'L3MON4D3/LuaSnip',
    version = '2.*',
  },

  -- Completion
  require 'plugins.nvim-cmp' {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
    },
  },

  -- Debugger adapter support
  {
    'mfussenegger/nvim-dap',
    enabled = not vim.g.vscode,
    config = function()
      local dap = require 'dap'

      n '<leader>b' (dap.toggle_breakpoint) 'DAP: Toggle breakpoint'
    end,
  },

  -- Debugger UI
  require 'plugins.nvim-dap-ui' {
    'rcarriga/nvim-dap-ui',
    enabled = not vim.g.vscode,
    dependencies = {
      'mfussenegger/nvim-dap',
    },
  },

  -- Mason
  {
    'williamboman/mason.nvim',
    enabled = not vim.g.vscode,
    config = function()
      local mason = require 'mason'
      mason.setup()
    end,
  },

  -- Automatic LSP server setup for Mason
  {
    'williamboman/mason-lspconfig.nvim',
    enabled = not vim.g.vscode,
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      local config = require 'mason-lspconfig'
      local lsp    = require 'lspconfig'
      local cmp    = require 'cmp_nvim_lsp'

      local noop   = function() end

      config.setup {
        automatic_installation = true,
        -- NOTE
        -- Haskell: Managed by GHCup
        ensure_installed = {
          'lua_ls',         -- Lua
          'rust_analyzer',  -- Rust
          'bashls',         -- Bash
          'html',           -- HTML
          'cssls',          -- CSS / SCSS
          'tsserver',       -- TypeScript
          'astro',          -- Astro
          'svelte',         -- Svelte
          'pyright',        -- Python
          'rnix',           -- Nix
          'purescriptls',   -- Purescript
          'ltex',           -- Literate - LaTeX, Markdown, etc.
          'julials',        -- Julia
        },
      }

      config.setup_handlers {
        function(name)
          lsp[name].setup {
            single_file_support = true,
            capabilities = cmp.default_capabilities(),
          }
        end,
        ['rust_analyzer'] = noop,
      }
    end,
  },

  -- Automatic debugger install
  {
    'jay-babu/mason-nvim-dap.nvim',
    enabled = not vim.g.vscode,
    dependencies = {
      'mfussenegger/nvim-dap',
      'williamboman/mason.nvim',
    },
    config = function()
      local config = require 'mason-nvim-dap'

      config.setup {
        automatic_installation = true,
        ensure_installed = {
          'codelldb',
        },
      }
    end,
  },

  -- Tools for Neovim
  {
    'folke/neodev.nvim',
    enabled = not vim.g.vscode,
    ft = 'lua',
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    config = function()
      local neodev  = require 'neodev'
      local lsp     = require 'lspconfig'

      neodev.setup()
      lsp.lua_ls.setup {
        settings = {
          Lua = { completion = { callSnippet = 'Replace' } }
        }
      }
    end
  },

  -- Tools for Rust
  {
    'mrcjkb/rustaceanvim',
    enabled = not vim.g.vscode,
    version = '^3',
    ft = { 'rust' },
    init = function()
      require 'plugins.rust-tools'
    end
  },

  -- Tools for Haskell
  require 'plugins.haskell-tools' {
    'mrcjkb/haskell-tools.nvim',
    enabled = not vim.g.vscode,
    version = '^3',
    ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },

}
