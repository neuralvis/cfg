# Interactive helper functions.

# --- Bashmarks (https://github.com/huyng/bashmarks) ---
touch ~/.sdirs 2>/dev/null
s()  { cat ~/.sdirs | grep -v "export DIR_$1=" > ~/.sdirs1; mv ~/.sdirs1 ~/.sdirs; echo "export DIR_$1=$PWD" >> ~/.sdirs; }
g()  { source ~/.sdirs; cd "$(eval $(echo echo $(echo \$DIR_$1)))"; }
l()  { source ~/.sdirs; env | grep "^DIR_" | cut -c5- | grep "^.*="; }
_l() { source ~/.sdirs; env | grep "^DIR_" | cut -c5- | grep "^.*=" | cut -f1 -d "="; }
_gcomp() { local curw; COMPREPLY=(); curw=${COMP_WORDS[COMP_CWORD]}; COMPREPLY=($(compgen -W '`_l`' -- $curw)); return 0; }
complete -F _gcomp g

# --- find / grep / text helpers ---
f()    { find . -type f | grep -v .svn | grep -v .git | grep -i "$1"; }
gr()   { find . -type f | grep -v .svn | grep -v .git | xargs grep -i "$1" | grep -v Binary; }
col()  { awk -v col="$1" '{print $col}'; }
skip() { local n=$(($1 + 1)); cut -d' ' -f${n}-; }
xr()   { case $1 in 1) xrandr -s 1680x1050;; 2) xrandr -s 1440x900;; 3) xrandr -s 1024x768;; esac; }

# --- emacs server helpers ---
emacs-session()      { local server_name="${1:-noname}"; emacsclient -c -nw -t -s "$server_name" .; }
kill-emacs-session() { local server_name="${1:-noname}"; emacsclient -s "$server_name" -e "(kill-emacs)"; }

# --- macOS TLS cert bundle generator (on-demand; NOT auto-run at startup) ---
setup-certs() {
  local cert_path="$HOME/.certs/all.pem"
  local cert_dir; cert_dir="$(dirname "$cert_path")"
  [ -d "$cert_dir" ] || mkdir -p "$cert_dir"
  security find-certificate -a -p /System/Library/Keychains/SystemRootCertificates.keychain > "$cert_path"
  security find-certificate -a -p /Library/Keychains/System.keychain >> "$cert_path"
  export GIT_SSL_CAINFO="$cert_path"
  export AWS_CA_BUNDLE="$cert_path"
  export NODE_EXTRA_CA_CERTS="$cert_path"
  export REQUESTS_CA_BUNDLE="$cert_path"
  npm config set -g cafile "$cert_path"
  npm config set -g strict-ssl true
  yarn config set cafile "$cert_path" -g
  yarn config set strict-ssl true -g
}
