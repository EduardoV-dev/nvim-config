return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.icons",
    },
    ---@module "render-markdown"
    ---@type render.md.UserConfig
    opts = {
      -- Global default stays enabled; we disable per-buffer for editing buffers.
      enabled = true,
      -- Stay fully inside Neovim. True per-heading font sizing is not possible,
      -- so we lean on icon + padding + borders + strong highlights.
      preset = "none",
      heading = {
        icons = { "H1 ", "H2 ", "H3 ", "H4 ", "H5 ", "H6 " },
        position = "inline",
        width = "full",
        left_pad = 1,
        right_pad = 1,
        border = { true, true, false, false, false, false },
        border_virtual = true,
      },
      checkbox = {
        enabled = true,
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)

      local function preview_side_only()
        local ok_preview, preview = pcall(require, "render-markdown.core.preview")
        local ok_manager, manager = pcall(require, "render-markdown.core.manager")
        if not (ok_preview and ok_manager) then
          return
        end

        if vim.bo[0].buftype ~= "" then
          return
        end

        local src_buf = vim.api.nvim_get_current_buf()
        preview.open(src_buf)

        -- render-markdown's built-in preview toggles the source buffer back on
        -- when the preview is wiped. We always keep the source buffer disabled.
        vim.schedule(function()
          pcall(manager.set_buf, src_buf, false)

          local function enable_preview_buf(attempt)
            local dst_buf = preview.buffers and preview.buffers[src_buf]
            if dst_buf and vim.api.nvim_buf_is_valid(dst_buf) then
              pcall(manager.set_buf, dst_buf, true)

              vim.api.nvim_create_autocmd("BufWipeout", {
                buffer = dst_buf,
                once = true,
                callback = function()
                  pcall(manager.set_buf, src_buf, false)
                end,
              })
              return
            end

            if attempt < 5 then
              vim.defer_fn(function()
                enable_preview_buf(attempt + 1)
              end, 20)
            end
          end

          enable_preview_buf(1)
        end)
      end

      -- Buffer-local mappings to avoid leader conflicts outside markdown.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(ev)
          -- Skip preview/nofile buffers.
          if vim.bo[ev.buf].buftype ~= "" then
            return
          end

          -- Default: never render inside the editing buffer.
          do
            local ok_manager, manager = pcall(require, "render-markdown.core.manager")
            if ok_manager then
              pcall(manager.set_buf, ev.buf, false)
            end
          end

          vim.keymap.set("n", "<localleader>p", preview_side_only, {
            buffer = ev.buf,
            desc = "Markdown: Preview (side)",
          })

          vim.keymap.set("n", "<localleader>t", "<cmd>RenderMarkdown toggle<cr>", {
            buffer = ev.buf,
            desc = "Markdown: Toggle render",
          })

          vim.keymap.set("n", "<localleader>P", "<cmd>MarkdownPreviewToggle<cr>", {
            buffer = ev.buf,
            desc = "Markdown: Preview (browser)",
          })
        end,
      })

      -- If we're being loaded by FileType=markdown, that event already fired for
      -- the current buffer; apply the same setup once here.
      local cur = vim.api.nvim_get_current_buf()
      if vim.bo[cur].filetype == "markdown" and vim.bo[cur].buftype == "" then
        local ok_manager, manager = pcall(require, "render-markdown.core.manager")
        if ok_manager then
          pcall(manager.set_buf, cur, false)
        end
        vim.keymap.set("n", "<localleader>p", preview_side_only, { buffer = cur, desc = "Markdown: Preview (side)" })
        vim.keymap.set("n", "<localleader>t", "<cmd>RenderMarkdown toggle<cr>", { buffer = cur, desc = "Markdown: Toggle render" })
        vim.keymap.set("n", "<localleader>P", "<cmd>MarkdownPreviewToggle<cr>", { buffer = cur, desc = "Markdown: Preview (browser)" })
      end
    end,
  },
}
