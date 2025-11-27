-- lua/configs/lspconfig.lua

---@diagnostic disable: undefined-global

-- NvChad defaults (cmp capabilities, etc.)
local nvlsp = require("nvchad.configs.lspconfig")
nvlsp.defaults()

-- Base config shared by all servers
local base = {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- Helper to merge base config + extra config, then register + enable server
local function setup(server_name, extra)
  local cfg = vim.tbl_deep_extend("force", base, extra or {})
  vim.lsp.config(server_name, cfg)
  vim.lsp.enable(server_name)
end

-- Simple servers that just use defaults
setup("html")
setup("cssls")
setup("pyright")

-- Go (gopls)
setup("gopls", {
  settings = {
    gopls = {
      analyses = { unusedparams = true },
      staticcheck = true,
    },
  },
})

-- YAML (yamlls)
setup("yamlls", {
  settings = {
    yaml = {
      keyOrdering = false,
      schemaStore = { enable = true },
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
      },
    },
  },
})

-- Lua (lua_ls)
setup("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = { enable = false },
    },
  },
})

setup("terraformls", {
  filetypes = { "terraform", "tf" , "terraform-vars"},
  settings = {
    terraform = {
      languageServer = {
        external = true,
        source = "terraform-ls",
      }
    }
  }
})

setup("tflint", {
  filetypes = { "terraform", "tf" , "terraform-vars"},
})

setup("hcl_ls", {
  filetypes = { "hcl", "tf", "terraform-vars" },
})
