#  ____             __ _ _
# |  _ \ _ __ ___  / _(_) | ___
# | |_) | '__/ _ \| |_| | |/ _ \
# |  __/| | | (_) |  _| | |  __/
# |_|   |_|  \___/|_| |_|_|\___|
#
# runs on login


# set PATH so it includes user's private bin if it exists
[ -d ~/Bins ] && PATH="$PATH:$HOME/Bins"

# lots of bins get installed to this directory
[ -d ~/.local/bin ] && PATH="$PATH:$HOME/.local/bin"

# lattice diamond bins
[ -d /usr/local/diamond/3.11_x64/bin/lin64 ] && PATH="$PATH:/usr/local/diamond/3.11_x64/bin/lin64"

# add texlive installation to PATH
# PATH="/usr/local/texlive/2018/bin/x86_64-linux:$PATH"

# to tell qt5-styleplugins to try to imitate gtk2 theme
# set with lxappearance
export QT_QPA_PLATFORMTHEME="gtk2"

# variables
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER=/usr/bin/firefox
export SUDO_ASKPASS="$HOME/.config/scripts/askpass"
export ZDOTDIR="$HOME/.config/zsh"  # so config files don't clutter home dir
