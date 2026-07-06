# Heavier / host-specific tool setup (interactive shells).
# The conda/nvm lazy shims live in ~/.bash_env so non-interactive agent shells
# have them too; this file covers the rest.

if [ "$(uname)" = "Darwin" ]; then
  # rvm (lazy: real rvm loads on first call)
  if [ -s "$HOME/.rvm/scripts/rvm" ]; then
    rvm() { unset -f rvm; . "$HOME/.rvm/scripts/rvm"; [ -d "$HOME/.rvm/bin" ] && PATH="$PATH:$HOME/.rvm/bin"; rvm "$@"; }
  fi
  # Lmod
  [ -f /usr/local/opt/lmod/init/profile ] && . /usr/local/opt/lmod/init/profile
  # iTerm2 shell integration
  [ -e "$HOME/.iterm2_shell_integration.bash" ] && . "$HOME/.iterm2_shell_integration.bash"
fi

if [ "$(uname)" = "Linux" ]; then
  umask 002

  # Host-specific module/toolchain setup (preserved from the original .bashrc).
  _rel="$(lsb_release -sir 2>/dev/null)"
  if [ "$_rel" = $'Ubuntu\n24.04' ]; then
    echo "Detected host Ubuntu 24.04"
    [ -f /usr/share/lmod/lmod/init/profile ] && . /usr/share/lmod/lmod/init/profile
    module use /home/madsrini/Ubuntu-22.04/modulefiles
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    __conda_setup="$('/home/madsrini/Ubuntu-22.04/software/anaconda3/2024.10/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
    if [ $? -eq 0 ]; then eval "$__conda_setup"
    elif [ -f "/home/madsrini/Ubuntu-22.04/software/anaconda3/2024.10/etc/profile.d/conda.sh" ]; then . "/home/madsrini/Ubuntu-22.04/software/anaconda3/2024.10/etc/profile.d/conda.sh"
    else export PATH="/home/madsrini/Ubuntu-22.04/software/anaconda3/2024.10/bin:$PATH"; fi
    unset __conda_setup
    export PATH="/snap/bin:$PATH"
  elif [ "$_rel" = $'Ubuntu\n22.04' ]; then
    echo "Detected host Ubuntu 22.04"
    [ -f /usr/share/lmod/lmod/init/profile ] && . /usr/share/lmod/lmod/init/profile
    module use /home/madsrini/Ubuntu-22.04/modulefiles
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    __conda_setup="$('/home/madsrini/Ubuntu-22.04/software/anaconda3/2023.07/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
    if [ $? -eq 0 ]; then eval "$__conda_setup"
    elif [ -f "/home/madsrini/Ubuntu-22.04/software/anaconda3/2023.07/etc/profile.d/conda.sh" ]; then . "/home/madsrini/Ubuntu-22.04/software/anaconda3/2023.07/etc/profile.d/conda.sh"
    else export PATH="/home/madsrini/Ubuntu-22.04/software/anaconda3/2023.07/bin:$PATH"; fi
    unset __conda_setup
    export PATH="/snap/bin:$PATH"
  elif [[ "$(uname -n)" == *"hpcfund" ]]; then
    echo "Detected host $(uname -n)"
    module use /home1/madsrini/Ubuntu-22.04/modulefiles
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    __conda_setup="$('/home1/madsrini/Ubuntu-22.04/software/anaconda3/2024.10/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
    if [ $? -eq 0 ]; then eval "$__conda_setup"
    elif [ -f "/home1/madsrini/Ubuntu-22.04/software/anaconda3/2024.10/etc/profile.d/conda.sh" ]; then . "/home1/madsrini/Ubuntu-22.04/software/anaconda3/2024.10/etc/profile.d/conda.sh"
    else export PATH="/home1/madsrini/Ubuntu-22.04/software/anaconda3/2024.10/bin:$PATH"; fi
    unset __conda_setup
  fi
  unset _rel

  # per-host: bel-a100 (CUDA)
  if [ "$(uname -n)" = "bel-a100" ]; then
    export CUDA_HOME="/usr/local/cuda"
    export PATH="$CUDA_HOME/bin:$PATH"
    export LIBRARY_PATH="$CUDA_HOME/lib64:$LIBRARY_PATH"
    export LD_LIBRARY_PATH="$CUDA_HOME/lib64:$LD_LIBRARY_PATH"
    export CMAKE_LIBRARY_PATH="$CUDA_HOME/lib64:$CMAKE_LIBRARY_PATH"
    export CMAKE_INCLUDE_PATH="$CUDA_HOME/include:$CMAKE_INCLUDE_PATH"
  fi

  # per-host: bel-gfx0 (gnome-keyring unlock helper)
  if [ "$(uname -n)" = "bel-gfx0" ]; then
    unlock-keyring() { read -rsp "Password: " pass; export $(echo -n "$pass" | gnome-keyring-daemon --replace --unlock); unset pass; }
  fi
fi
