require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local options = { noremap = true, silent = true }

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")
map('t', '<Esc>', '<C-\\><C-n>', options)
-- Vertical split and open file
map('n', '<leader>sv', ':vsplit<CR>:Telescope find_files<CR>', options)

-- copy file path for current file to clipboard
map('n', '<leader>ll', function()
   local file = vim.fn.expand('%:p')
   local file_location = string.format('%s', file)
   vim.fn.setreg('+', file_location) -- Copy to clipboard
   vim.notify('Copied: ' .. file_location, vim.log.levels.INFO)
end, { desc = "Copy file path and line number", noremap = true, silent = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
