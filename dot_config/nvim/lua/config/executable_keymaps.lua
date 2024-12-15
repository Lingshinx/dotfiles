-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<Esc>", { desc = "which_key_ignore" })
vim.keymap.set("n", "dm", "<cmd>delm!<CR>")
vim.keymap.set("n", "<UP>", "<C-u>")
vim.keymap.set("n", "<Down>", "<C-d>")
vim.keymap.set("n", "<Left>", "<Home>")
vim.keymap.set("n", "<Right>", "<End>")
vim.keymap.set("n", "<BS>", "@@")
vim.keymap.set("n", "<leader>ch", "<cmd>cd %:h<CR>")
vim.keymap.set("n", "<C-/>", function()
  LazyVim.terminal({ "zsh" }, {
    margin = {
      left = 15,
      right = 15,
    },
    border = "solid",
  })
end, { desc = "LazyTerm" })

vim.keymap.set({ "i", "c" }, "<C-S-V>", '<C-r>"')
vim.keymap.set({ "i", "c" }, "<C-BS>", "<C-w>")
vim.keymap.set("i", "<C-CR>", "<End><CR>")

vim.keymap.set("t", "<esc><esc>", "<cmd>stopinsert<CR>", { desc = "which_key_ignore" })

-- vim.keymap.del("t", "<C-h>")
-- vim.keymap.del("t", "<C-j>")
-- vim.keymap.del("t", "<C-k>")
-- vim.keymap.del("t", "<C-l>")
--
-- vim.keymap.set("i", "<C-a>", "<Home>")
-- vim.keymap.set("i", "<C-e>", "<End>")
-- vim.keymap.set("i", "<C-f>", "<Right>")
-- vim.keymap.set("i", "<C-b>", "<Left>")
-- vim.keymap.set("i", "<C-p>", "<Up>")
-- vim.keymap.set("i", "<C-n>", "<Down>")
-- vim.keymap.set("i", "<C-d>", "<Del>")
