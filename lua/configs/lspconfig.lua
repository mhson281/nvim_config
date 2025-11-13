-- lua/configs/lspconfig.lua (NvChad)

---@diagnostic disable: deprecated
---@diagnostic disable: undefined-global

-- Load NvChad defaults (cmp capabilities, etc.)
local nvlsp = require("nvchad.configs.lspconfig")
nvlsp.defaults()

-- Use the actual lspconfig module (still required for NvChad)
---@diagnostic disable-next-line: undefined-global
local lspconfig = require("lspconfig")

-- Servers that just use the defaults
local servers = { "html", "cssls", "pyright" }

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

