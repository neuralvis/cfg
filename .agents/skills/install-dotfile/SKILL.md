---
name: install-dotfile
description: Add a new dotfile/config to this repo, symlink it to its system location, and register it in setup.sh. Use when adding a new configuration file to the dotfiles repo.
---

# Install Dotfile

## When to use
When adding a new configuration file to this dotfiles repo so it is tracked here and symlinked to where the tool expects it (repo edits then take effect immediately).

## Instructions
1. Determine the config's source path in this repo (repo root unless a tool expects a subdirectory) and its target location under `$HOME`.
2. If the file isn't in the repo yet, move the existing config in and keep its conventional name:
   ```bash
   mv ~/.<name> ~/develop/cfg/.<name>
   ```
3. Create the symlink from the system location back to the repo copy:
   ```bash
   ln -sf ~/develop/cfg/.<name> ~/.<name>
   ```
   For configs under a subdirectory (e.g. `~/.config/...`), create the parent first with `mkdir -p`.
4. Register it in `setup.sh` so it is reproducible on a fresh machine: add an `ln -sf` line (and any needed `mkdir -p`) next to the similar entries.
5. Verify the link resolves — `ls -l ~/.<name>` should point back into the repo.
6. Stage the new file and the `setup.sh` change, then commit (see the `sync-dotfiles` skill).

## Notes
- Match the existing `setup.sh` style: `ln -sf ~/develop/cfg/<src> <target>`.
- Do not symlink secrets; use `.env.example` templates instead (see the `manage-ssh-config` skill).
