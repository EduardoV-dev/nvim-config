-- Extra highlight links for render-markdown.nvim.
-- Neovim cannot change font sizes per heading; this makes headings visually stronger.

local group = vim.api.nvim_create_augroup("UserRenderMarkdownColors", { clear = true })

local function apply()
  -- Use a stable, high-contrast background across themes.
  vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { link = "Visual", default = false })
  vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { link = "Visual", default = false })
  vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { link = "Visual", default = false })
  vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { link = "Visual", default = false })
  vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { link = "Visual", default = false })
  vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { link = "Visual", default = false })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  callback = apply,
})

apply()
