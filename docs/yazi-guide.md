# Yazi — Terminal File Manager Guide

Yazi is a blazing-fast terminal file manager written in Rust. It features async I/O,
image previews, fuzzy search, and deep shell integration.

---

## Installation

```bash
brew install yazi ffmpegthumbnailer unar jq poppler fd ripgrep fzf zoxide imagemagick
```

For full image preview support in Kitty/Ghostty, no extra setup is needed — Yazi detects it automatically.

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

The three-pane layout (ratio `0:1:7` in your config) hides the parent pane and
gives maximum space to the preview.

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
| `l` or `Enter` | Open with Helix (your configured default editor) |
| `o` | Open with a picker — choose which app to use |
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
| `D` | Permanently delete (use with care) |
| `a` | Create new file (end with `/` for directory) |
| `r` | Rename current file |
| `R` | Bulk rename selected files in your editor |

**Tip — copy files across directories:**
Select files with `Space`, press `y`, navigate to destination, press `p`.

**Tip — bulk rename:**
Select multiple files with `Space`, press `R`. Helix opens with all filenames listed.
Edit the names, save and quit — Yazi renames everything at once.

---

## Search & Filter

| Key | Action |
|-----|--------|
| `/` | Filter files in current directory (live, by name) |
| `f` | Find file by name and jump to first match |
| `F` | Find previous match |
| `s` | Search files by name using `fd` (recursive) |
| `S` | Search file content using `ripgrep` |
| `Ctrl+s` | Cancel ongoing search |

**Tip:** After `S` (ripgrep search), results open in a picker — use arrow keys and `Enter` to jump to any match.

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
| `m` | Modified time (newest first) |
| `M` | Modified time (oldest first) |
| `s` | File size (largest first) |
| `S` | File size (smallest first) |
| `n` | Name (A–Z) |
| `N` | Name (Z–A) |
| `e` | Extension |

Your config defaults to **modified time, newest first**, directories at top.

---

## Preview

Yazi automatically previews based on file type:

| File type | Preview |
|-----------|---------|
| Text / code | Syntax-highlighted via `bat` (Catppuccin Mocha theme) |
| Images | Inline image (Kitty/Ghostty protocol) |
| PDF | First page rendered as image |
| Video | Thumbnail via `ffmpegthumbnailer` |
| Archive (zip/tar) | File list |
| Directory | File tree |

Scroll the preview pane with `Alt+j` / `Alt+k`.

**Note:** Yazi's preview pane does not support horizontal scrolling.
For wide files, press `Enter` to open in Helix where you can scroll freely.

---

## Copy File Paths

| Key | Action |
|-----|--------|
| `c` → `c` | Copy full file path |
| `c` → `d` | Copy directory path |
| `c` → `f` | Copy filename |
| `c` → `n` | Copy filename without extension |

---

## Shell Commands

| Key | Action |
|-----|--------|
| `!` | Run a blocking shell command in current directory |
| `$` | Run a non-blocking shell command |
| `` ` `` | Open an interactive shell in current directory |

**Example:** Press `!` then type `chmod +x script.sh` to make a file executable without leaving Yazi.

---

## Bookmarks

| Key | Action |
|-----|--------|
| `m` + any key | Set bookmark at current directory |
| `'` + same key | Jump back to that bookmark |

**Example:** Navigate to `~/projects/myrepo`, press `m` then `p`.
Later, press `'p` from anywhere to jump back instantly.

---

## JSON Files

Yazi previews JSON with syntax highlighting. For interactive browsing:

- Press `Enter` to open in Helix
- Or from the terminal: `jl file.json` (jless — fold/unfold nodes, search, navigate)
- Or: `jcat file.json` (jq + bat — formatted and highlighted output)

---

## Quick Tips

- **Hidden files** are always visible (your config has `show_hidden = true`).
- **Exit and cd:** Always use `y` instead of `yazi` so your shell follows your navigation.
- **Image quality** is set to `80` — good balance of speed and sharpness.
- **Drag paths:** Select files, press `y`, then paste paths anywhere with middle-click.
- **Open directory in Helix:** Press `` ` `` to drop into a shell, then `hx .` to open the project.

---

## Configuration Files

| File | Purpose |
|------|---------|
| `~/.config/yazi/yazi.toml` | Layout, sorting, preview, opener settings |
| `~/.config/yazi/keymap.toml` | Custom keybindings |
| `~/.config/yazi/theme.toml` | UI colors (Catppuccin Mocha flavor) |
| `~/.config/yazi/flavors/` | Installed theme flavors |
