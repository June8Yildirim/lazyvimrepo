return {
  -- Extend the default LSP config for clojure-lsp
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["clojure_lsp"] = {
          -- Example of a custom setting (often not needed)
          settings = {
            -- ... your clojure-lsp settings
          },
        },
      },
    },
  },
}
