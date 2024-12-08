return {
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {
      virt_text_win_col = 80,
    },
  },
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
    },
    -- dependencies = {
    --   {
    --     "jay-babu/mason-nvim-dap.nvim",
    --     dependencies = { "nvim-dap" },
    --     cmd = { "DapInstall", "DapUninstall" },
    --     opts = { handlers = {} },
    --   },
    --   {
    --     "rcarriga/nvim-dap-ui",
    --     opts = { floating = { border = "rounded" } },
    --     config = require("plugins.configs.nvim-dap-ui"),
    --   },
    --   {
    --     "rcarriga/cmp-dap",
    --     dependencies = { "nvim-cmp" },
    --     config = require("plugins.configs.cmp-dap"),
    --   },
    -- },
  },
}
