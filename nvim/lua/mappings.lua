require "nvchad.mappings"

local map = vim.keymap.set

map("n", "<leader>td", "<cmd>Telescope diagnostics<CR>", { desc = "Open Telescope Diagnostics" })

-- Default nvchad
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Instant yank
map("n", "y", "yy", { desc = "yank line" })

-- Map Ctrl+U and Ctrl+D to also center the cursor on the screen
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
