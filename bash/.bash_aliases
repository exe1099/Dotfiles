#  ______   __       __   ______   ______   ______   ______    
# /\  __ \ /\ \     /\ \ /\  __ \ /\  ___\ /\  ___\ /\  ___\   
# \ \  __ \\ \ \____\ \ \\ \  __ \\ \___  \\ \  __\ \ \___  \  
#  \ \_\ \_\\ \_____\\ \_\\ \_\ \_\\/\_____\\ \_____\\/\_____\ 
#   \/_/\/_/ \/_____/ \/_/ \/_/\/_/ \/_____/ \/_____/ \/_____/ 
#                                                                         


# use exa instead of ls; exa is modern ls
alias l='exa --group-directories-first'
alias la='exa --group-directories-first -a'
alias ll='exa --group-directories-first -l --git'
alias lla='exa --group-directories-first -l -a --git'

# use colors
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias wlan='wicd-curses'
alias ranger='python ~/Gits/ranger/ranger.py ~'
alias r='python ~/Gits/ranger/ranger.py ~'
alias sr='sudo python ~/Gits/ranger/ranger.py ~'
alias jn='conda activate main; screen -d -m jupyter notebook; exit'
alias openf='xdg-open '
alias pycharm='screen -d -m ./PyCharm/bin/pycharm.sh; exit'
alias startP='pdfpc -g ~/pCloud/LatexDocs/BA_slides/BA_slides.pdf'
alias list_devices='sudo fdisk -l | grep -A 2 Device'
alias v='nvr ~/d'

alias starwars='telnet towel.blinkenlights.nl' # watch Star Wars A New Hope in ASCII Art

alias ccat='highlight --out-format=ansi' # color cat - print file with syntax highlighting
