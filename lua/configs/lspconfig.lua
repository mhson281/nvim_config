-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- Define a function to format on save
local function format_on_save(client, bufnr)
    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_command("autocmd BufWritePre <buffer=" .. bufnr .. "> lua vim.lsp.buf.formatting_sync()")
    end
end

-- Define the servers you want to set up with default configurations
local servers = { "html", "cssls", "gopls", "pyright", "yamlls", "lua_ls" }

-- Loop through the servers and configure them with nvchad's default settings
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = function(client, bufnr)
            nvlsp.on_attach(client, bufnr)  -- Call the default on_attach function
            format_on_save(client, bufnr)   -- Call the format_on_save function
        end,
        on_init = nvlsp.on_init,
        capabilities = nvlsp.capabilities,
    }
end

-- Specific configurations for certain servers (if needed)

-- Go (gopls)
lspconfig.gopls.setup {
    on_attach = function(client, bufnr)
        nvlsp.on_attach(client, bufnr)
        format_on_save(client, bufnr)
    end,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}

-- Python (pyright)
lspconfig.pyright.setup {
    on_attach = function(client, bufnr)
        nvlsp.on_attach(client, bufnr)
        format_on_save(client, bufnr)
    end,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
}

-- YAML (yamlls)
lspconfig.yamlls.setup {
    on_attach = function(client, bufnr)
        nvlsp.on_attach(client, bufnr)
        format_on_save(client, bufnr)
    end,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    settings = {
        yaml = {
            schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            },
        },
    },
}

-- Lua (sumneko_lua or lua_ls)
lspconfig.lua_ls.setup {
    on_attach = function(client, bufnr)
        nvlsp.on_attach(client, bufnr)
        format_on_save(client, bufnr)
    end,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },  -- Recognize 'vim' as a global for Neovim configs
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true), -- Autodetect Neovim runtime files
                checkThirdParty = false,
            },
        },
    },
}

