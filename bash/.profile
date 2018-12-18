#  ____             __ _ _
# |  _ \ _ __ ___  / _(_) | ___
# | |_) | '__/ _ \| |_| | |/ _ \
# |  __/| | | (_) |  _| | |  __/
# |_|   |_|  \___/|_| |_|_|\___|
#
# runs on login


# source .bashrc
[ -f ~/.bashrc ] && source ~/.bashrc

# set PATH so it includes user's private bin if it exists
[ -d ~/bin ] && PATH="$PATH:$HOME/bin"

# lots of bins get installed to this directory
[ -d ~/.local/bin ] && PATH="$PATH:$HOME/.local/bin"

# add texlive installation to PATH
PATH="/usr/local/texlive/2018/bin/x86_64-linux:$PATH"

# to tell app to use qt5ct theme
export QT_QPA_PLATFORMTHEME="qt5ct"

# variables
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER=/usr/bin/firefox
