# AGENTS.md

This file provides guidance to Warp (warp.dev) and other AI coding agents when working in this repository.

## Overview

Personal dotfiles/configuration repository that manages a development environment across macOS and Linux. Configuration files are installed by symlinking them from this repo to their expected system locations, so edits made here take effect immediately.

## Setup

Run the setup script to create the symlinks and install the Starship prompt:

```bash
./setup.sh
```

`setup.sh` is the source of truth for what gets linked. It currently links:

- `.bashrc`, `.bash_profile`, `.bash_env`, and `.bashrc.d/` → `~/`
- `.emacs.d/` → `~/.emacs.d`
- `.ssh/config` → `~/.ssh/config` (and `chmod 644`s it)
- `.gitconfig` → `~/.gitconfig`
- `warp-themes/` → `~/.warp/themes`
- `matplotlibrc` → both `~/.matplotlib/matplotlibrc` and `~/.config/matplotlib/matplotlibrc`
- `jupyter_notebook_config.py` → `~/.jupyter/jupyter_notebook_config.py`
- `starship/starship.toml` → `~/.config/starship.toml`

It also installs the Starship prompt into `~/.starship/bin` via the official install script. Other configs in the repo (e.g. `.zshrc`, `.tmux.conf`, `.inputrc`) are not linked by `setup.sh` and can be linked manually when needed.

## Git submodules

Three submodules — initialize with `git submodule update --init --recursive`:

- `.emacs.d` — Prelude-based Emacs config (`secunit64/prelude`)
- `.ssh` — SSH config (`neuralvis/ssh-config`); edits here commit to that separate repository
- `warp-themes` — Warp themes (`secunit64/themes`)

## Repository layout

- **Shell**: `.bashrc`, `.zshrc`, `.bash_profile`, `.inputrc` (multi-shell, with OS detection for Linux vs macOS)
- **Editor**: `.emacs.d/` (submodule)
- **Git**: `.gitconfig` — extensive alias set (`st`, `ci`, `co`, `br`, formatted logs `ll`/`ls`/`lds`, `assume`/`unassume`)
- **Terminal multiplexer**: `.tmux.conf` (backtick prefix)
- **Prompt**: `starship/starship.toml`
- **Themes**: `warp-themes/` (submodule), plus `iterm2/` and `terminal/`
- **Utilities** (`bin/`): `ct` (Command-T-like fuzzy file finder), `colors.sh` (terminal color reference), `base.py` (Python CLI scaffold)

## Skills

Reusable agent workflows live in `.agents/skills/<name>/SKILL.md`. Claude Code
reads the same files via `.claude/skills` (a symlink → `.agents/skills`), so both
Warp/Oz and Claude Code share one set of skills:

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
