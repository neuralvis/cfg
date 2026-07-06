# AGENTS.md

This file provides guidance to Warp (warp.dev) and other AI coding agents when working in this repository.

## Overview

Personal dotfiles/configuration repository that manages a development environment across macOS and Linux. Configuration files are installed by symlinking them from this repo to their expected system locations, so edits made here take effect immediately.

## Setup

Run the setup script to create the symlinks and install the Starship prompt:

```bash
./setup.sh
```

`setup.sh` is the source of truth for what gets linked. It currently links `.bashrc`, `.bash_profile`, `.emacs.d/`, `.ssh/config`, `.gitconfig`, `warp-themes/` → `~/.warp/themes`, `matplotlibrc`, `jupyter_notebook_config.py`, and `starship/starship.toml`. Other configs in the repo (e.g. `.zshrc`, `.tmux.conf`, `.inputrc`, `.osx`) can be linked manually when needed.

## Git submodules

Three submodules — initialize with `git submodule update --init --recursive`:

- `.emacs.d` — Prelude-based Emacs config (`secunit64/prelude`)
- `.ssh` — SSH config (`neuralvis/ssh-config`); edits here commit to that separate repository
- `warp-themes` — Warp themes (`secunit64/themes`)

## Repository layout

- **Shell**: `.bashrc`, `.zshrc`, `.bash_profile`, `.inputrc` (multi-shell, with OS detection for Linux vs macOS)
- **Editor**: `.emacs.d/` (submodule)
- **Git**: `.gitconfig` — extensive alias set (`st`, `ci`, `co`, `br`, formatted logs `ll`/`ls`/`lds`, `assume`/`unassume`)
- **Terminal multiplexer**: `.tmux.conf` (backtick prefix, vim-style navigation)
- **Prompt**: `starship/starship.toml`
- **macOS**: `.osx` system defaults
- **Themes**: `warp-themes/` (submodule), plus `iterm2/` and `terminal/`
- **Utilities** (`bin/`): `ct` (Command-T-like fuzzy file finder), `colors.sh` (terminal color reference), `base.py` (Python CLI scaffold), `dwm` (Linux dwm startup)

## Skills

Reusable agent workflows live in `.agents/skills/<name>/SKILL.md`:

- `install-dotfile` — symlink a new config into place and add the matching line to `setup.sh`
- `sync-dotfiles` — stage, commit, and push configuration changes
- `add-warp-theme` — generate a new Warp theme YAML in `warp-themes/`
- `audit-dotfiles` — find broken symlinks and stale/untracked files
- `update-submodules` — update the Emacs, SSH, and themes submodules
- `manage-ssh-config` — add or edit SSH `Host` entries and scaffold `.env.example` files

## Working conventions

- Edit files directly in the repo; symlinks make changes take effect immediately.
- To add a new config: add the file, append an `ln -sf` line to `setup.sh`, then commit.
- When committing, append `Co-Authored-By: Oz <oz-agent@warp.dev>` on a new line at the end of the commit message.
- Use `git --no-pager` for git commands (e.g. `log`, `diff`) that would otherwise open a pager.
