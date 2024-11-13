local M = {}

M.setup = function()
  -- Disable default Tab key behavior and map to Ctrl+J
  vim.g.copilot_no_tab_map = true
  vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

  -- Enable Copilot for specific filetypes
  vim.g.copilot_filetypes = {
    ["*"] = false,  -- Disabled by default
    ["lua"] = true, -- Enable Copilot for specific languages
    ["python"] = true,
    ["go"] = true,
  }

  -- Keybindings for Copilot commands
  vim.api.nvim_set_keymap("n", "<leader>cp", ":Copilot panel<CR>", { noremap = true, silent = true })  -- Trigger Copilot panel
  vim.api.nvim_set_keymap("n", "<leader>ce", ":Copilot enable<CR>", { noremap = true, silent = true })  -- Enable Copilot
  vim.api.nvim_set_keymap("n", "<leader>cd", ":Copilot disable<CR>", { noremap = true, silent = true })  -- Disable Copilot
end

return M

