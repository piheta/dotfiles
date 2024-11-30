require "nvchad.options"

-- add yours here!
--
local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

o.tabstop = 4      -- Number of spaces for a tab
o.shiftwidth = 4   -- Number of spaces for indentation
o.expandtab = true -- Use spaces instead of tabs

o.number = true
o.relativenumber = true
o.statuscolumn = "%s%=%{v:relnum?v:relnum:v:lnum} "
o.numberwidth = 3
--o.signcolumn = "yes:1"
