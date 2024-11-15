#  ______   __       __   ______   ______   ______   ______
# /\  __ \ /\ \     /\ \ /\  __ \ /\  ___\ /\  ___\ /\  ___\
# \ \  __ \\ \ \____\ \ \\ \  __ \\ \___  \\ \  __\ \ \___  \
#  \ \_\ \_\\ \_____\\ \_\\ \_\ \_\\/\_____\\ \_____\\/\_____\
#   \/_/\/_/ \/_____/ \/_/ \/_/\/_/ \/_____/ \/_____/ \/_____/
#


# use exa instead of ls; exa is modern ls
alias ls='exa --group-directories-first'
alias l='exa --group-directories-first -l --git'
alias la='exa --group-directories-first -la --git'
# alias ll='exa --group-directories-first -l --git'
# alias lla='exa --group-directories-first -l -a --git'

# use colors
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# programming
alias jn='conda activate main; screen -d -m jupyter-lab; exit'
alias main='conda activate main'

# utility
alias sizes="du -had 1"
alias cpu='auto-cpufreq --stats'
alias openf='xdg-open '
alias root='root -l'
alias sr='sudo ranger'
alias vim='nvim'

# fzf - fuzzyfind
alias ff="fzf -i +m --border=none | xargs -r xdg-open"
# Install pkgs using fzf
function fin() {
	pacman -Slq | fzf -q "$1" -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S
}
function fyin() {
    yay -Slq | fzf -q "$1" -m --preview 'yay -Si {1}'| xargs -ro yay -S
}
# Uninstall pkgs using fzf
function fre() {
	pacman -Qq | fzf -q "$1" -m  --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns
}

# trash
alias rm='echo "Are you sure? Use tp (trash-put) <file> or escape with \\\rm <file>."; false'
alias tp='trash-put'

# Raspberry Pi & Servers
alias exe-pi-home='ssh pi@pi-home'
alias exe-pi-ha='ssh exe@192.168.178.48'
alias exe-server='ssh exe@162.55.210.221'

# alias pi-lab-uni='ssh pi@pi-lab-uni'
# alias pi-office-uni='ssh pi@pi-office-uni'

# stuff
alias wine-ltspice='wine ~/.wine/drive_c/Program\ Files/LTC/LTspiceXVII/XVIIx64.exe'

# unused stuff
