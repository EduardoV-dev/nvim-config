local u = require("utils/keymaps")

return {
	"mrjones2014/smart-splits.nvim",
	config = function()
		-- Keymaps

		-- recommended mappings
		-- resizing splits
		-- these keymaps will also accept a range,
		-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`

		u.map("n", "<A-h>", require("smart-splits").resize_left)
		u.map("n", "<A-j>", require("smart-splits").resize_down)
		u.map("n", "<A-k>", require("smart-splits").resize_up)
		u.map("n", "<A-l>", require("smart-splits").resize_right)
		-- moving between splits
		u.map("n", "<C-h>", require("smart-splits").move_cursor_left)
		u.map("n", "<C-j>", require("smart-splits").move_cursor_down)
		u.map("n", "<C-k>", require("smart-splits").move_cursor_up)
		u.map("n", "<C-l>", require("smart-splits").move_cursor_right)
		u.map("n", "<C-\\>", require("smart-splits").move_cursor_previous)
		-- swapping buffers between windows
		u.map("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
		u.map("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
		u.map("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
		u.map("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
	end,
}
