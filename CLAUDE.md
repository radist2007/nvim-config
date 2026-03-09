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
- **`lua/plugins/linting.lua`** - nvim-lint: djlint linter for Twig files
- **`lua/plugins/trouble.lua`** - trouble.nvim for LSP diagnostics/quickfix UI
- **`lua/plugins/lualine.lua`** - lualine disabled (empty spec, using LazyVim defaults)

### Custom Features

**Terminal Integration:**
- Three terminal options configured:
  1. `Ctrl+\` - Floating terminal (ToggleTerm, center of screen) — `lazy = false` so open_mapping works immediately
  2. `Ctrl+/` - Bottom terminal (Snacks.nvim built-in) - works in both normal and terminal mode
  3. `Space+tr` - Right-side vertical terminal (ToggleTerm, 80 columns wide)
- Exit terminal mode: `Ctrl+o`

**Session Management:**
- `auto-session` is enabled with pre-save hooks to close neo-tree
- `persistence.nvim` is disabled (see lua/plugins/persistence.lua)
- Session options configured in options.lua: `buffers,curdir,localoptions,tabpages,winsize`

**AI Integration (claudecode.nvim — LazyVim extra `ai.claudecode`):**
- Підключає Claude Code CLI (`~/.local/bin/claude`) до Neovim через WebSocket MCP протокол
- Enabled via `lazyvim.json` extras (note: currently has duplicate entries `"ai.claudecode"` and `"lazyvim.plugins.extras.ai.claudecode"` — keep only one)
- Keybindings під `<leader>a` префіксом (визначені LazyVim extra):
  - `<leader>ac` - Toggle Claude Code термінал
  - `<leader>af` - Focus вікно Claude
  - `<leader>ar` - Resume попередню сесію
  - `<leader>aC` - Continue сесію
  - `<leader>ab` - Додати поточний буфер до контексту
  - `<leader>as` - Надіслати виділення до Claude (visual mode)
  - `<leader>aa` - Прийняти diff
  - `<leader>ad` - Відхилити diff

## Common Commands

### Plugin Management
```
:Lazy sync          " install/update/clean
:Lazy               " check plugin status
:Lazy update <name> " update specific plugin
```

### LSP and Tools Management
```
:Mason              " manage LSP servers, formatters, linters
:MasonInstall <name>
:MasonUpdate        " update all Mason packages
```

### Diagnostics
```
:checkhealth        " check Neovim health
:LazyHealth         " check LazyVim configuration
:LspInfo            " LSP info for current buffer
:TSInstallInfo      " Treesitter parser info
```

## Key Architectural Decisions

1. **LazyVim Order Check Disabled**: `vim.g.lazyvim_check_order = false` in init.lua to avoid import order warnings

2. **Session Management**: Auto-session configured with pre_save_cmds that uses Lua API to safely close neo-tree before saving sessions, preventing E474 errors

3. **Completion System**: blink.cmp (LazyVim default) is used; nvim-cmp is not configured

4. **Performance Optimizations**: Several built-in Vim plugins are disabled in lazy.lua performance section (gzip, tarPlugin, tohtml, tutor, zipPlugin). Lazy loading defaults to `lazy = true` for all custom plugins, with exceptions: `auto-session` and `toggleterm` use `lazy = false`

5. **Ukrainian Language Support**: Comments and cheatsheet are in Ukrainian, but code and configuration keys are in English

6. **VS Code Compatibility**: Configuration includes commented-out VS Code extras import (lua/config/lazy.lua:33-34) that can be enabled for nvim integration with VS Code

## Modifying This Configuration

When adding or modifying plugins:
1. Create or edit files in `lua/plugins/` directory
2. Each file should return a Lua table with plugin specs
3. Use `opts = function(_, opts)` pattern to extend LazyVim defaults rather than replace them
4. After changes, run `:Lazy sync` to install/update plugins
5. Use `:checkhealth` to diagnose issues

When modifying language support:
- Add Treesitter parsers in `lua/plugins/treesitter.lua`
- Add LSP servers in `lua/plugins/lsp-servers.lua`
- Add formatters/linters in `lua/plugins/mason.lua`
- Configure formatters in `lua/plugins/formatting.lua`
- Add filetype detection in `lua/plugins/filetypes.lua`

## Environment Requirements

- **Claude Code CLI**: Встановлений в `~/.local/bin/claude`, потрібен для `claudecode.nvim`
- **Git**: Required for lazy.nvim plugin management
- **Node.js**: Required for several LSP servers (typescript, html, css, json)
- **PHP**: Required for intelephense LSP server
- **fzf**: Required for fzf-lua picker (version >= 0.53.0, recommended 0.67.0+)
  - Installed to: `~/.local/bin/fzf`
  - System version (apt) is outdated, using manual installation
  - PATH configured in `~/.bashrc` to prioritize `~/.local/bin`

## Picker Setup

- **Primary: fzf-lua** (better performance) — `vim.g.lazyvim_picker = "fzf"` set in `options.lua`
- **Secondary: Telescope** (better preview) — enabled simultaneously with `<leader>t` prefix

**fzf-lua (default bindings):** `<leader>ff` files, `<leader>/` or `<leader>fg` grep, `<leader>fb` buffers

**Telescope (`<leader>t` prefix):** `tf` files, `tg` grep, `tb` buffers, `ts` LSP symbols, `td` diagnostics, `th` help tags

**Other:** `<leader>ch` — personal cheatsheet popup (defined inline in `keymaps.lua`)
