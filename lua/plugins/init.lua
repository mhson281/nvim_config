return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        current_line_blame = true, -- Enables Git Blame for the current line
        current_line_blame_opts = {
          virt_text = true, -- Display blame as virtual text
          virt_text_pos = 'eol', -- Position of the virtual text
          delay = 100, -- Delay before showing blame
        },
      }
    end,
    event = "BufRead", -- Load gitsigns when opening a buffer
  },
  {
    "github/copilot.vim",
    config = function()
      require("configs.copilot").setup()
    end,
    -- Load Copilot on Insert mode (lazy-load)
    event = "InsertEnter",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "python",
        "html",
        "css",
        "go",
      },
      auto_install = true,
    },
    {
      "diegoulloao/nvim-file-location",
      config = function()
         require("nvim-file-location").setup({
            -- Optional configuration settings
         })
      end,
   },
  },
}

