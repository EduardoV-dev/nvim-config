return {
	{
		"goolord/alpha-nvim",
		config = function()
			--[[ require("alpha").setup(require("alpha.themes.dashboard").config) ]]
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {
				[[██╗   ██╗ █████╗ ██████╗ ███████╗██╗      █████╗     ██╗   ██╗██╗███╗   ███╗]],
				[[██║   ██║██╔══██╗██╔══██╗██╔════╝██║     ██╔══██╗    ██║   ██║██║████╗ ████║]],
				[[██║   ██║███████║██████╔╝█████╗  ██║     ███████║    ██║   ██║██║██╔████╔██║]],
				[[╚██╗ ██╔╝██╔══██║██╔══██╗██╔══╝  ██║     ██╔══██║    ╚██╗ ██╔╝██║██║╚██╔╝██║]],
				[[ ╚████╔╝ ██║  ██║██║  ██║███████╗███████╗██║  ██║     ╚████╔╝ ██║██║ ╚═╝ ██║]],
				[[  ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝      ╚═══╝  ╚═╝╚═╝     ╚═╝]],
			}

			dashboard.section.buttons.val = {
				dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
				dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
				dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
			}

			dashboard.section.footer.opts.hl = "Type"
			dashboard.section.header.opts.hl = "Include"
			dashboard.section.buttons.opts.hl = "Keyword"

			dashboard.opts.opts.noautocmd = true
			alpha.setup(dashboard.opts)
		end,
		requires = { "nvim-tree/nvim-web-devicons" },
	},
}
