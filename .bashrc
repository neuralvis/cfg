# ~/.bashrc
# Interactive bash configuration.
#
# Startup model (see also ~/.bash_env and ~/.bashrc.d/):
#   * ~/.bash_env      - fast environment (PATH, exports, lazy conda/nvm shims),
#                        sourced by EVERY shell, including non-interactive ones.
#   * ~/.bashrc        - this file: interactive-only setup via sourced modules.
#   * ~/.bashrc.d/*.sh - modular interactive config (options, aliases,
#                        functions, completion, prompt, tools).
#
# A non-interactive shell (e.g. an agent's `bash -lc "cmd"`) loads only
# ~/.bash_env and returns early below, so it starts fast and never hangs.

# Ensure environment is present even for interactive non-login shells.
[ -r "$HOME/.bash_env" ] && . "$HOME/.bash_env"

# If not running interactively, stop here (skip all interactive setup).
case $- in
  *i*) ;;
    *) return ;;
esac

# Source modular interactive configuration in order.
if [ -d "$HOME/.bashrc.d" ]; then
  for _rc in "$HOME"/.bashrc.d/*.sh; do
    [ -r "$_rc" ] && . "$_rc"
  done
  unset _rc
fi
