return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mxsdev/nvim-dap-vscode-js",
    },
    config = function()
      local dap = require("dap")

      -- ========== 1. C/C++ (CodeLLDB) ==========
      -- Check if codelldb exists
      local codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"

      if vim.fn.filereadable(codelldb_path) == 0 then
        vim.notify("⚠️ codelldb not found. Please install via :MasonInstall codelldb", vim.log.levels.WARN)
      else
        -- Basic codelldb configuration
        dap.adapters.codelldb = {
          type = "server",
          port = 13000,
          executable = {
            command = codelldb_path,
            args = { "--port", "13000" },
          },
        }

        -- C++ debug configuration
        dap.configurations.cpp = {
          {
            name = "Launch C++",
            type = "codelldb",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
          },
        }

        -- Use same config for C
        dap.configurations.c = dap.configurations.cpp
      end

      -- ========== 2. JavaScript/TypeScript ==========
      -- Setup JS debug adapter
      require("dap-vscode-js").setup({
        debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge" },
      })

      -- Common JS/TS configurations
      local js_config = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Current File",
          program = "${file}",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "node",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch with Nodemon",
          runtimeExecutable = "nodemon",
          program = "${file}",
          cwd = "${workspaceFolder}",
          restart = true,
          console = "integratedTerminal",
        },
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch Chrome",
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
        },
      }

      -- Apply to both JS and TS
      dap.configurations.javascript = js_config
      dap.configurations.typescript = js_config
      dap.configurations.javascriptreact = js_config
      dap.configurations.typescriptreact = js_config

      -- ========== 3. Debug Signs ==========
      vim.fn.sign_define("DapBreakpoint", {
        text = "🔴",
        texthl = "DiagnosticSignError",
      })

      vim.fn.sign_define("DapBreakpointCondition", {
        text = "🟡",
        texthl = "DiagnosticSignWarn",
      })

      vim.fn.sign_define("DapStopped", {
        text = "➡️",
        texthl = "DiagnosticSignInfo",
        linehl = "CursorLine",
      })

      -- ========== 4. Keymaps ==========
      -- Debugging keymaps (work for all languages)
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: Conditional Breakpoint" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })

      vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Debug: Restart" })
      vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Debug: Stop" })

      -- ========== 5. Language-specific Commands ==========
      -- C++ helper
      vim.api.nvim_create_user_command("DebugBuildCpp", function()
        local file = vim.fn.expand("%")

        if file:match("%.cpp$") or file:match("%.c$") then
          local output = vim.fn.getcwd() .. "/debug.out"
          local cmd = "g++ -g -o " .. output .. " " .. file
          vim.cmd("!" .. cmd)
          vim.notify("✅ Built C++: " .. output, vim.log.levels.INFO)
        else
          vim.notify("❌ Not a C/C++ file", vim.log.levels.ERROR)
        end
      end, {})

      -- JS/TS helper
      vim.api.nvim_create_user_command("DebugNode", function()
        local file = vim.fn.expand("%")

        if file:match("%.js$") or file:match("%.ts$") or file:match("%.jsx$") or file:match("%.tsx$") then
          -- Check if package.json exists for Node projects
          local package_json = vim.fn.getcwd() .. "/package.json"
          local program = "${file}"

          if vim.fn.filereadable(package_json) == 1 then
            -- For projects with package.json, we can use the main file
            vim.notify("📦 Node project detected", vim.log.levels.INFO)
          end

          dap.run({
            type = "pwa-node",
            request = "launch",
            name = "Debug Node File",
            program = program,
            cwd = "${workspaceFolder}",
            runtimeExecutable = "node",
          })
        else
          vim.notify("❌ Not a JavaScript/TypeScript file", vim.log.levels.ERROR)
        end
      end, {})

      -- Browser debugging for JS/TS
      vim.api.nvim_create_user_command("DebugBrowser", function()
        dap.run({
          type = "pwa-chrome",
          request = "launch",
          name = "Launch Chrome for Debugging",
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
        })
      end, {})

      -- ========== 6. Install helper ==========
      vim.api.nvim_create_user_command("DebugInstallAll", function()
        vim.notify("Installing debug adapters...", vim.log.levels.INFO)

        -- Install via Mason
        local mason_api = require("mason.api")

        -- C/C++ debugger
        mason_api.command.Install({ package = "codelldb" })

        -- JavaScript/TypeScript debugger
        mason_api.command.Install({ package = "js-debug-adapter" })
      end, {})
    end,
  },
}

-- return {
--   {
--     "mfussenegger/nvim-dap",
--     config = function()
--       local dap = require("dap")
--
--       -- Check if codelldb exists
--       local codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"
--
--       if vim.fn.filereadable(codelldb_path) == 0 then
--         vim.notify("⚠️ codelldb not found. Please install via :MasonInstall codelldb", vim.log.levels.WARN)
--         return
--       end
--
--       -- Basic codelldb configuration - FIXED: Use actual port number
--       dap.adapters.codelldb = {
--         type = "server",
--         port = 13000,
--         executable = {
--           command = codelldb_path,
--           args = { "--port", "13000" }, -- Use actual number, not variable
--         },
--       }
--
--       -- Simple executable finder
--       local function find_executable()
--         local cwd = vim.fn.getcwd()
--
--         -- Try common build locations
--         local possible_paths = {
--           cwd .. "/a.out",
--           cwd .. "/main",
--           cwd .. "/build/a.out",
--           cwd .. "/build/main",
--         }
--
--         for _, path in ipairs(possible_paths) do
--           if vim.fn.filereadable(path) == 1 then
--             return path
--           end
--         end
--
--         -- If not found, ask user
--         return vim.fn.input("Path to executable: ", cwd .. "/", "file")
--       end
--
--       -- C++ debug configuration - SIMPLIFIED
--       dap.configurations.cpp = {
--         {
--           name = "Launch C++",
--           type = "codelldb",
--           request = "launch",
--           program = find_executable,
--           cwd = "${workspaceFolder}",
--           stopOnEntry = false,
--         },
--       }
--
--       -- Use same config for C
--       dap.configurations.c = dap.configurations.cpp
--
--       -- Debug signs
--       vim.fn.sign_define("DapBreakpoint", {
--         text = "🔴",
--         texthl = "DiagnosticSignError",
--       })
--
--       vim.fn.sign_define("DapStopped", {
--         text = "➡️",
--         texthl = "DiagnosticSignInfo",
--         linehl = "CursorLine",
--       })
--
--       -- Basic keymaps
--       vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
--       vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
--       vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
--       vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
--       vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
--
--       -- Helper command to build debug executable
--       vim.api.nvim_create_user_command("DebugBuild", function()
--         local cwd = vim.fn.getcwd()
--         local file = vim.fn.expand("%")
--
--         if file:match("%.cpp$") or file:match("%.c$") then
--           local output = cwd .. "/a.out"
--           local cmd = "g++ -g -o " .. output .. " " .. file
--           vim.cmd("!" .. cmd)
--           vim.notify("✅ Built: " .. output, vim.log.levels.INFO)
--         else
--           vim.notify("❌ Not a C/C++ file", vim.log.levels.ERROR)
--         end
--       end, {})
--     end,
--   },
-- }
--
-- -- return {
--   {
--     "mfussenegger/nvim-dap",
--     config = function()
--       local dap = require("dap")
--
--       -- Basic codelldb configuration
--       dap.adapters.codelldb = {
--         type = "server",
--         port = 13000,
--         executable = {
--           command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
--           args = { "--port", "13000" },
--         },
--       }
--
--       -- C++ debug configuration
--       dap.configurations.cpp = {
--         {
--           name = "Launch C++",
--           type = "codelldb",
--           request = "launch",
--           program = function()
--             return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
--           end,
--           cwd = "${workspaceFolder}",
--         },
--       }
--
--       -- Use same config for C
--       dap.configurations.c = dap.configurations.cpp
--
--       -- Basic keymaps
--       vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
--       vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
--     end,
--   },
-- }
