---
name: audit-dotfiles
description: Audit this dotfiles repo for broken symlinks, stale editor lock files, backups, and untracked cruft. Use when the user wants to clean up or health-check the repo.
---

# Audit Dotfiles

## When to use
When the user wants to review the repo's health, find dead symlinks, or identify files that should probably be removed.

## Instructions
1. Find broken symlinks (excluding `.git` and submodule internals):
   ```bash
   find . -path ./.git -prune -o -type l ! -exec test -e {} \; -print
   ```
2. Look for editor cruft and backups:
   ```bash
   find . -path ./.git -prune -o \( -name '.#*' -o -name '*~' -o -name '*.bak' -o -name '*_backup' -o -name '*.swp' \) -print
   ```
3. Check git state for untracked or modified files:
   ```bash
   git --no-pager status
   ```
4. Categorize each finding before acting:
   - **Broken symlink** whose target is gone → removal candidate.
   - **Editor lock (`.#*`) / backup** → almost always safe to remove.
   - **Business-specific or obsolete tool config** → confirm with the user.
5. Remove tracked files with `git rm` and untracked files with `rm`. Confirm destructive removals with the user first.
6. Report a summary grouped by category (broken / junk / obsolete / keep).

## Notes
- Submodule-internal broken links (e.g. under `.emacs.d/straight/`) belong to the submodule — leave them alone.
