# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal Neovim configuration based on LazyVim, a modern Neovim distribution. The configuration uses lazy.nvim as the plugin manager and follows the standard LazyVim structure with custom overrides.

## Code Architecture

### Configuration Loading Order

1. `init.lua` - Entry point that sets diagnostics and loads the lazy.nvim bootstrap
2. `lua/config/lazy.lua` - Bootstraps lazy.nvim and sets up plugin specifications:
   - Imports all LazyVim base plugins first
   - Then imports custom plugins from `lua/plugins/`
3. `lua/config/options.lua` - Global vim options (loaded before plugins)
4. `lua/config/keymaps.lua` - Custom keybindings (loaded on VeryLazy event)
5. `lua/config/autocmds.lua` - Custom autocommands (loaded on VeryLazy event)

### Plugin Configuration Structure

All plugins are configured in `lua/plugins/*.lua` files. Each file returns a Lua table with plugin specifications. LazyVim automatically loads all files from this directory.

**Important pattern:** When modifying LazyVim default plugins, use the `opts` function pattern:
```lua
opts = function(_, opts)
  -- Extend existing opts instead of replacing
  vim.list_extend(opts.ensure_installed, { "new_item" })
end
```

### Language Support Configuration

Language support is split across multiple files:

- **`lua/plugins/lang-extras.lua`** - Imports LazyVim language extras (TypeScript, JSON)
- **`lua/plugins/treesitter.lua`** - Treesitter parsers for syntax highlighting
  - Uses `vim.list_extend()` to add parsers to LazyVim defaults
  - Includes: tsx, typescript, twig, php, bash, html, javascript, json, lua, markdown, python, etc.
- **`lua/plugins/lsp-servers.lua`** - LSP servers managed by mason-lspconfig
  - Ensures installation of: lua_ls, intelephense (PHP), tsp_server, html, cssls, emmet_ls, jsonls, marksman, dockerls
- **`lua/plugins/mason.lua`** - Formatters and linters
  - Ensures installation of: stylua, shellcheck, shfmt, phpcbf, prettier
- **`lua/plugins/formatting.lua`** - Conform.nvim configuration for Twig files
- **`lua/plugins/filetypes.lua`** - Custom filetype detection (*.twig files)

### Custom Features

**Terminal Integration:**
- Three terminal options configured:
  1. `Ctrl+\` - Floating terminal (ToggleTerm, center of screen)
  2. `Ctrl+/` - Bottom terminal (Snacks.nvim built-in)
  3. `Space+tr` - Right-side vertical terminal (ToggleTerm, 80 columns wide)
- Exit terminal mode: `Ctrl+o`

**Session Management:**
- `auto-session` is enabled with pre-save hooks to close neo-tree
- `persistence.nvim` is disabled (see lua/plugins/persistence.lua)
- Session options configured in options.lua: `buffers,curdir,localoptions,tabpages,winsize`

**AI Integration (CodeCompanion):**
- Uses Anthropic Claude API (reads from `ANTHROPIC_API_KEY` env var)
- Default model: `claude-sonnet-4-20250514`
- Keybindings under `<leader>a` prefix:
  - `<leader>ai` - Toggle Claude chat
  - `<leader>ac` - Inline assistant
  - `<leader>ax` - Quick actions
  - `<leader>aa` - Add selection to chat (visual mode)

## Common Commands

### Plugin Management
```bash
# Sync plugins (install/update/clean)
:Lazy sync

# Check plugin status
:Lazy

# Update specific plugin
:Lazy update <plugin-name>
```

### LSP and Tools Management
```bash
# Open Mason UI to manage LSP servers, formatters, linters
:Mason

# Install LSP server
:MasonInstall <server-name>

# Update all Mason packages
:MasonUpdate
```

### Diagnostics and Testing
```bash
# Check Neovim health (useful for troubleshooting)
:checkhealth

# Check LazyVim configuration
:LazyHealth

# View LSP info for current buffer
:LspInfo

# View Treesitter info
:TSInstallInfo
```

## Key Architectural Decisions

1. **LazyVim Order Check Disabled**: `vim.g.lazyvim_check_order = false` in init.lua to avoid import order warnings

2. **Session Management**: Auto-session configured with pre_save_cmds that uses Lua API to safely close neo-tree before saving sessions, preventing E474 errors

3. **Dual Completion System**: Both blink.cmp (LazyVim default) and nvim-cmp are available, but nvim-cmp is disabled (enable = false in cmp.lua)

4. **Performance Optimizations**: Several built-in Vim plugins are disabled in lazy.lua performance section (gzip, tarPlugin, tohtml, tutor, zipPlugin)

5. **Ukrainian Language Support**: Comments and cheatsheet are in Ukrainian, but code and configuration keys are in English

## Environment Requirements

- **ANTHROPIC_API_KEY**: Required environment variable for CodeCompanion.nvim (Claude AI integration)
- **Git**: Required for lazy.nvim plugin management
- **Node.js**: Required for several LSP servers (typescript, html, css, json)
- **PHP**: Required for intelephense LSP server
- **fzf**: Required for fzf-lua picker (version >= 0.53.0, recommended 0.67.0+)
  - Installed to: `~/.local/bin/fzf`
  - System version (apt) is outdated, using manual installation
  - PATH configured in `~/.bashrc` to prioritize `~/.local/bin`

## Recent Optimizations (LazyVim 14.x - 2025)

### Performance Improvements
- **Lazy Loading**: Enabled `lazy = true` in defaults for faster Neovim startup
- **Exception**: auto-session has `lazy = false` to ensure session restoration works correctly

### Picker Migration
- **Switched from Telescope to fzf-lua** (LazyVim 14.x default, better performance)
- Telescope disabled via `enabled = false` in lua/plugins/fzf.lua
- `vim.g.lazyvim_picker = "fzf"` set in options.lua
- Integration with Trouble.nvim: Press `Ctrl+t` in fzf to open results in Trouble

### Key Bindings
- `<leader>ff` - Find files (fzf-lua)
- `<leader>fg` - Grep text (fzf-lua)
- `<leader>fb` - Open buffers (fzf-lua)
- `<leader>ch` - Personal cheatsheet (custom)
