-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle)
-- Diffview keymaps
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diffview Open" })
vim.keymap.set("n", "<leader>gD", "<cmd>DiffviewClose<cr>", { desc = "Diffview Close" })
vim.keymap.set("n", "<leader>gt", "<cmd>DiffviewToggleFiles<cr>", { desc = "Diffview Toggle Files" })
vim.keymap.set("n", "<leader>gf", "<cmd>DiffviewFocusFiles<cr>", { desc = "Diffview Focus Files" })
vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory<cr>", { desc = "File History" })
vim.keymap.set("n", "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", { desc = "File History (current)" })
vim.api.nvim_set_keymap("n", "<leader>nj", ":lua CreateJavaProject()<CR>", { noremap = true, silent = true })
