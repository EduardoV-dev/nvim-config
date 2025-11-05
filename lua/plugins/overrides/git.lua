return {
  "lewis6991/gitsigns.nvim",
  opts = {
    current_line_blame = false,
    current_line_blame_opts = {
      delay = 0,
      virt_text = true,
      virt_text_pos = "eol",
    },
    current_line_blame_formatter = "<author> (<author_mail>), <author_time:%Y-%m-%d> - <summary> [<abbrev_sha>]",
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
  },
  keys = {
    {
      "<leader>gt",
      function()
        require("gitsigns").toggle_current_line_blame()
      end,
      desc = "Toggle git blame for current line",
      mode = { "n", "v", "x" },
    },
  },
}
