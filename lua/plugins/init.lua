---@diagnostic disable: undefined-global
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

  -- YAML helper
  {
    "cuducos/yaml.nvim",
    ft = { "yaml", "yml" }, -- handle both
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      -- We already configure treesitter below, so no need to call setup here

      -- Auto-update Winbar with YAML path
      local yaml = require("yaml_nvim")

      vim.api.nvim_create_autocmd({ "BufEnter", "CursorMoved" }, {
        pattern = { "*.yaml", "*.yml" },
        callback = function()
          local ok, path = pcall(yaml.get_yaml_key_and_value)
          if ok and path and path ~= "" then
            -- IMPORTANT: escape % so winbar doesn't treat them as statusline items
            path = path:gsub("%%", "%%%%")
            vim.opt_local.winbar = path
          else
            -- fallback if nothing found
            vim.opt_local.winbar = nil
          end
        end,
      })
    end,
  },

  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead", -- Load gitsigns when opening a buffer
    config = function()
      require("gitsigns").setup {
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 100,
        },
      }
    end,
  },

  {
    "github/copilot.vim",
    event = "InsertEnter", -- lazy-load on insert
    config = function()
      require("configs.copilot").setup()
    end,
  },

  -- Treesitter config
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
        "yaml", -- add yaml here
      },
      auto_install = true,
    },
  },

  -- nvim-file-location needs its own top-level plugin spec
  {
    "diegoulloao/nvim-file-location",
    config = function()
      require("nvim-file-location").setup({})
    end,
  },
}

