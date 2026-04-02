# Helix — Terminal Editor Guide

Helix is a modern modal terminal editor written in Rust. Unlike Neovim, it works
out of the box — built-in LSP support, tree-sitter syntax highlighting, and fuzzy
search with zero configuration required.

Your setup: **Catppuccin Mocha** theme with custom background, mouse enabled,
auto-completion, and `Ctrl+S` to save.

---

## Opening Files

```bash
hx file.py              # open a single file
hx file1.py file2.py    # open multiple files as buffers
hx .                    # open current directory as a file picker
hx +42 file.py          # open file and jump to line 42
```

From Yazi: press `Enter` on any file to open it in Helix.

---

## Modal Editing — The Core Concept

Helix has three main modes:

| Mode | Indicator | Purpose |
|------|-----------|---------|
| **Normal** | `NOR` | Navigate, select, run commands |
| **Insert** | `INS` | Type text |
| **Select** | `SEL` | Extend visual selections |

You start in **Normal mode**. Press `i` to type, `Esc` to go back to Normal.

---

## Entering Insert Mode

| Key | Where the cursor goes |
|-----|-----------------------|
| `i` | Before the current character |
| `a` | After the current character |
| `I` | Beginning of the line |
| `A` | End of the line |
| `o` | New line below, enter insert |
| `O` | New line above, enter insert |

Press **`Esc`** to return to Normal mode at any time.

---

## Navigation (Normal Mode)

### Basic Movement

| Key | Action |
|-----|--------|
| `h` `j` `k` `l` | Left / Down / Up / Right |
| `w` | Next word start |
| `b` | Previous word start |
| `e` | Next word end |
| `gg` | Go to top of file |
| `ge` | Go to bottom of file |
| `g` + number | Go to line number |

### Screen Movement

| Key | Action |
|-----|--------|
| `Ctrl+d` | Scroll down half page |
| `Ctrl+u` | Scroll up half page |
| `Ctrl+f` | Scroll down full page |
| `Ctrl+b` | Scroll up full page |
| `zz` | Center screen on cursor |

### Jumping

| Key | Action |
|-----|--------|
| `f` + char | Jump forward to character |
| `F` + char | Jump backward to character |
| `t` + char | Jump forward before character |
| `%` | Jump to matching bracket |
| `Ctrl+o` | Jump back in history |
| `Ctrl+i` | Jump forward in history |

---

## Editing (Normal Mode)

| Key | Action |
|-----|--------|
| `d` | Delete selection |
| `c` | Change selection (delete + insert) |
| `y` | Yank (copy) selection |
| `p` | Paste after |
| `P` | Paste before |
| `u` | Undo |
| `U` | Redo |
| `>` | Indent selection |
| `<` | Unindent selection |
| `~` | Swap case |
| `Ctrl+S` | Save file |

---

## Selection (Normal Mode)

Helix is **selection-first**: you select, then act on the selection.

| Key | Action |
|-----|--------|
| `v` | Enter select mode (extend selection) |
| `x` | Select entire line |
| `X` | Extend selection to whole lines |
| `%` | Select entire file |
| `mi(` | Select inside parentheses |
| `ma(` | Select around parentheses (including brackets) |
| `mib` | Select inside any bracket `()[]{}` |
| `miw` | Select inside word |
| `maw` | Select around word (includes whitespace) |

---

## Multiple Cursors

This is one of Helix's killer features.

| Key | Action |
|-----|--------|
| `C` | Add cursor on line below |
| `Alt+C` | Add cursor on line above |
| `,` | Keep only the primary cursor |
| `Alt+,` | Remove primary cursor |
| `s` | Select regex matches within selection (splits into cursors) |
| `&` | Align cursors on the same column |
| `Alt+s` | Split selection on newlines |

**Example — rename a variable:**
1. Search for the variable: `/myVar` + `Enter`
2. Press `n` to select next match, `N` for previous
3. Press `s` with a selection to split into multiple cursors on all matches
4. Type the new name — all cursors edit simultaneously

---

## Search

| Key | Action |
|-----|--------|
| `/` | Search forward |
| `?` | Search backward |
| `n` | Next match |
| `N` | Previous match |
| `*` | Search for word under cursor |

---

## File Picker & Fuzzy Search

| Key | Action |
|-----|--------|
| `Space f` | Open file picker (fuzzy search files) |
| `Space F` | Open file picker from workspace root |
| `Space b` | Open buffer picker (switch between open files) |
| `Space /` | Global search (ripgrep across all files) |
| `Space s` | Symbol picker (functions, classes in current file) |
| `Space S` | Workspace symbol picker |

**Tip:** In any picker, type to fuzzy-filter, `Enter` to open, `Esc` to cancel.

---

## Buffers (Multiple Files)

| Key | Action |
|-----|--------|
| `Space b` | Pick from open buffers |
| `gn` | Go to next buffer |
| `gp` | Go to previous buffer |
| `:bclose` | Close current buffer |
| `:w` | Save current buffer |
| `:wa` | Save all buffers |

The buffer tab bar at the top shows all open files when more than one is open.

---

## Window Splits

| Key | Action |
|-----|--------|
| `Ctrl+w v` | Split vertically (side by side) |
| `Ctrl+w s` | Split horizontally (top / bottom) |
| `Ctrl+w h/j/k/l` | Move focus between splits |
| `Ctrl+w q` | Close current split |

---

## LSP (Language Server Protocol)

LSP features activate automatically when a language server is installed.

| Key | Action |
|-----|--------|
| `Space d` | Show diagnostics for current file |
| `Space D` | Show all workspace diagnostics |
| `gd` | Go to definition |
| `gr` | Go to references |
| `gy` | Go to type definition |
| `gi` | Go to implementation |
| `K` | Show hover documentation |
| `Space a` | Code actions |
| `Space r` | Rename symbol |
| `]d` | Next diagnostic |
| `[d` | Previous diagnostic |

**Install language servers:**
```bash
# Python
pip install python-lsp-server

# JavaScript / TypeScript
npm install -g typescript-language-server typescript

# Rust
rustup component add rust-analyzer

# Check what's available
hx --health
```

---

## Command Mode

Press `:` to enter command mode:

| Command | Action |
|---------|--------|
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:q!` | Force quit without saving |
| `:wa` | Save all |
| `:set line-number relative` | Switch to relative line numbers |
| `:theme catppuccin_mocha` | Switch theme on the fly |
| `:vsplit file.py` | Open file in a vertical split |

---

## Tree-sitter Text Objects

Helix understands code structure. These work on functions, classes, parameters, etc.

| Key | Action |
|-----|--------|
| `maf` | Select around function |
| `mif` | Select inside function body |
| `mac` | Select around class |
| `mic` | Select inside class body |
| `]f` | Jump to next function |
| `[f` | Jump to previous function |

---

## Tips & Workflow

- **Helix is selection-first:** select something, then act. `d` deletes selection, `c` changes it, `y` copies it.
- **Mouse is enabled:** click to place cursor, click-drag to select, scroll to navigate.
- **Auto-completion** triggers after 50ms of idle — use `Tab` / `Shift+Tab` to navigate, `Enter` to accept.
- **Inlay hints** show type information inline — requires LSP.
- **No plugin system** (intentional) — everything is built-in or coming built-in.
- **Relative line numbers** make jumping easier: `5j` jumps 5 lines down, `12k` jumps 12 up.

---

## Configuration Files

| File | Purpose |
|------|---------|
| `~/.config/helix/config.toml` | Editor settings, theme, keybindings |
| `~/.config/helix/languages.toml` | Per-language LSP and formatter config |
| `~/.config/helix/themes/mocha_custom.toml` | Custom theme (inherits catppuccin_mocha, overrides background) |
