return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local dap_python = require("dap-python")

      -- Setup dap-ui first
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            position = "left",
            size = 80,
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            position = "bottom",
            size = 15,
          },
        },
      })

      -- Virtual text setup
      require("nvim-dap-virtual-text").setup({
        commented = true,
      })

      -- Python debugger setup with better error handling
      local python_path = vim.fn.exepath("python3") or "python3"
      dap_python.setup(python_path)

      -- Additional Python configurations
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return python_path
          end,
        },
        {
          type = "python",
          request = "attach",
          name = "Attach remote",
          connect = function()
            return { host = "127.0.0.1", port = 5678 }
          end,
        },
      }

      -- Better breakpoint signs
      vim.fn.sign_define("DapBreakpoint", {
        text = "🔴",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapBreakpointCondition", {
        text = "",
        texthl = "DiagnosticSignWarn",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapBreakpointRejected", {
        text = "🚫",
        texthl = "DiagnosticSignHint",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapStopped", {
        text = "➡️",
        texthl = "DiagnosticSignInfo",
        linehl = "CursorLine",
        numhl = "DiagnosticSignInfo",
      })

      vim.fn.sign_define("DapLogPoint", {
        text = "📝",
        texthl = "DiagnosticSignInfo",
        linehl = "",
        numhl = "",
      })

      -- Enhanced auto open/close for DAP UI
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      local opts = { noremap = true, silent = true }

      -- Debugging keymaps
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts)
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, opts)
      vim.keymap.set("n", "<leader>dc", dap.continue, opts)
      vim.keymap.set("n", "<leader>do", dap.step_over, opts)
      vim.keymap.set("n", "<leader>di", dap.step_into, opts)
      vim.keymap.set("n", "<leader>dO", dap.step_out, opts)
      vim.keymap.set("n", "<leader>dq", dap.terminate, opts)
      vim.keymap.set("n", "<leader>du", dapui.toggle, opts)
      vim.keymap.set("n", "<leader>dr", dap.restart, opts)
      vim.keymap.set("n", "<leader>dl", dap.run_last, opts)
      vim.keymap.set("n", "<leader>dp", function()
        dap.pause()
      end, opts)

      -- Hover information
      vim.keymap.set("n", "<leader>dh", function()
        require("dap.ui.widgets").hover()
      end, opts)

      -- Debug console
      vim.keymap.set("n", "<leader>dC", function()
        require("dap").repl.open()
      end, opts)

      -- Add which-key descriptions (if you use which-key)
      local wk_ok, wk = pcall(require, "which-key")
      if wk_ok then
        wk.register({
          d = {
            name = "Debug",
            b = "Toggle Breakpoint",
            B = "Conditional Breakpoint",
            c = "Continue",
            o = "Step Over",
            i = "Step Into",
            O = "Step Out",
            q = "Terminate",
            u = "Toggle UI",
            r = "Restart",
            l = "Run Last",
            p = "Pause",
            h = "Hover",
            C = "Console",
          },
        }, { prefix = "<leader>" })
      end
    end,
  },
}

-- return {
--   {
--     "mfussenegger/nvim-dap",
--     dependencies = {
--       "nvim-neotest/nvim-nio",
--       "rcarriga/nvim-dap-ui",
--       "mfussenegger/nvim-dap-python",
--       "theHamsta/nvim-dap-virtual-text",
--     },
--     config = function()
--       local dap = require("dap")
--       local dapui = require("dapui")
--       local dap_python = require("dap-python")
--
--       -- require("dapui").setup({})
--       require("nvim-dap-virtual-text").setup({
--         commented = true, -- Show virtual text alongside comment
--       })
--
--       dap_python.setup("python3")
--
--       vim.fn.sign_define("DapBreakpoint", {
--         text = "",
--         texthl = "DiagnosticSignError",
--         linehl = "",
--         numhl = "",
--       })
--
--       vim.fn.sign_define("DapBreakpointRejected", {
--         text = "", -- or "❌"
--         texthl = "DiagnosticSignError",
--         linehl = "",
--         numhl = "",
--       })
--
--       vim.fn.sign_define("DapStopped", {
--         text = "", -- or "→"
--         texthl = "DiagnosticSignWarn",
--         linehl = "Visual",
--         numhl = "DiagnosticSignWarn",
--       })
--
--       -- Automatically open/close DAP UI
--       dap.listeners.after.event_initialized["dapui_config"] = function()
--         dapui.open()
--       end
--
--       local opts = { noremap = true, silent = true }
--
--       -- Toggle breakpoint
--       vim.keymap.set("n", "<leader>db", function()
--         dap.toggle_breakpoint()
--       end, opts)
--
--       -- Continue / Start
--       vim.keymap.set("n", "<leader>dc", function()
--         dap.continue()
--       end, opts)
--
--       -- Step Over
--       vim.keymap.set("n", "<leader>do", function()
--         dap.step_over()
--       end, opts)
--
--       -- Step Into
--       vim.keymap.set("n", "<leader>di", function()
--         dap.step_into()
--       end, opts)
--
--       -- Step Out
--       vim.keymap.set("n", "<leader>dO", function()
--         dap.step_out()
--       end, opts)
--
--       -- Keymap to terminate debugging
--       vim.keymap.set("n", "<leader>dq", function()
--         require("dap").terminate()
--       end, opts)
--
--       -- Toggle DAP UI
--       vim.keymap.set("n", "<leader>du", function()
--         dapui.toggle()
--       end, opts)
--     end,
--   },
-- }
