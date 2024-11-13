require "nvchad.mappings"

-- add yours here

local map = vim.api.nvim_set_keymap
local options { noremap = true, silent = true}


-- Do not use this mapping
--map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")
-- Map <Esc> to exit terminal mode
map('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
-- Vertical split and open file
map('n', '<leader>sv', ':vsplit<CR>:Telescope find_files<CR>', options)

-- Horizontal split and open file
map('n', '<leader>sh', ':split<CR>:Telescope find_files<CR>', options)

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
