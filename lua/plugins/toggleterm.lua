local umap = require("utils.keymaps")

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        float_opts = {
          border = "curved",
          title_pos = "center",
        },
      })

      -- Keymaps
      umap.map("n", "<leader>th", ":ToggleTerm size=10 direction=horizontal<CR>")
      umap.map("n", "<leader>tf", ":ToggleTerm direction=float<CR>")
      umap.map("n", "<leader>tv", ":ToggleTerm size=40 direction=vertical<CR>")

      umap.map("t", "<esc>", [[<C-\><C-n>]])
      umap.map("t", "kj", [[<C-\><C-n>]])
      umap.map("t", "<C-h>", [[<Cmd>wincmd h<CR>]])
      umap.map("t", "<C-j>", [[<Cmd>wincmd j<CR>]])
      umap.map("t", "<C-k>", [[<Cmd>wincmd k<CR>]])
      umap.map("t", "<C-l>", [[<Cmd>wincmd l<CR>]])
    end,
  },
}
