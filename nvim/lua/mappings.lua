require "nvchad.mappings"

local map = vim.keymap.set

map("n", "<leader>td", "<cmd>Telescope diagnostics<CR>", { desc = "Open Telescope Diagnostics" })

-- Diagnostics
map("n", "<leader>te", function()
  vim.diagnostic.open_float()
end, { desc = "Show error in floating window" })

-- Default nvchad
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Instant yank
map("n", "y", "yy", { desc = "yank line" })

-- Map Ctrl+U and Ctrl+D to also center the cursor on the screen
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Go Developement
map("n", "<leader>gos", ":!swag init<CR>", { desc = "Swag Init" })
map("n", "<leader>gol", ":!golangci-lint run<CR>", { desc = "Golangci-lint Run" })
map("n", "<leader>got", ":!go test ./...<CR>", { desc = "Go Test" })
map("n", "<leader>goe", "oif err != nil {<CR>return err<CR>}<ESC>", { desc = "Insert Go error check" })
