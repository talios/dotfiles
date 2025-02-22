# Custom
source $HOME/.config/fish/talios.load

# opam configuration
source /Users/amrk/.opam/opam-init/init.fish >/dev/null 2>/dev/null; or true
set -g fish_user_paths /usr/local/sbin $fish_user_paths
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=(brew --prefix openssl@1.1)"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.fish 2>/dev/null || :
