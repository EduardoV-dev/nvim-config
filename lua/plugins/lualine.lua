return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    disabled_filetypes = { "packer", "NvimTree" },
    theme = "ayu_mirage",
    extensions = { "neo-tree" },
  },
}
