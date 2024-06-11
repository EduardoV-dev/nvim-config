local u = require("utils/keymaps")

return {
	{
		"akinsho/bufferline.nvim",
		version = "v1.*",
		dependencies = { "nvim-tree/nvim-web-devicons", "famiu/bufdelete.nvim" },
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					close_command = require("bufdelete").bufdelete,
					diagnostics = "nvim_lsp",
					max_prefix_length = 8,
					diagnostics_indicator = function(count, level, _, _)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,
					separator_style = "slant",
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							highlight = "Directory",
							separator = true,
						},
					},
					hover = {
						enabled = true,
						delay = 200,
						reveal = { "close" },
					},
				},
			})

			-- Keymaps
			u.map("n", "H", ":BufferLineCyclePrev<CR>")
			u.map("n", "L", ":BufferLineCycleNext<CR>")
			u.map("n", "<leader>c", ":Bdelete<CR>")
		end,
	},
}
