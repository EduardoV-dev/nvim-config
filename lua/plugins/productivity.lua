local umap = require("utils.keymaps")

return {
  {
    "tpope/vim-surround",
  },
  {
    "mg979/vim-visual-multi",
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      -- Mappings
      umap.map("n", "<leader>mp", ":MarkdownPreview<CR>")
      umap.map("n", "<leader>ms", ":MarkdownPreviewStop<CR>")
    end,
  },
  {
    "barrett-ruth/live-server.nvim",
    build = "yarn global add live-server",
    cmd = { "LiveServerStart", "LiveServerStop" },
    config = function()
      -- Mappings
      umap.map("n", "<leader>ls", ":LiveServerStart<CR>")
      umap.map("n", "<leader>lss", ":LiveServerStop<CR>")
    end,
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      toggler = {
        line = "<leader>/",
        block = "<leader>/",
      },
      opleader = {
        line = "<leader>/",
        block = "<leader>/",
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    config = true,
    event = "InsertEnter",
  },
}
