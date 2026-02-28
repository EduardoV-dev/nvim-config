return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    -- This plugin ships a small node app; build it on first sync/update.
    -- (Calling mkdp#util#install() from here is unreliable because the VimL
    -- autoload functions may not be on runtimepath during lazy build.)
    build = "cd app && npm install && npm run build",
    init = function()
      -- Manual control; we map a buffer-local toggle for markdown.
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ""
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_page_title = "${name}"
    end,
  },
}
