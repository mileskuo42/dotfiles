# Yazi — Terminal File Manager Guide

Yazi is a blazing-fast terminal file manager written in Rust. It features async I/O,
image previews, fuzzy search, and deep shell integration.

---

## Installation

```bash
brew install yazi ffmpegthumbnailer unar jq poppler fd ripgrep fzf zoxide imagemagick
```

For full image preview support in Kitty, no extra setup is needed — Yazi detects it automatically.

---

## Shell Integration

The `y` function in your `.zshrc` lets Yazi **change your shell directory** on exit.
Instead of running `yazi` directly, always use:

```bash
y              # open yazi; your shell cd's to wherever you quit from
y ~/Downloads  # open yazi at a specific path
```

Without `y`, your shell stays in the original directory when you close Yazi.

---

## Interface Overview

```
┌─────────────┬───────────────────────┬──────────────────────┐
│ Parent dir  │   Current directory   │   Preview panel      │
│             │ > file.txt            │   (file content,     │
│             │   image.png           │    image, PDF, etc.) │
│             │   folder/             │                      │
└─────────────┴───────────────────────┴──────────────────────┘
```

The three-pane layout (ratio `1:3:4` in your config) shows parent, current, and preview.

---

## Navigation

| Key | Action |
|-----|--------|
| `h` | Go to parent directory |
| `l` | Enter directory / open file |
| `j` | Move down |
| `k` | Move up |
| `gg` | Jump to top |
| `G` | Jump to bottom |
| `H` | Go back in history |
| `L` | Go forward in history |
| `~` | Go to home directory |
| `-` | Go to previous directory |
| `.` | Toggle hidden files |

---

## Opening Files

| Key | Action |
|-----|--------|
| `l` or `Enter` | Open with default app |
| `o` | Open with a picker (choose app) |
| `O` | Open with a picker, stay in Yazi |

---

## Selection

| Key | Action |
|-----|--------|
| `Space` | Toggle selection on current file |
| `v` | Enter visual selection mode |
| `V` | Enter visual selection mode (unselect) |
| `Ctrl+a` | Select all files |
| `Ctrl+r` | Invert selection |
| `Esc` | Clear selection |

---

## File Operations

| Key | Action |
|-----|--------|
| `y` | Yank (copy) selected files |
| `x` | Cut selected files |
| `p` | Paste |
| `P` | Paste and overwrite |
| `d` | Move to trash |
| `D` | Permanently delete |
| `a` | Create new file (end with `/` for directory) |
| `r` | Rename current file |
| `R` | Bulk rename selected files |

**Tip:** To copy files across directories — select files with `Space`, press `y`, navigate to destination, press `p`.

---

## Search & Filter

| Key | Action |
|-----|--------|
| `/` | Filter files in current directory (live) |
| `f` | Find file by name (jumps to match) |
| `F` | Find previous match |
| `s` | Search file content with `fd` |
| `S` | Search with `rg` (ripgrep, content search) |
| `Ctrl+s` | Cancel search |

**Tip:** After a `s`/`S` search, results open in a picker — use arrow keys and `Enter` to jump.

---

## Tabs

| Key | Action |
|-----|--------|
| `t` | Open new tab |
| `1`–`9` | Switch to tab number |
| `[` | Switch to previous tab |
| `]` | Switch to next tab |
| `Ctrl+c` | Close current tab |

---

## Sorting

Press `o` to open the sort menu:

| Key | Sort by |
|-----|---------|
| `m` | Modified time |
| `M` | Modified time (reverse) |
| `s` | File size |
| `S` | File size (reverse) |
| `n` | Name |
| `N` | Name (reverse) |
| `e` | Extension |

Your config defaults to **modified time, newest first**, with directories at the top.

---

## Preview

Yazi previews are automatic based on file type:

| File type | Preview |
|-----------|---------|
| Text / code | Syntax-highlighted content |
| Images | Inline image (Kitty protocol) |
| PDF | First page as image |
| Video | Thumbnail |
| Archive (zip/tar) | File list |
| Directory | File tree |

Scroll the preview pane with `Alt+j` / `Alt+k`.

---

## Copy File Paths

| Key | Action |
|-----|--------|
| `c` then `c` | Copy file path |
| `c` then `d` | Copy directory path |
| `c` then `f` | Copy filename |
| `c` then `n` | Copy filename without extension |

---

## Shell Commands

| Key | Action |
|-----|--------|
| `!` | Run shell command (blocking) |
| `$` | Run shell command (non-blocking) |
| `` ` `` | Open interactive shell in current directory |

**Example:** Press `!` then type `chmod +x script.sh` to make a file executable without leaving Yazi.

---

## Bookmarks

| Key | Action |
|-----|--------|
| `m` + any key | Set bookmark |
| `'` + same key | Jump to bookmark |

**Example:** Press `m` then `p` to bookmark the current directory as `p`. Later press `'p` to jump back instantly.

---

## Quick Tips

- **Bulk rename:** Select multiple files with `Space`, press `R` — opens your `$EDITOR` with all filenames. Edit and save to rename.
- **Drag to terminal:** Select files, press `y` — paste the paths anywhere with middle-click.
- **Hidden files:** Your config has `show_hidden = true` by default, so dotfiles are always visible.
- **Image quality:** Set to `80` in your config — good balance of speed and quality.
- **Exit and cd:** Always use `y` (the shell function) instead of `yazi` so your working directory follows you.

---

## Configuration Files

| File | Purpose |
|------|---------|
| `~/.config/yazi/yazi.toml` | Layout, sorting, preview settings |
| `~/.config/yazi/keymap.toml` | Custom keybindings |
| `~/.config/yazi/theme.toml` | Colors and icons |
