# AGENTS.md

This repository is a Neovim configuration built on LazyVim/lazy.nvim.
Most code is Lua. There is no traditional "build" output; correctness is:
- the config loads without errors
- formatting stays consistent
- behavior works when used in Neovim

## Repository Layout

- `init.lua` boots the config via `require("config.lazy")`.
- `lua/config/` core config (options, keymaps, autocmds, lazy setup).
- `lua/plugins/` plugin specs for lazy.nvim.
- `lua/plugins/overrides/` overrides for plugins brought by LazyVim/extras.
- `stylua.toml` Lua formatter configuration.
- `.neoconf.json` enables neodev + lua_ls settings.

## Cursor / Copilot Rules

None found in this repo:
- no `.cursorrules`
- no `.cursor/rules/`
- no `.github/copilot-instructions.md`

If these files appear later, treat them as higher-priority instructions.

## Commands (Build / Lint / Test)

### Quick Sanity (Config Loads)

- Start Neovim:
  - `nvim`
- Headless smoke test (startup must succeed):
  - `nvim --headless "+qa"`
- Health diagnostics (useful when debugging CI/dev env issues):
  - `nvim --headless "+checkhealth" "+qa"`

### Formatting (Lua)

This repo uses StyLua (`stylua.toml`): 2 spaces, 120 columns.

- Format everything:
  - `stylua .`
- Check formatting only:
  - `stylua --check .`

### Linting

There is no repo-level Lua linter configuration (no `selene.toml`, no `.luacheckrc`).
Linting/diagnostics are primarily via:
- `lua_ls` in Neovim
- LazyVim-integrated linting for JS/TS when applicable

In Neovim (LazyVim):
- Format current buffer/project (conform): `:Format`
- Run linters (nvim-lint; ESLint extra enabled): `:Lint`

### Plugin/Tooling Maintenance

These are Neovim commands (not shell scripts):
- `:Lazy` (plugin UI)
- `:Lazy sync` (install/update plugins)
- `:Mason` (LSP/formatter/tool installer used by LazyVim)

Optional headless (environment-dependent):
- `nvim --headless "+Lazy! sync" "+qa"`

### Tests (Single Test)

No test harness exists in this repo (no `tests/` or `spec/`). Therefore:
- there is no `test` command today
- there is no "run a single test" command today

If you add tests later, prefer Plenary+Busted (common in Neovim Lua projects):
- Run all tests in a directory:
  - `nvim --headless -c "PlenaryBustedDirectory tests/ {minimal_init='tests/minimal_init.lua'}" +qa`
- Run a single test file:
  - `nvim --headless -c "PlenaryBustedFile tests/foo_spec.lua" +qa`

Keep `tests/minimal_init.lua` minimal and deterministic.

## Code Style Guidelines (Lua)

### Formatting

- StyLua is the source of truth; do not hand-format to fight it.
- Indent with 2 spaces; avoid tabs.
- Keep lines <= 120 characters when reasonable.

### Imports / `require`

- Prefer caching requires at top-level when used more than once:
  - `local keymap = vim.keymap`
  - `local ok, mod = pcall(require, "module")`
- Avoid repeated `require(...)` calls inside hot paths.
- For optional dependencies, use `pcall` and fail gracefully.

Example:
```lua
local ok, mod = pcall(require, "some_plugin")
if not ok then
  return
end
```

### Module Shape

- Plugin specs: return a table for lazy.nvim (often `return { ... }`).
- Multi-export modules: use `local M = {}` then `return M`.

Keep plugin spec files focused:
- one conceptual area per file in `lua/plugins/`
- overrides in `lua/plugins/overrides/`

### Types / Annotations (lua_ls)

This repo already uses EmmyLua-style annotations in places; continue that style:
- `---@class`, `---@field`, `---@param`, `---@return`, `---@type`

Add annotations where table shapes are non-obvious or user-facing.

### Naming

- Locals/functions: `snake_case` (matches existing `display_terminal`, `horizontal_size`).
- Types/classes (EmmyLua): `PascalCase`.
- Constants: `UPPER_SNAKE_CASE` only for true constants.

Prefer clear names over abbreviations. Accept common Neovim abbreviations:
`buf`, `win`, `ns`, `ctx`.

### Neovim API Usage

- Prefer `vim.keymap.set` and include a `desc` for mappings.
- When removing default LazyVim mappings, use `vim.keymap.del`.
- Avoid side effects at top-level unless required (prefer plugin `config = function() ... end`).

### Error Handling

- Fail fast for unrecoverable bootstrap issues; show a clear message.
- For user-visible issues, prefer `vim.notify(...)` or `vim.api.nvim_echo(...)`.
- Avoid silent failure unless the feature is truly optional.

### Performance / Laziness

- Avoid heavy work at startup.
- Prefer lazy-loading plugins where appropriate.
- Do not introduce network calls at startup unless explicitly intended.

## Editing Practices

- Keep changes minimal and scoped; avoid unrelated refactors.
- Match existing patterns in the file you touch.
- Do not add new tooling/config files unless needed and consistent with the repo.
- Keep everything ASCII unless the file already uses non-ASCII.

## Common Places to Change Things

- Options: `lua/config/options.lua`
- Keymaps: `lua/config/keymaps.lua`
- Autocmds: `lua/config/autocmds.lua`
- LazyVim extras/plugin imports: `lua/config/lazy.lua`
- New plugins: `lua/plugins/*.lua`
- Plugin overrides: `lua/plugins/overrides/*.lua`

## What to Validate Before Shipping

- `stylua --check .`
- `nvim --headless "+qa"`
- Manual smoke: open `nvim`, ensure no startup errors, validate the change.
