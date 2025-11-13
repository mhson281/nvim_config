-- Load NvChad defaults (keymaps, capabilities, etc.)
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

-- Common opts for all servers
local common = {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- List the servers you want
local servers = { "html", "cssls", "gopls", "pyright", "yamlls", "lua_ls" }

-- Apply baseline config to each
for _, s in ipairs(servers) do
  vim.lsp.config(s, common)
end

-- Per-server overrides (extend/merge with the common opts)
vim.lsp.config("gopls", vim.tbl_deep_extend("force", common, {
  settings = {
    gopls = {
      analyses = { unusedparams = true },
      staticcheck = true,
    },
  },
}))

vim.lsp.config("pyright", common)

vim.lsp.config("yamlls", vim.tbl_deep_extend("force", common, {
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
      },
    },
  },
}))

vim.lsp.config("lua_ls", vim.tbl_deep_extend("force", common, {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
}))

-- Finally, enable everything (activates on matching filetypes)
vim.lsp.enable(servers)

