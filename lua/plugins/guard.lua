return {
  -- Add CompetiTest for competitive programming
  {
    "xeluxee/competitest.nvim",
    dependencies = "muniftanjim/nui.nvim",
    config = function()
      require("competitest").setup({
        compile_command = {
          cpp = { exec = "g++", args = { "-Wall", "-O2", "$(FNAME)", "-o", "$(FNOEXT)" } },
        },
        run_command = {
          cpp = { exec = "./$(FNOEXT)" },
        },
      })
    end,
    keys = {
      { "<leader>cp", "<cmd>CompetiTest run<cr>", desc = "Run Test Cases" },
      { "<leader>ca", "<cmd>CompetiTest add_testcase<cr>", desc = "Add Test Case" },
      { "<leader>ce", "<cmd>CompetiTest edit_testcase<cr>", desc = "Edit Test Case" },
    },
  },
}
