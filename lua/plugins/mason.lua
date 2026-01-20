-- add any tools you want to have installed below
return {
  "mason-org/mason.nvim",
  opts = {
    auto_install = false,
    ensure_installed = {
      "stylua",
      "shellcheck",
      "shfmt",
      "flake8",
      "goimports",
      "gofumpt",
      "gopls",
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_installation = false,
    },
  },
}
-- -- add any tools you want to have installed below
-- {
--   "mason-org/mason.nvim",
--   opts = {
--     ensure_installed = {
--       "stylua",
--       "shellcheck",
--       "shfmt",
--       "flake8",
--       "goimports",
--       "gofumpt",
--       "gopls",
--     },
--   },
-- }
