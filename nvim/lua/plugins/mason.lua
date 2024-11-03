return {
  {
    "williamboman/mason.nvim"
  },

  {
    "williamboman/mason-lspconfig.nvim"
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("configs.lsp")
    end,
  }
}

