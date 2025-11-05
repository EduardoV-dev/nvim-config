local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x')

keymap.set("n", "<C-a>", "gg<S-v>G") -- Select all
keymap.set("i", "kj", "<Esc>", opts)

-- Remove snacks terminal mappings
keymap.del("n", "<leader>fT")
keymap.del("n", "<leader>ft")
keymap.del("n", "<c-/>")
keymap.del("n", "<c-_>")
keymap.del("t", "<C-/>")
keymap.del("t", "<C-_>")
