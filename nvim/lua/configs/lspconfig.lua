-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
local servers = { "html", "cssls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- gopls setup with semantic token workaround
lspconfig.gopls.setup {
  on_attach = function(client, bufnr)
    -- Apply NvChad on_attach settings if available
    nvlsp.on_attach(client, bufnr)
    
    -- Workaround to enable semantic token support for gopls
    if client.name == 'gopls' and not client.server_capabilities.semanticTokensProvider then
      local semantic = client.config.capabilities.textDocument.semanticTokens
      client.server_capabilities.semanticTokensProvider = {
        full = true,
        legend = {tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes},
        range = true,
      }
    end
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    gopls = {
      semanticTokens = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}
