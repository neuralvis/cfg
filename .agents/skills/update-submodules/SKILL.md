---
name: update-submodules
description: Initialize and update this repo's git submodules (.emacs.d, .ssh, warp-themes) to their tracked or latest commits. Use when submodules are missing, empty, or out of date.
---

# Update Submodules

## When to use
When submodule directories are empty after a fresh clone, or the user wants to pull the latest submodule commits.

## Instructions
1. Initialize and fetch all submodules (first-time or after clone):
   ```bash
   git submodule update --init --recursive
   ```
2. To advance submodules to the latest upstream commit on their tracked branch:
   ```bash
   git submodule update --remote --recursive
   ```
3. Review the resulting pointer changes:
   ```bash
   git --no-pager status
   git --no-pager diff --submodule
   ```
4. If the pointers advanced and the user wants to keep them, commit the superproject change (see `sync-dotfiles`).

## Submodules in this repo
- `.emacs.d` → `secunit64/prelude`
- `.ssh` → `neuralvis/ssh-config`
- `warp-themes` → `secunit64/themes`

## Notes
- To change a submodule's own contents, `cd` into it, commit, and push there first, then commit the updated pointer in the superproject.
