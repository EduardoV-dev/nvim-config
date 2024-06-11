local u = require("utils.keymaps")

u.map("", "<up>", "<nop>")
u.map("", "<down>", "<nop>")
u.map("", "<left>", "<nop>")
u.map("", "<right>", "<nop>")

u.map("n", "<leader>w", ":w<CR>")
u.map("n", "<leader>q", ":q<CR><CR>")
u.map("n", "<leader>vs", ":vsplit<CR>")
u.map("n", "d", '"_d')           -- Avoids to copy text to clipboard when deleting lines

u.map("i", "<C-h>", "<C-W>")     -- Simulates Ctrl + <BS> (<C-h> is the same as Ctrl + <BS>)
u.map("i", "<C-Del>", "<C-o>dw") -- Simulates Ctrl + Del
