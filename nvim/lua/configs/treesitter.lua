return function()
  local configs = require("nvim-treesitter.configs");
  configs.setup({
    ensure_installed = {
      -- nvim
      "vim", "vimdoc", "lua",
      -- shell
      "bash", -- "nu",
      -- rust
      "rust", "toml",
      -- python
      "python",
      -- webdev
      "html", "css", "scss", "typescript", "tsx", "astro",
      -- markdown
      "markdown",
      -- nix
      "nix",
      -- haskell
      "haskell",
      -- latex
      "latex", "bibtex",
      -- misc
      "gitignore", "yaml", "regex",
    },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
  })
end

