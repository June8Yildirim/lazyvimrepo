return {
  -- Extend nvim-lspconfig to ensure jdtls is handled correctly
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        -- This prevents duplicate server starts and lets nvim-jdtls take over
        jdtls = function()
          return true
        end,
      },
    },
  },

  -- Configure nvim-jdtls with Debugging (DAP) support
  {
    "mfussenegger/nvim-jdtls",
    opts = function()
      return {
        -- This will automatically look for the java-debug-adapter installed via Mason
        dap = {
          hotcodereplace = "auto",
          config_overrides = {},
        },
      }
    end,
  },

  -- Ensure the debug adapter and test runner are installed via Mason
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "java-debug-adapter",
        "java-test",
        "vtsls", -- Better TS LSP
        "prettierd",
      })
    end,
  },
}
-- return {
--   "neovim/nvim-lspconfig",
--   dependencies = { "williamboman/mason.nvim" },
--   opts = {
--     setup = {
--       jdtls = function()
--         return true -- Let nvim-jdtls handle setup
--       end,
--     },
--   },
-- }
-- -- return {
-- --   "mfussenegger/nvim-jdtls",
-- --   opts = {
-- --     jdtls = function(opts)
-- --       local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
-- --       local jvmArg = "-javaagent:" .. install_path .. "/lombok.jar"
-- --       table.insert(opts.cmd, "--jvm-arg=" .. jvmArg)
-- --
-- --       opts.settings = {
-- --         java = {
-- --           eclipse = {
-- --             downloadSources = true,
-- --           },
-- --           configuration = {
-- --             runtimes = {
-- --               {
-- --                 name = "JavaSE-17",
-- --                 path = "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home/bin/java",
-- --               },
-- --               {
-- --                 name = "JavaSE-11",
-- --                 path = "/Library/Java/JavaVirtualMachines/openlogic-openjdk-11.jdk/Contents/Home/bin/java",
-- --               },
-- --             },
-- --           },
-- --           format = {
-- --             enabled = true,
-- --             settings = {
-- --               url = vim.fn.expand("~/javaStyle/eclipse-java-google-style.xml"),
-- --               profile = "GoogleStyle",
-- --             },
-- --           },
-- --           inlayHints = {
-- --             parameterNames = {
-- --               enabled = "all",
-- --             },
-- --           },
-- --           maven = {
-- --             downloadSources = true,
-- --           },
-- --           references = {
-- --             includeDecompiledSources = true,
-- --           },
-- --           referencesCodeLens = {
-- --             enabled = true,
-- --           },
-- --         },
-- --       }
-- --
-- --       return opts
--     end,
--   },
-- }
