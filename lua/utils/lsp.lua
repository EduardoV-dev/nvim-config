local utils = {}

function utils.dorename(win)
	local new_name = vim.trim(vim.fn.getline("."))
	vim.api.nvim_win_close(win, true)
	vim.lsp.buf.rename(new_name)
end

function utils.rename()
	local opts = {
		border = "single",
		col = 0,
		height = 1,
		relative = "cursor",
		row = 0,
		style = "minimal",
		title = { { "New name", "white" } },
		width = 30,
	}

	local cword = vim.fn.expand("<cword>")
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, opts)
	local fmt = "<cmd>lua utils.dorename(%d)<CR>"

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { cword })
	vim.api.nvim_buf_set_keymap(buf, "i", "<CR>", string.format(fmt, win), { silent = true })
end

_G.utils = utils

return utils
