# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working
with code in this repository.

## Overview

**Ceamx** is a comprehensive, production-ready Emacs configuration built for
productivity and maintained by Chris Montgomery. The configuration emphasizes:

- Modular architecture with custom libraries
- XDG Base Directory compliance
- Reproducible development environment via Nix
- Extensive keybinding system organized by prefix commands
- Modern completion and editing tools

The configuration is written in Emacs Lisp and uses the `setup.el` macro system
for declarative package configuration. Current version: ~3,167 lines in `init.el`
with 279 package setup blocks.

## Architecture

### Core Structure

```
.
├── init.el              # Main configuration (3,167 lines)
├── early-init.el        # Early initialization & performance optimization
├── lisp/                # Custom elisp libraries (13+ modules)
├── site-lisp/           # Third-party & custom packages not in archives
├── nix/                 # Nix flake infrastructure
├── graveyard/           # Legacy code (v1 literate config, archived)
├── docs/                # Documentation & reference materials
├── data/                # Static data files (JSON schemas, etc.)
└── templates/           # File templates
```

### Custom Libraries (`lisp/`)

The configuration provides modular libraries for different aspects:

| Module | Purpose |
|--------|---------|
| `ceamx-paths.el` | XDG-compliant path definitions |
| `ceamx-lib.el` | Core utilities, macros (`setq!`, `ceamx-subdirs`) |
| `ceamx-simple.el` | Simple interactive commands (scrolling, buffer management) |
| `ceamx-ui.el` | User interface & theming logic |
| `ceamx-window.el` | Window management utilities |
| `ceamx-completion.el` | Completion helpers (embark export flows) |
| `ceamx-lisp.el` | Lisp development utilities |
| `ceamx-prog.el` | Programming mode utilities |
| `ceamx-eglot.el` | LSP integration helpers |
| `ceamx-note.el` | Note-taking utilities |
| `ceamx-news.el` | News reader utilities |
| `ceamx-ai.el` | AI integration utilities |
| `ceamx-auth.el` | Authentication helpers |

### Site-Lisp Packages

Custom packages not available through package managers:

- `ceamx-focus.el` - Focus mode utilities
- `ceamx-modaled.el` - Modal editing support
- `ceamx-modeline/` - Custom modeline
- `ceamx-ref/` - Reference management
- `yijing/` - I Ching divination system
- `unpackaged.el` - Collection of useful functions

### Configuration Patterns

#### Package Management

**Dual-source approach**: Uses both `package.el` (MELPA) and Nix for packages.

- Package archives: GNU ELPA + MELPA
- Package directory: `~/.local/share/ceamx/packages/{version}/`
- Native compilation cache: `~/.local/share/ceamx/packages/{version}/eln-cache/`
- Nix integration: System packages in `/nix/store` are protected from deletion

**setup.el pattern**: All package configuration uses the `setup` macro:

```elisp
(setup (:package package-name)
  (:option var1 value1
           var2 value2)
  (:hook-into some-hook)
  (:bind "C-c k" #'some-command))
```

Common setup forms:
- `(:package name)` - Install/require package
- `(:option var val ...)` - Set package variables
- `(:hook-into hook)` - Add feature to hook
- `(:hook function)` - Add function to current hook
- `(:bind key command)` - Set keybinding
- `(:with-feature pkg (:when-loaded ...))` - Conditional config
- `(:load-after features ...)` - Lazy loading (custom macro)

#### Variable Configuration

**Use `setq!` instead of `setq`**: The custom `setq!` macro (from `ceamx-lib.el`)
triggers custom setters when present, making it compatible with `custom-set`
variables while avoiding unnecessary dependency loading like `setopt`.

```elisp
;; Good
(setq! eldoc-documentation-function #'eldoc-documentation-compose)

;; Avoid
(setq eldoc-documentation-function #'eldoc-documentation-compose)  ; misses custom setter
(setopt eldoc-documentation-function #'eldoc-documentation-compose) ; pulls in dependencies
```

#### Path Management

**XDG Base Directory compliance**: All paths use constants from `ceamx-paths.el`:

- **Data**: `ceamx-storage-dir` → `~/.local/share/ceamx/`
- **Cache**: `ceamx-cache-dir` → `~/.cache/ceamx/`
- **Config**: `user-emacs-directory` → `~/.config/emacs/`
- **Notes**: `ceamx-notes-dir` → `~/Documents/notes/`
- **Reading**: `ceamx-reading-dir` → `~/Documents/reading/`
- **Projects**: `ceamx-projects-dir` → `~/Projects/`

Always use these constants instead of hardcoded paths.

#### Keybinding Organization

Extensive prefix command system under `C-c`:

| Prefix | Purpose | Variable |
|--------|---------|----------|
| `C-c a` | Appearance | `ceamx-appearance-prefix` |
| `C-c b` | Buffers | `ceamx-buffer-prefix` |
| `C-c B` | Bookmarks | `ceamx-bookmark-prefix` |
| `C-c c` | Capture | `ceamx-capture-prefix` |
| `C-c d` | Code | `ceamx-code-prefix` |
| `C-c e` | Export | `ceamx-export-prefix` |
| `C-c f` | Files | `ceamx-file-prefix` |
| `C-c h` | History | `ceamx-history-prefix` |
| `C-c i` | Insert | `ceamx-insert-prefix` |
| `C-c k` | Cryption | `ceamx-cryption-prefix` |
| `C-c l` | Launch | `ceamx-launch-prefix` |
| `C-c n` | Notes | `ceamx-note-prefix` |
| `C-c p` | Packages | `ceamx-package-prefix` |
| `C-c r` | Replace | `ceamx-replace-prefix` |
| `C-c s` | Structural editing | `ceamx-structural-editing-prefix` |
| `C-c t` | Toggle | `ceamx-toggle-prefix` |
| `C-c w` | Workspace | `ceamx-workspace-prefix` |
| `C-c y` | Snippets | `ceamx-snippet-prefix` |

Other important bindings:
- `C-h` - Enhanced help system (helpful.el, embark)
- `M-g` - Goto commands (consult integration)
- `M-s` - Search commands (consult, grep, occur)
- `C-:` - Mode-specific REPL commands (customizable via `ceamx-repl-key`)

## Key Features & Technologies

### Completion & Navigation
- **Vertico** - Fast vertical minibuffer completion
- **Consult** - Enhanced commands (grep, buffers, imenu, etc.)
- **Embark** - Contextual actions on completion candidates
- **Corfu** - In-buffer completion popup
- **Orderless** - Flexible completion style
- **Marginalia** - Rich annotations in minibuffer

### Note-Taking & Writing
- **Org mode** - Latest version installed from GNU ELPA
- **Denote** - File-naming scheme for notes
- **Typo mode** - Smart typography for text modes
- **Jinx** - Spell checking (in specific writing modes)
- **Variable pitch fonts** - Enabled in text modes

### Development Tools
- **Eglot** - Native LSP client
- **Flymake** - Syntax checking
- **Magit** - Git porcelain
- **Project.el** - Project management
- **Aggressive indent** - Automatic indentation
- **Language support**: Nix, Rust, Fish, KDL, Typst, YAML, TOML, JSON, Markdown, and more

### AI Integration
- **Minuet** - AI completion
- **Efrit** - AI assistant integration

### Version Control
- **Magit** - Primary Git interface
- **Jujutsu** - Support for `jj` version control
- **VC mode** - Built-in version control

### UI & Appearance
- **Theme families**: Modus, Doric, Ef, or Standard themes (configurable via `ceamx-ui-theme-family`)
- **Fontaine** - Font configuration management with presets
- **Spacious padding** - Comfortable spacing
- **Nerd icons** - Icon support throughout
- **Mlscroll** - Scrollbar in modeline
- **Minions** - Minor mode menu
- **Breadcrumb** - Header line context

### Desktop Environment Integration
- **GTK/GNOME integration**: Reads system color scheme via gsettings
- **Tiling WM detection**: Special handling for Sway and similar WMs
- **Desktop session awareness**: Conditional behavior based on `$DESKTOP_SESSION`

## Development Workflow

### Project Management

**Primary developer**: Chris Montgomery (chmont@protonmail.com)

**Commit conventions**: Mix of conventional commits (`feat:`, `fix:`, `chore:`,
`refactor:`) and short descriptive messages. Scope tags use format like
`feat(ai): add efrit` or `fix(completion): tweak settings`.

**Git workflow**:
- Active development on main branch
- Frequent commits with iterative improvements
- Common commit types: configuration tweaks, package additions, keybinding changes

### Testing Changes

1. **Nix development shell**: Run `nix develop` for consistent environment
2. **Reload configuration**: `M-x eval-buffer` in `init.el` or restart Emacs
3. **Check for errors**: Watch `*Messages*` buffer
4. **Test incrementally**: Make small changes and test frequently

### Adding Packages

1. Determine installation method:
   - If available on MELPA → use `(:package name)`
   - If Nix-provided → add to `flake.nix` in `nix/` directory
   - If custom/vendored → place in `site-lisp/`

2. Add setup block in appropriate section of `init.el`:
```elisp
(setup (:package new-package)
  (:option new-package-var value)
  (:hook-into appropriate-hook)
  (:bind "C-c x k" #'new-package-command))
```

3. Follow existing patterns for similar packages
4. Add keybindings to appropriate prefix map

### Adding Custom Functions

**Location guidelines**:
- **Simple commands** (scrolling, basic editing) → `lisp/ceamx-simple.el`
- **UI/theming functions** → `lisp/ceamx-ui.el`
- **Window management** → `lisp/ceamx-window.el`
- **Completion utilities** → `lisp/ceamx-completion.el`
- **Domain-specific** → Create new module or add to existing domain module

**Function conventions**:
- Public functions: `ceamx/function-name` (forward slash)
- Private functions: `ceamx--function-name` (double dash)
- Interactive commands: Use `###autoload` and `(interactive)` spec
- Include docstrings for all public functions

### Modifying Keybindings

1. Locate the prefix command definition (around line 177-204 in `init.el`)
2. Find the keybinding setup in the "Keybindings" section (later in file)
3. Follow the prefix organization system
4. Use `(:bind ...)` within setup blocks for package-specific bindings

### Path Handling

Always reference paths through `ceamx-paths.el` constants:

```elisp
;; Good
(expand-file-name "myfile.el" ceamx-storage-dir)

;; Bad
(expand-file-name "~/.local/share/ceamx/myfile.el")
```

For dynamic version-specific subdirectories, use `ceamx-format-version-subdir`.

## Important Notes & Conventions

### Platform Support
- **Primary target**: Linux (specifically with GNOME/GTK integration)
- **Secondary support**: macOS (aarch64-darwin in flake.nix)
- **Desktop environments**: GNOME, Sway (tiling WM support)

### Performance Considerations
- Native compilation enabled (`package-native-compile t`)
- Garbage collection messages enabled for debugging (`garbage-collection-messages t`)
- ELN cache properly redirected to XDG-compliant location
- Package signature checking disabled (relies on HTTPS)

### Security Settings
- `ffap-machine-p-known` set to 'reject' (prevents network lookups)
- GnuTLS verification enabled with min prime bits 3072
- Auth sources limited to `~/.authinfo.gpg` (encrypted only)
- EPA file auto-save inhibited
- `auth-source-pass` enabled for password-store integration

### Buffer Management Patterns

Ceamx defines several categories of buffers via custom variables:

- `ceamx-repl-modes-list` - REPL buffer major modes
- `ceamx-repl-buffer-names-list` - REPL buffer name patterns
- `ceamx-help-modes-list` - Documentation buffer modes
- `ceamx-grep-modes-list` - Occur-type buffer modes
- `ceamx-message-modes-list` - Message/compilation buffer modes
- `ceamx-manual-modes-list` - Man page buffer modes

These are used by window management and buffer organization functions.

### File Organization

**Avoid creating unnecessary files**: The configuration intentionally minimizes
file creation. Use `custom.el` for Custom-generated code, but avoid creating
new config files unless essential.

**Read-only directories**: Files in `ceamx-buffer-read-only-dirs-list`
(includes `ceamx-packages-dir`) are automatically opened read-only.

### Special Modes & Hooks

**Text-mode derived prog modes**: Some programming modes sadly derive from
`text-mode` instead of `prog-mode`. Track these in `ceamx-text-mode-derived-prog-modes`
(e.g., `nxml-mode`, `yaml-mode`, `toml-ts-mode`).

**Typo mode exclusions**: Control which modes skip `typo-mode` via
`ceamx-typo-mode-excluded-modes`.

### Legacy Code

The `graveyard/` directory contains the previous v1 configuration:
- `graveyard/v1/config.org` - Original literate configuration (319KB+)
- `graveyard/v1/site-lisp/` - Old custom libraries (some moved to active `lisp/`)
- Reference only - not loaded or executed

## Common Operations

### Updating Packages
```elisp
M-x package-list-packages
U x  ; mark upgrades and execute
```

Package upgrade is protected against errors via custom error handling.

### Updating Flake Dependencies
```bash
nix flake update
git add flake.lock
git commit -m "chore: flake update"
```

### Toggling Theme
Use the appearance prefix commands (`C-c a ...`) or theme-specific toggles.

### Managing Org Agenda
- Default agenda files: `~/Documents/notes/g2d/*.org`
- Default todo file: `~/Documents/notes/g2d/todo.org`
- Configure via `ceamx-default-agenda-files` and `ceamx-default-todo-file`

### Searching Code
- `M-s g` - `consult-grep`
- `M-s r` - `consult-ripgrep`
- `M-s l` - `consult-line`
- `M-g i` - `consult-imenu`

### Window Management
Custom window management via `ceamx-window.el` utilities.

## Troubleshooting

### Package Installation Issues
If Nix-installed packages conflict with package.el, the system automatically
skips deletion of packages in `/nix/store` via the `ceamx-package-delete-skip-system-a`
advice.

### Theme Not Loading
Check `ceamx-ui-theme-family` setting and ensure theme package is installed.
For new frames, the `ceamx-ui-re-enable-frame-theme` advice re-applies themes.

### Native Compilation Warnings
Native compilation warnings are silenced via `native-comp-async-report-warnings-errors 'silent`.
Check the ELN cache location if issues persist.

### Loading Order Issues
The configuration uses a specific loading order:
1. `early-init.el` - Sets up paths, package directories
2. `ceamx-paths.el` - Defines path constants
3. `ceamx-lib.el` - Core utilities and macros
4. `ceamx-lisp.el` - Lisp utilities
5. `init.el` - Main configuration with setup blocks

If functions are undefined, check the loading order and `require` statements.

## Resources

- Setup.el: https://www.emacswiki.org/emacs/SetupEl
- Project repository: (check git remote)
- Issue tracker: See TODO.org for planned work

---

**Last Updated**: 2025-12-02 (auto-generated from codebase analysis)
