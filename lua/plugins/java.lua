return {
  "mfussenegger/nvim-jdtls",
  opts = {
    jdtls = function(opts)
      local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
      local jvmArg = "-javaagent:" .. install_path .. "/lombok.jar"
      table.insert(opts.cmd, "--jvm-arg=" .. jvmArg)

      opts.settings = {
        java = {
          eclipse = {
            downloadSources = true,
          },
          configuration = {
            runtimes = {
              {
                name = "JavaSE-17",
                path = "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home/bin/java",
              },
              {
                name = "JavaSE-11",
                path = "/Library/Java/JavaVirtualMachines/openlogic-openjdk-11.jdk/Contents/Home/bin/java",
              },
            },
          },
          format = {
            enabled = true,
            settings = {
              url = vim.fn.expand("~/javaStyle/eclipse-java-google-style.xml"),
              profile = "GoogleStyle",
            },
          },
          inlayHints = {
            parameterNames = {
              enabled = "all",
            },
          },
          maven = {
            downloadSources = true,
          },
          references = {
            includeDecompiledSources = true,
          },
          referencesCodeLens = {
            enabled = true,
          },
        },
      }

      return opts
    end,
  },
}
