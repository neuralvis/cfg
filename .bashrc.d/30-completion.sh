# Shell completion (interactive only; can be slow to source).

if [ "$(uname)" = "Darwin" ]; then
  _brew_prefix="${HOMEBREW_PREFIX:-/opt/homebrew}"
  [ -r "$_brew_prefix/etc/profile.d/bash_completion.sh" ] && . "$_brew_prefix/etc/profile.d/bash_completion.sh"
  [ -f "$_brew_prefix/etc/bash_completion.d/git-completion.bash" ] && . "$_brew_prefix/etc/bash_completion.d/git-completion.bash"
  unset _brew_prefix
fi

if [ "$(uname)" = "Linux" ]; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# nvm bash completion (nvm itself is lazy-loaded from ~/.bash_env).
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# System-wide bashrc, if present and not in POSIX mode.
if [ -f /etc/bashrc ] && ! shopt -oq posix; then
  . /etc/bashrc
fi
