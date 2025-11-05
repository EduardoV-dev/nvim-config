return {
  "gorbit99/codewindow.nvim",
  opts = {
    auto_enable = false, -- Manual control for performance and focus
    width = 16, -- Balanced width for LazyVim's UI
    screen_bounds = "background", -- Avoids overlap with sidebars (e.g., nvim-tree)
    error_sign = LazyVim.config.icons.diagnostics.Error or "", -- Uses LazyVim's icon set for consistency
    warning_sign = LazyVim.config.icons.diagnostics.Warn or "", -- Uses LazyVim's icon set for consistency
    show_cursor = true, -- Highlights cursor for orientation
    exclude_filetypes = { "NvimTree", "TelescopePrompt", "alpha", "dashboard" }, -- Avoids minimap in sidebars/prompts
    minimap_highlight = "LazyVimMinimapSelection", -- Use a custom highlight group for better theme integration
    use_lsp = true, -- Shows diagnostics from LSP for better context
  },
  keys = {
    { "<leader>m", "", desc = "+minimap" },
    -- Create keybindings using the open_minimap, close_minimap, toggle_minimap and toggle_focus functions provided by the package
    {
      "<leader>mo",
      function()
        require("codewindow").open_minimap()
      end,
      desc = "Open Minimap",
    },
    {
      "<leader>mc",
      function()
        require("codewindow").close_minimap()
      end,
      desc = "Close Minimap",
    },
    {
      "<leader>mt",
      function()
        require("codewindow").toggle_minimap()
      end,
      desc = "Toggle Minimap",
    },
    {
      "<leader>mf",
      function()
        require("codewindow").toggle_focus()
      end,
      desc = "Focus Minimap",
    },
  },
}
