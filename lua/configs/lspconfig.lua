-- lua/configs/lspconfig.lua (NvChad)
-- Load NvChad defaults (cmp capabilities, etc.)
local nvlsp = require("nvchad.configs.lspconfig")
nvlsp.defaults()

-- Correct lspconfig import
local lspconfig = require("lspconfig")

-- Base servers that use defaults only
local servers = { "html", "cssls", "gopls", "pyright", "yamlls", "lua_ls" }

for _, name in ipairs(servers) do
  lspconfig[name].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- ---- Overrides below (only where you need custom settings) ----

-- Go
lspconfig.gopls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    gopls = {
      analyses = { unusedparams = true },
      staticcheck = true,
    },
  },
}

-- YAML
lspconfig.yamlls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    yaml = {
      keyOrdering = false,
      schemaStore = { enable = true },
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
      },
    },
  },
}

-- Lua
lspconfig.lua_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = { enable = false },
    },
  },
}
