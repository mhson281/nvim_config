require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local options = { noremap = true, silent = true }

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")
map('t', '<Esc>', '<C-\\><C-n>', options)
-- Vertical split and open file
map('n', '<leader>sv', ':vsplit<CR>:Telescope find_files<CR>', options)

-- Horizontal split and open file
map('n', '<leader>sh', ':split<CR>:Telescope find_files<CR>', options)


-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
