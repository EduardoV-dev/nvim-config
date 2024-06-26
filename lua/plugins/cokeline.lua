local u = require("utils.keymaps")

local colors = {
	primary_color = "#5777c6",
	hovered_color = "#8397c7",
	buffer_line_fg = "#dcdcdc",
	focused_yellow = "#fdcb6e",
	error_red = "#e06c75",
}

return {
	{
		"echasnovski/mini.bufremove",
		version = "*",
		config = function()
			require("mini.bufremove").setup()
		end,
	},
	{
		"willothy/nvim-cokeline",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for v0.4.0+
			"nvim-tree/nvim-web-devicons", -- If you want devicons
			"stevearc/resession.nvim", -- Optional, for persistent history
		},
		config = function()
			local get_hex = require("cokeline.hlgroups").get_hl_attr
			local max_error_limit = 9

			require("cokeline").setup({
				default_hl = {
					fg = function(buffer)
						return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg")
					end,
					bg = "NONE",
				},
				sidebar = {
					filetype = { "NvimTree", "neo-tree" },
					components = {
						{
							text = function()
								return "File Explorer"
							end,
							fg = "#ffffff",
							bg = function()
								return get_hex("NvimTreeNormal", "bg")
							end,
							bold = true,
						},
					},
				},
				components = {
					{
						text = " | ",
						fg = colors.primary_color,
					},
					{
						text = function(buffer)
							return " " .. buffer.devicon.icon
						end,
						fg = function(buffer)
							return buffer.is_focused and buffer.devicon.color or "#ABB2BF"
						end,
					},
					{
						text = function(buffer)
							return buffer.unique_prefix
						end,
					},
					{
						text = function(buffer)
							return buffer.filename .. "  "
						end,
						bold = function(buffer)
							return buffer.is_focused
						end,
						italic = function(buffer)
							return buffer.is_modified
						end,
					},
					{
						text = function(buffer)
							local warnings = buffer.diagnostics.warnings

							if warnings > 0 then
								return warnings .. "  "
							elseif warnings > 0 and warnings <= max_error_limit then
								return warnings .. "+  "
							end

							return ""
						end,
						fg = function(buffer)
							local warnings = buffer.diagnostics.warnings
							return warnings > 0 and warnings <= max_error_limit and colors.focused_yellow
						end,
						bold = true,
					},
					{
						text = function(buffer)
							local errors = buffer.diagnostics.errors

							if errors > 0 then
								return errors .. "  "
							elseif errors > 0 and errors <= max_error_limit then
								return errors .. " +   "
							end

							return ""
						end,
						fg = function(buffer)
							local errors = buffer.diagnostics.errors
							return errors > 0 and errors <= max_error_limit and colors.focused_yellow
						end,
						bold = true,
					},
					{
						text = function(buffer)
							local focused_icon = buffer.is_focused and "" or "󰅚"

							return buffer.is_modified and "" or focused_icon
						end,
						fg = function(buffer)
							local focused_color = buffer.is_focused and "#98C379" or colors.buffer_line_fg

							return buffer.is_modified and colors.focused_yellow or focused_color
						end,
						on_click = function(_, _, _, _, buffer)
							buffer:delete()
						end,
					},
					{
						text = " ",
					},
				},
			})

			-- Keymaps
			u.map("n", "H", "<Plug>(cokeline-focus-prev)")
			u.map("n", "L", "<Plug>(cokeline-focus-next)")
			u.map("n", "<leader>c", function()
				require("mini.bufremove").delete()
			end)
		end,
	},
}
