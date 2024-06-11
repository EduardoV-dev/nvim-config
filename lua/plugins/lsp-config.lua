local umap = require("utils/keymaps")
local ulsp = require("utils/lsp")

local LSPs = {
  "astro",
  "cssls",
  "cssmodules_ls",
  "docker_compose_language_service",
  "dockerls",
  "emmet_ls",
  "eslint",
  "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "svelte",
  "tailwindcss",
  "tsserver",
  "yamlls",
}

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = { "prettierd", "stylua", "eslint_d" },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = LSPs,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      for _, lsp in ipairs(LSPs) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end

      -- Customizing the diagnostic dialog
      vim.lsp.handlers["textDocument/publishDiagnostics"] =
          vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            underline = true,
            virtual_text = {
              prefix = function(diagnostic)
                if diagnostic.severity == vim.diagnostic.severity.ERROR then
                  return "" -- Nerd font icon for error
                elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                  return "" -- Nerd font icon for warning
                elseif diagnostic.severity == vim.diagnostic.severity.INFO then
                  return "" -- Nerd font icon for info
                else
                  return "" -- Nerd font icon for hint
                end
              end,
              severity = nil,
              source = "if_many",
              format = nil,
            },
            signs = true,
            severity_sort = true,
            update_in_insert = true,
          })

      -- Keymaps

      umap.map("n", "K", vim.lsp.buf.hover)
      umap.map("n", "gd", vim.lsp.buf.definition)
      umap.map("n", "gr", function()
        require("telescope.builtin").lsp_references()
      end)

      umap.map("n", "<leader>lr", ulsp.rename)
      umap.map("n", "<leader>la", vim.lsp.buf.code_action)
      umap.map("n", "<leader>ld", vim.diagnostic.open_float)
    end,
  },
}
