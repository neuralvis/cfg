---
name: sync-dotfiles
description: Stage, commit, and push configuration changes in this dotfiles repo, including the required Oz co-author line. Use when the user wants to save or sync dotfiles changes to git.
---

# Sync Dotfiles

## When to use
When the user wants to commit and push changes they've made to their dotfiles.

## Instructions
1. Review what changed:
   ```bash
   git --no-pager status
   git --no-pager diff
   ```
2. If there are unrelated edits (e.g. a stray `.gitconfig` change), confirm with the user which to include, then stage files explicitly:
   ```bash
   git add <files>
   ```
3. Commit with a concise, descriptive message and the required co-author trailer:
   ```bash
   git commit -m "<summary>" -m "Co-Authored-By: Oz <oz-agent@warp.dev>"
   ```
4. Push to the tracked remote:
   ```bash
   git push
   ```
5. If submodules changed, commit/push inside each submodule first (see `update-submodules`), then commit the updated pointers here.

## Notes
- Never commit unless the user explicitly asked to.
- Every commit message must end with `Co-Authored-By: Oz <oz-agent@warp.dev>`.
