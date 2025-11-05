return {
  {
    "nvim-mini/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },
  {
    "HakonHarnes/img-clip.nvim", -- Share images with the chat buffer
    event = "VeryLazy",
    cmd = "PasteImage",
    opts = {
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
    keys = {
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from clipboard" },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "codecompanion" },
    config = function()
      require("render-markdown").setup({
        filetypes = { "codecompanion" },
        render_modes = true,
      })
    end,
    keys = {
      { "<leader>r", "", desc = "Markdown" },
      { "<leader>rt", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Render Markdown" },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
      { "nvim-lua/plenary.nvim", branch = "master" },
      "j-hui/fidget.nvim", -- Display status
      "ravitemer/codecompanion-history.nvim", -- Save and load conversation history
      {
        "ravitemer/mcphub.nvim", -- Manage MCP servers
        cmd = "MCPHub",
        build = "npm install -g mcp-hub@latest",
        config = true,
      },
    },
    opts = {
      extensions = {
        history = {
          enabled = true,
          opts = {
            keymap = "gh",
            save_chat_keymap = "sc",
            auto_save = true,
            auto_generate_title = true,
            continue_last_chat = true,
            delete_on_clearing_chat = true,
            picker = "snacks",
            enable_logging = false,
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
          },
        },
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
      },
      strategies = {
        agent = { adapter = "copilot" },
        inline = { adapter = "copilot" },
        cmd = { adapter = "copilot" },
        chat = {
          adapter = {
            name = "copilot",
            model = "gpt-5",
          },
          keymaps = {
            send = {
              callback = function(chat)
                vim.cmd("stopinsert")
                chat:submit()
                chat:add_buf_message({ role = "llm", content = "" })
              end,
              index = 1,
              description = "Send",
            },
            close = {
              modes = { n = "q" },
            },
          },
          roles = {
            user = "Me 🧑",
            llm = function(adapter)
              return "Assistant 🤖 (" .. adapter.formatted_name .. " | " .. adapter.model.name .. ")"
            end,
          },
        },
      },
      display = {
        chat = {
          window = {
            layout = "vertical",
          },
        },
      },
      opts = {
        log_level = "DEBUG",
      },
      -- prompt_library = PROMPTS.PROMPT_LIBRARY,
    },
    keys = {
      {
        "<leader>a",
        "",
        desc = "+ai",
        mode = { "n", "v" },
      },
      {
        "<leader>ah",
        "<cmd>CodeCompanionHistory<cr>",
        desc = "Open chat history",
        mode = { "n", "v" },
      },
      {
        "<leader>aa",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "Toggle chat window",
        mode = "n",
        "v",
      },
      {
        "<leader>ai",
        "<cmd>CodeCompanion<cr>",
        desc = "Use inline assistant",
        mode = { "n", "v" },
      },
      { "<leader>am", "<cmd>MCPHub<cr>", desc = "Open MCP Hub" },
      { "<leader>an", "<cmd>CodeCompanionChat<cr>", desc = "Create new chat window" },
      {
        "<leader>ap",
        "<cmd>CodeCompanionActions<cr>",
        desc = "Open the action palette",
        mode = { "n", "v" },
      },
      { "<leader>ax", "<cmd>CodeCompanion<cr>", desc = "Generate a command in the command-line" },
    },
    init = function()
      vim.cmd([[cab cc CodeCompanion]]) -- Expand 'cc' into 'CodeCompanion' in the command line
      require("plugins.codecompanion.progress-updates"):init()
      require("plugins.codecompanion.inline-spinner"):init()
    end,
  },
}
