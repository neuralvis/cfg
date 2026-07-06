# Aliases (interactive only; aliases are not expanded in non-interactive shells).

if [ "$(uname)" = "Darwin" ]; then
  alias ls='ls -G'
  alias ll='ls -lG'
  alias la='ls -alG'
  alias less='less -R'
  alias fnd='open -a Finder'
  alias grp='grep -RIi'
  alias assumed="git ls-files -v | grep ^[a-z] | sed -e 's/^h\ //'"
fi

if [ "$(uname)" = "Linux" ]; then
  if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  fi
  alias ls='ls --color=auto'
  alias ll='ls -l --color=auto'
  alias la='ls -al --color=auto'
  alias less='less -R'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias apt='sudo apt-get'
  alias cs='sudo apt-cache search'
  alias pacman='sudo pacman'
  alias pac='sudo pacman'
  alias assumed="git ls-files -v | grep ^h | sed -e 's/^h\ //'"
  alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi

# emacs (emacsclient)
alias emacs="emacsclient -nw -t"
alias kill-emacs="emacsclient -e '(kill-emacs)'"

# Extra machine-local aliases.
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
