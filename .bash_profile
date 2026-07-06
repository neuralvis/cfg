# ~/.bash_profile
# Login-shell entry point.
#
# Load the fast environment for ALL login shells (including non-interactive
# ones such as an agent's `bash -lc "cmd"`), but only pull in the full
# interactive configuration (~/.bashrc) for interactive shells.

[ -r "$HOME/.bash_env" ] && . "$HOME/.bash_env"

case $- in
  *i*) [ -r "$HOME/.bashrc" ] && . "$HOME/.bashrc" ;;
esac
