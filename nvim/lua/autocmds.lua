require "nvchad.autocmds"

-- Thin white outline on floating windows; re-applied after any theme load
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ffffff" })
  end,
})
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ffffff" })
