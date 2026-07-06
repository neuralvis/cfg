# Starship prompt (interactive only).
[ -d "$HOME/.starship/bin" ] && export PATH="$HOME/.starship/bin:$PATH"
command -v starship >/dev/null 2>&1 && eval "$(starship init bash)"
