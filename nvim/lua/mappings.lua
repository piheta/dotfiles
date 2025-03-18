require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--

require "nvchad.mappings"

local map = vim.keymap.set

local telescope = require("telescope.builtin")
map("n", "<leader>td", telescope.diagnostics, { desc = "Open Telescope Diagnostics" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "y", "yy", { desc = "yank line" })

-- Map Ctrl+U and Ctrl+D to also center the cursor on the screen
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

-- Function to switch to window containing next/prev buffer if it exists,
-- otherwise switch buffer in a designated "main" window
local main_window = nil

local function smart_buffer_switch(direction)
    -- Get list of valid, listed buffers
    local bufs = vim.api.nvim_list_bufs()
    local valid_bufs = {}
    for _, buf in ipairs(bufs) do
        if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, 'buflisted') then
            table.insert(valid_bufs, buf)
        end
    end

    -- Find index of current buffer
    local current_buf = vim.api.nvim_get_current_buf()
    local current_index = 1
    for i, buf in ipairs(valid_bufs) do
        if buf == current_buf then
            current_index = i
            break
        end
    end

    -- Calculate target buffer index
    local target_index
    if direction == "next" then
        target_index = current_index % #valid_bufs + 1
    else
        target_index = (current_index - 2 + #valid_bufs) % #valid_bufs + 1
    end

    local target_buf = valid_bufs[target_index]

    -- Check if target buffer is visible in any window
    local windows = vim.api.nvim_list_wins()
    for _, win in ipairs(windows) do
        -- Add a check to ensure the window is valid before using it
        if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == target_buf then
            vim.api.nvim_set_current_win(win)
            return
        end
    end

    -- Fallback to creating a new window or using the current window
    local target_win = vim.api.nvim_get_current_win()

    -- Ensure the target window is valid
    if not vim.api.nvim_win_is_valid(target_win) then
        -- If current window is invalid, create a new split
        vim.cmd('split')
        target_win = vim.api.nvim_get_current_win()
    end

    vim.api.nvim_win_set_buf(target_win, target_buf)
    vim.api.nvim_set_current_win(target_win)
end

-- Map tab and shift-tab to smart buffer switching
map("n", "<tab>", function()
    smart_buffer_switch("next")
end, { desc = "Switch to next buffer or focus its window" })

map("n", "<S-tab>", function()
    smart_buffer_switch("prev")
end, { desc = "Switch to previous buffer or focus its window" })
