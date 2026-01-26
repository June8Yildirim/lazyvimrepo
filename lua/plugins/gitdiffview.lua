-- return {
--   "sindrets/diffview.nvim",
--   cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
--   config = function()
--     require("diffview").setup({
--       enhanced_diff_hl = true,
--     })
--   end,
-- }
return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    local actions = require("diffview.actions")

    require("diffview").setup({
      enhanced_diff_hl = true, -- Better syntax highlighting
      view = {
        -- Configure the layout
        merge_tool = {
          layout = "diff3_mixed", -- or "diff3_horizontal"
        },
      },
      file_panel = {
        listing_style = "tree", -- "tree" or "list"
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded", -- "never", "always", "only_folded"
        },
      },
      hooks = {
        -- Open diffview when entering a git conflict
        diff_buf_read = function(bufnr)
          -- Add any custom buffer mappings here
          vim.keymap.set("n", "q", "<cmd>DiffviewClose<cr>", { buffer = bufnr })
        end,
      },
      keymaps = {
        disable_defaults = false, -- Disable default keymaps
        view = {
          -- Custom keymaps in diff view
          ["<tab>"] = actions.select_next_entry,
          ["<s-tab>"] = actions.select_prev_entry,
          ["<leader>e"] = actions.focus_files,
          ["<leader>b"] = actions.toggle_files,
        },
        file_panel = {
          ["j"] = actions.next_entry,
          ["k"] = actions.prev_entry,
          ["<cr>"] = actions.select_entry,
          ["s"] = actions.toggle_stage_entry,
          ["S"] = actions.stage_all,
          ["U"] = actions.unstage_all,
          ["X"] = actions.restore_entry,
          ["<leader>e"] = actions.focus_files,
          ["<leader>b"] = actions.toggle_files,
        },
      },
    })
  end,
}
