local is, when = require 'config.compose' ()
local map = require 'config.helpers.keymap'
local n   = map 'n'
local nv  = map { 'n', 'v' }


---@type LazySpec
return {

  -- Theme
  {
    'rebelot/kanagawa.nvim',
    enabled  = is 'standalone',
    lazy     = false,
    priority = math.huge,
    config = function()
      vim.cmd 'colorscheme kanagawa'
    end,
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    enabled = is 'standalone',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local lualine = require 'lualine'

      lualine.setup {
        tabline = {
          lualine_a = { 'buffers' },
        }
      }
    end
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    enabled = is 'standalone',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      when 'linux' { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      local telescope = require 'telescope'
      local builtin   = require 'telescope.builtin'
      local ext       = telescope.extensions

      if is 'linux'      then telescope.load_extension 'fzf' end
      if is 'standalone' then telescope.load_extension 'notify' end

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

      n '<leader>ff' (builtin.find_files) 'Telescope: files'
      n '<leader>fb' (builtin.buffers)    'Telescope: buffers'
      n '<leader>fg' (builtin.live_grep)  'Telescope: grep'
      n '<leader>fh' (builtin.help_tags)  'Telescope: docs'
      n '<Leader>fk' (builtin.keymaps)    'Telescope: keymaps'

      if is 'standalone' then
        n '<leader>fn' (ext.notify.notify)  'Telescope: notifications'
      end
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
          'vimdoc', 'lua', 'query', 'luadoc',
          -- data
          'json', 'xml', 'yaml', 'toml',
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
          -- python
          'python',
          -- rust
          'rust',
          -- webdev
          'html', 'css', 'scss', 'javascript', 'jsdoc', 'typescript', 'tsx', 'astro', 'svelte',
          -- haskell
          'haskell',
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

  -- Git - file hunks
  {
    'lewis6991/gitsigns.nvim',
    enabled = is 'standalone',
    config = function()
      local gs = require 'gitsigns'

      gs.setup {
        on_attach = function()
          n '<Leader>hp' (gs.preview_hunk)    'Hunk: preview'
          n '<Leader>hs' (gs.stage_hunk)      'Hunk: stage'
          n '<Leader>hu' (gs.undo_stage_hunk) 'Hunk: unstage'
          n '<Leader>hr' (gs.reset_hunk)      'Hunk: reset'
          n '<leader>hS' (gs.stage_buffer)    'Hunk: buffer stage'
          n '<leader>hR' (gs.reset_buffer)    'Hunk: buffer reset'
          n '<leader>hd' (gs.toggle_deleted)  'Hunk: show deleted'
        end
      }
    end,
  },

  -- Git - project diff
  {
    'sindrets/diffview.nvim',
    enabled = is 'standalone',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local lib = require 'diffview.lib'

      local function toggle(name)
        return function()
          if not next(lib.views) then
            vim.cmd(name)
          else
            vim.cmd 'DiffviewClose'
          end
        end
      end

      n '<Leader>gd' (toggle 'DiffviewOpen')        'Git: Diff'
      n '<Leader>gh' (toggle 'DiffviewFileHistory') 'Git: History'
    end
  },

  -- Git: ops
  {
    'NeogitOrg/neogit',
    enabled = is 'standalone',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim'
    },
    config = function()
      local neogit = require 'neogit'

      neogit.setup {
        graph_style = 'unicode',
        integrations = {
          telescope = true,
          diffview  = true,
        }
      }

      n '<Leader>gn' (neogit.open) 'Git: Neogit'
    end
  },

  -- Comments
  {
    'numToStr/Comment.nvim',
    config = true,
  },

  -- Shortcut hints
  {
    'folke/which-key.nvim',
    enabled = is 'standalone',
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
    enabled = is 'standalone',
    config = function()
      vim.notify = require 'notify'
    end
  },

  -- File tree
  {
    'nvim-neo-tree/neo-tree.nvim',
    enabled = is 'standalone',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
  },

  -- Snippet engine
  {
    'L3MON4D3/LuaSnip',
    version = '2.*',
  },

  -- Completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
    },
    config = require 'config.plugins.nvim-cmp'
  },

  -- LS configs
  {
    'neovim/nvim-lspconfig',
    enabled = is { 'standalone', 'linux' },
  },

  -- Debugger adapter support
  {
    'mfussenegger/nvim-dap',
    enabled = is { 'standalone', 'linux' },
    dependencies = {
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      local dap = require 'dap'
      local ui  = require 'dapui'

      n '<F5>'       (dap.continue)           'Debugger: continue'
      n '<F10>'      (dap.step_over)          'Debugger: step over'
      n '<F11>'      (dap.step_into)          'Debugger: step into'
      n '<F12>'      (dap.step_out)           'Debugger: step out'
      n '<leader>db' (dap.toggle_breakpoint)  'Debugger: toggle breakpoint'

      n  '<leader>du' (ui.toggle)             'Debugger: toggle UI'
      nv '<leader>de' (ui.eval)               'Debugger: eval'

      -- vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
      -- vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
      -- vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })
      --
      -- vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
      -- vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
      -- vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
      -- vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
      -- vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })

      ui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = ui.open
      dap.listeners.after.event_terminated["dapui_config"]  = ui.close
      dap.listeners.before.event_exited["dapui_config"]     = ui.close
    end,
  },

  -- Mason
  {
    'williamboman/mason.nvim',
    enabled = is { 'standalone', 'linux' },
    config = true,
  },

  -- Automatic LSP server setup for Mason
  {
    'williamboman/mason-lspconfig.nvim',
    enabled = is { 'standalone', 'linux' },
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
    enabled = is { 'standalone', 'linux' },
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
          --'js-debug-adapter',
        },
      }
    end,
  },

  -- Tools for Neovim
  {
    'folke/neodev.nvim',
    enabled = is { 'standalone', 'linux' },
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
    enabled = is { 'standalone', 'linux' },
    version = '^3',
    ft = { 'rust' },
    init = function()
      require 'config.plugins.rustaceanvim'
    end
  },

  -- Tools for Haskell
  {
    'mrcjkb/haskell-tools.nvim',
    enabled = is { 'standalone', 'linux' },
    version = '^3',
    ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    init = require 'config.plugins.haskell-tools'
  },

  -- JS debugger
  {
    'mxsdev/nvim-dap-vscode-js',
    dependencies = {
      'microsoft/vscode-js-debug',
      version = '1.x',
      build = 'npm i && npm run compile vsDebugServerBundle && mv dist out',
    },
    config = function()
      local dap = require 'dap'
      --local utils = require 'dap.utils'
      local dap_js = require 'dap-vscode-js'
      --local mason = require 'mason-registry'

      ---@diagnostic disable-next-line: missing-fields
      dap_js.setup {
        -- debugger_path = mason.get_package('js-debug-adapter'):get_install_path(),
        debugger_path = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug',
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      }

      local langs = { 'javascript', 'typescript', 'svelte', 'astro' }
      for _, lang in ipairs(langs) do
        dap.configurations[lang] = {
          {
            type    = 'pwa-node',
            request = 'attach',
            name    = 'Attach debugger to existing `node --inspect` process',
            cwd     = '${workspaceFolder}',
            skipFiles = {
              '${workspaceFolder}/node_modules/**/*.js',
              '${workspaceFolder}/packages/**/node_modules/**/*.js',
              '${workspaceFolder}/packages/**/**/node_modules/**/*.js',
              '<node_internals>/**',
              'node_modules/**',
            },
            sourceMaps = true,
            resolveSourceMapLocations = {
              '${workspaceFolder}/**',
              '!**/node_modules/**',
            },
          },
        }
      end
    end,
  },
}
