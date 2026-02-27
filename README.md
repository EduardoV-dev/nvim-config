# My Neovim Configuration

A modern Neovim configuration built on top of [LazyVim](https://www.lazyvim.org/), providing a fully-featured IDE experience with sensible defaults and easy customization.

## Features

- 🚀 Built on LazyVim - A Neovim setup powered by lazy.nvim
- 📦 Plugin management with lazy.nvim
- 🎨 Beautiful UI with modern colorschemes
- 🔍 Fuzzy finding with Telescope
- 🌳 File explorer with Neo-tree
- 💻 LSP support with mason.nvim
- 🔧 Auto-completion with nvim-cmp
- ⚡ Fast startup time
- 🎯 Which-key integration for discoverable keybindings

## Prerequisites

- **Neovim** >= 0.9.0 (needs to be built with LuaJIT)
- **Git** >= 2.19.0 (for partial clones support)
- **opencode** CLI (required for `opencode.nvim`)
- A **Nerd Font** (optional, but recommended)
- **lazygit** (optional, for git integration)
- **ripgrep** (optional, for telescope live grep)
- **fd** (optional, for telescope file finder)

### Installing Prerequisites

#### Ubuntu/Debian

```bash
# Install Neovim
sudo apt update
sudo apt install neovim

# Install optional dependencies
sudo apt install ripgrep fd-find
```

#### opencode CLI

This config uses `opencode.nvim`, which requires the `opencode` CLI installed on your machine.

```bash
curl -fsSL https://opencode.ai/install | bash

# verify
opencode --version
```

## Installation

1. **Backup your existing Neovim configuration** (if any):

   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   mv ~/.local/state/nvim ~/.local/state/nvim.bak
   mv ~/.cache/nvim ~/.cache/nvim.bak
   ```

2. **Clone this repository**:

   ```bash
   git clone git@github.com:EduardoV-dev/nvim-config.git ~/.config/nvim
   ```

3. **Start Neovim**:

   ```bash
   nvim
   ```

   LazyVim will automatically install and configure all plugins on first launch.

## Project Structure

```
nvim/
├── lua/                    # Lua configuration files
├── .gitignore             # Git ignore rules
├── .neoconf.json          # Neoconf settings
├── LICENSE                # License file
├── README.md              # This file
├── init.lua               # Main entry point
├── lazy-lock.json         # Plugin version lock file
├── lazyvim.json           # LazyVim configuration
└── stylua.toml           # Lua formatter configuration
```

## Configuration

### Basic Customization

LazyVim provides several ways to customize your configuration:

1. **Options**: Modify `lua/config/options.lua` to change Neovim options
2. **Keymaps**: Add custom keybindings in `lua/config/keymaps.lua`
3. **Autocmds**: Create autocommands in `lua/config/autocmds.lua`
4. **Plugins**: Add or modify plugins in `lua/plugins/`

### Adding New Plugins

Create a new file in `lua/plugins/` or add to an existing file:

```lua
return {
  {
    "plugin-author/plugin-name",
    config = function()
      -- Plugin configuration
    end,
  },
}
```

### LazyVim Extras

LazyVim comes with optional "extras" that can be enabled in `lua/config/lazy.lua`:

```lua
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "plugins" },
  },
})
```

## Key Bindings

LazyVim provides sensible default keybindings. Use `<leader>` (space by default) to discover available commands with which-key.

Some essential bindings:

- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>e` - Toggle file explorer
- `<leader>gg` - Open lazygit
- `<leader>qq` - Quit all

## Updating

### Update LazyVim

LazyVim will notify you when updates are available. Follow the changelog for breaking changes.

## Troubleshooting

### Plugin Issues

- Run `:checkhealth` to diagnose common issues
- Use `:Lazy` to manage plugins
- Check `:messages` for error details

### Performance Issues

- Run `:Lazy profile` to identify slow plugins
- Check startup time with `nvim --startuptime startup.log`

### LSP Issues

- Run `:checkhealth lsp` for LSP diagnostics
- Use `:Mason` to manage language servers

## Additional Resources

- [LazyVim Documentation](https://www.lazyvim.org/)
- [LazyVim GitHub Repository](https://github.com/LazyVim/LazyVim)
- [Neovim Documentation](https://neovim.io/doc/)
- [lazy.nvim Plugin Manager](https://github.com/folke/lazy.nvim)
