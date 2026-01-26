-- Formatting configuration
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      java = { "lsp" }, -- Use jdtls LSP for Java formatting
    },
  },
}
