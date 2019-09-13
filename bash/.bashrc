#  _               _
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|
#


shopt -s autocd # allows you to cd in directory without typing cd

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# history length
HISTSIZE=10000
HISTFILESIZE=20000

# minimalistic command prompt with color
export PS1="\[\033[01;34m\]\w\[\033[00m\]\$ "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# source bash aliases
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# added by Miniconda3 installer
. ~/miniconda3/etc/profile.d/conda.sh

# fuzzyfind in bash
#. /usr/share/fzf/key-bindings.bash
#. /usr/share/fzf/completion.bash

# st doesn't seem to set this properly
# TERM=st-256color
