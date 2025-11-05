local horizontal_size = 15
local vertical_size = vim.o.columns * 0.3

---@type table<string, { size: number }>
local terminal_layouts = {
  horizontal = { size = horizontal_size },
  vertical = { size = vertical_size },
  float = { size = 0 },
}

---@class Options
---@field dir "cwd" | "root" Directory to use for the terminal
---@field orientation "horizontal" | "vertical" | "float" Orientation of the terminal

---@param opts Options
local function display_terminal(opts)
  local count = vim.v.count1
  local display_name = "Terminal #" .. count

  require("toggleterm").toggle(
    count,
    terminal_layouts[opts.orientation].size,
    opts.dir == "root" and LazyVim.root.get() or LazyVim.root.cwd(),
    opts.orientation,
    display_name
  )
end

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = true,
    cmd = { "ToggleTerm" },
    keys = {
      {
        "<leader>t",
        "",
        desc = "terminal",
      },
      {
        "<leader>tf",
        function()
          display_terminal({ dir = "root", orientation = "float" })
        end,
        desc = "Float (root dir)",
      },
      {
        "<leader>th",
        function()
          display_terminal({ dir = "root", orientation = "horizontal" })
        end,
        desc = "Horizontal (root dir)",
      },
      {
        "<leader>tv",
        function()
          display_terminal({ dir = "root", orientation = "vertical" })
        end,
        desc = "Vertical (root dir)",
      },
      {
        "<leader>tF",
        function()
          display_terminal({ dir = "cwd", orientation = "float" })
        end,
        desc = "Float (cwd dir)",
      },
      {
        "<leader>tH",
        function()
          display_terminal({ dir = "cwd", orientation = "horizontal" })
        end,
        desc = "Horizontal (cwd dir)",
      },
      {
        "<leader>tv",
        function()
          display_terminal({ dir = "cwd", orientation = "vertical" })
        end,
        desc = "Vertical (cwd dir)",
      },
      {
        "<leader>tn",
        "<cmd>ToggleTermSetName<cr>",
        desc = "Set term name",
      },
      {
        "<leader>ts",
        "<cmd>TermSelect<cr>",
        desc = "Select term",
      },
      {
        "<Esc>",
        [[<C-\><C-n>]],
        mode = "t",
        silent = true,
        desc = "Terminal: Normal Mode",
      },
      {
        "kj",
        [[<C-\><C-n>]],
        mode = "t",
        silent = true,
        desc = "Terminal: Normal Mode",
      },
      {
        "<C-h>",
        [[<Cmd>wincmd h<CR>]],
        mode = "t",
        desc = "Move to Left Window",
      },
      {
        "<C-j>",
        [[<Cmd>wincmd j<CR>]],
        mode = "t",
        desc = "Move to Down Window",
      },
      {
        "<C-k>",
        [[<Cmd>wincmd k<CR>]],
        mode = "t",
        desc = "Move to Up Window",
      },
      {
        "<C-l>",
        [[<Cmd>wincmd l<CR>]],
        mode = "t",
        desc = "Move to Right Window",
      },
      {
        "<C-/>",
        function()
          display_terminal({ dir = "root", orientation = "horizontal" })
        end,
        desc = "Toggle Terminal (Ctrl+/)",
        mode = { "n", "t" },
        silent = true,
      },
      {
        "<C-_>",
        function()
          display_terminal({ dir = "root", orientation = "horizontal" })
        end,
        desc = "Toggle Terminal (Ctrl+_)",
        mode = { "n", "t" },
        silent = true,
      },
    },
    opts = {
      auto_scroll = true,
      close_on_exit = true,
      direction = "horizontal",
      hide_numbers = true,
      insert_mappings = true,
      open_mapping = false,
      persist_size = true,
      shade_filetypes = {},
      shade_terminals = true,
      size = function(term)
        if term.direction == "horizontal" then
          return 10
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.2
        end
      end,
      start_in_insert = true,
      terminal_mappings = true,
      float_opts = {
        border = "rounded",
        highlights = {
          border = "FloatBorder",
          background = "NormalFloat",
        },
        title_pos = "center",
        winblend = 0,
      },
    },
  },
}
