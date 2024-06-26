return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      ensure_installed = {
        "astro",
        "css",
        "dockerfile",
        "go",
        "gomod",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "markdown",
        "scss",
        "svelte",
        "tsx",
        "typescript",
        "yaml",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
