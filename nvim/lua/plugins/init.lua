return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
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
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    event = {},
    cmd = {},
    opts = {},
    config = function()
      pcall(function()
        dofile(vim.g.base46_cache .. "syntax")
        dofile(vim.g.base46_cache .. "treesitter")
      end)

      local parsers = {
        "c",
        "lua",
        "luadoc",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "printf",
        "go",
        "javascript",
        "svelte",
        "html",
        "css",
        "python",
        "terraform",
      }

      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "c",
          "lua",
          "vim",
          "markdown",
          "go",
          "terraform",
          "javascript",
          "svelte",
          "html",
          "css",
          "python",
        },
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        side = "right",
      },
    },
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
}
