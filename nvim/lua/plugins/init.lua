return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "go", "javascript", "svelte", "html", "css", "python"},
  	},
  },

  {
     "nvim-tree/nvim-tree.lua",
     opts = {
       view = {
         side = "right",
       },
     }
  }

}
