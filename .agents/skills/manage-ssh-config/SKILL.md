---
name: manage-ssh-config
description: Add or edit SSH Host entries in the .ssh submodule and scaffold .env.example templates for secrets. Use when configuring SSH hosts/keys or creating environment variable example files.
---

# Manage SSH Config & .env Examples

## When to use
When the user wants to add or edit an SSH host, key, or option, or create an `.env.example` template for a project's environment variables.

## SSH config
`.ssh/` is a git submodule (`neuralvis/ssh-config`); changes here commit to that separate repo, and `.ssh/config` is symlinked to `~/.ssh/config` by `setup.sh`.

1. Edit `.ssh/config` and add a host block in the standard format:
   ```
   Host <alias>
        HostName <hostname-or-ip>
        User <user>
        Port 22
        IdentityFile ~/.ssh/<key>
   ```
2. Keep global options (e.g. `ServerAliveInterval`) at the top of the file.
3. Never commit private keys — only the `config` file. Reference keys by path via `IdentityFile`.
4. Fix perms if needed: `chmod 644 ~/.ssh/config`.
5. Commit and push from inside `.ssh/` (it's a submodule), then update the pointer in the superproject.

## .env examples
Never commit real secrets. Create a committed template instead:

1. Create `.env.example` listing each variable with a placeholder or empty value:
   ```
   API_KEY=
   DATABASE_URL=
   ```
2. Ensure the real `.env` is gitignored (add `.env` to `.gitignore` if missing).
3. Document the required variables in the project's README or `AGENTS.md`.

## Notes
- Verify a host works with `ssh -T <alias>` (git hosts) or `ssh <alias>` before relying on it.
