return {
  "lewis6991/gitsigns.nvim",

  config = function()
    require("gitsigns").setup()
    vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
    vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})
  end,

  -- event = "BufReadPre",
  -- config = function()
  --   require("gitsigns").setup({
  --     signs = {
  --       add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
  --       change = {
  --         hl = "GitSignsChange",
  --         text = "│",
  --         numhl = "GitSignsChangeNr",
  --         linehl = "GitSignsChangeLn",
  --       },
  --       delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
  --       topdelete = {
  --         hl = "GitSignsDelete",
  --         text = "‾",
  --         numhl = "GitSignsDeleteNr",
  --         linehl = "GitSignsDeleteLn",
  --       },
  --       changedelete = {
  --         hl = "GitSignsChange",
  --         text = "~",
  --         numhl = "GitSignsChangeNr",
  --         linehl = "GitSignsChangeLn",
  --       },
  --       untracked = { hl = "GitSignsAdd", text = "┆", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
  --     },
  --   })
  -- end,
}
