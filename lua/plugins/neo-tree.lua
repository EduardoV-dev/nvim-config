local u = require("utils.keymaps")

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          show_hidden_count = true,
          visible = true, -- Displays the hidden files by default
          hide_by_name = { ".git" },
          never_show = { ".git" },
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
      },
      window = {
        width = 30,
      },
    })

    -- Keymaps

    u.map("n", "<leader>e", ":Neotree toggle<CR>")
  end,
}
