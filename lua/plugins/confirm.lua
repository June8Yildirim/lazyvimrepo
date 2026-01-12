return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- Use prettierd (fast) or prettier
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
      },
      -- If this is true, it will only format if a config file is found
      formatters = {
        prettier = {
          condition = function()
            return true -- Forces prettier to run even without a .prettierrc
          end,
        },
      },
    },
  },
}
