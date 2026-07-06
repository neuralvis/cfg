# Interactive shell options + history.
export HISTFILESIZE=999999
export HISTSIZE=999999
export HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
shopt -s checkwinsize
shopt -s progcomp
shopt -s autocd 2>/dev/null

# Keep history synced across concurrent shells.
export PROMPT_COMMAND="history -a; history -n;"

# 256-color terminal.
export TERM=xterm-256color
