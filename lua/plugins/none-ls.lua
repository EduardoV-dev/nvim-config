local u = require("utils.keymaps")

return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua, -- lua
				null_ls.builtins.formatting.prettierd.with({ -- javascript and related
					extra_args = {
						"--allow-parens always",
						"--no-bracket-same-line",
						"--bracket-spacing",
						"--end-of-line auto",
						"--no-jsx-single-quote",
						"--no-single-attribute-per-line",
						"--print-width 100",
						"--semi",
						"--tab-width 2",
						"--trailing-comma all",
					},
				}),
				require("none-ls.code_actions.eslint"),
			},
			on_attach = function(client, bufnr) -- Function to do format on save
				local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})

		-- Keymaps

		u.map("n", "<leader>lf", vim.lsp.buf.format)
	end,
}
