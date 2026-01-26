return {
  "mfussenegger/nvim-jdtls",
  opts = function(_, opts)
    opts = opts or {}
    opts.cmd = opts.cmd or {}
    opts.settings = opts.settings or {}

    -- Try to add lombok support if available
    pcall(function()
      local registry = require("mason-registry")
      if registry.is_installed("jdtls") then
        local pkg = registry.get_package("jdtls")
        local install_path = pkg:get_install_path()
        local lombok = install_path .. "/lombok.jar"
        if vim.fn.filereadable(lombok) == 1 then
          table.insert(opts.cmd, "--jvm-arg=-javaagent:" .. lombok)
        end
      end
    end)

    opts.settings.java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-17",
            path = "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home",
          },
          {
            name = "JavaSE-11",
            path = "/Library/Java/JavaVirtualMachines/openlogic-openjdk-11.jdk/Contents/Home",
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
    }

    return opts
  end,
}
