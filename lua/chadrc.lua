-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "tokyonight",
}

_G.transparency_enabled = false

function _G.toggle_transparency()
  if transparency_enabled then
    -- Set background to default color (replace with your default background color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "#1e222a" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1e222a" })
    transparency_enabled = false
  else
    -- Set background to transparent
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    transparency_enabled = true
  end
end

-- Map the toggle function to <leader>tt
vim.api.nvim_set_keymap("n", "<leader>tt", ":lua toggle_transparency()<CR>", { noremap = true, silent = true })

return M
