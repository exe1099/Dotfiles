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

alias diff='icdiff'

# programming
alias jn='conda activate main; screen -d -m jupyter notebook; exit'
alias pycharm='screen -d -m ./PyCharm/bin/pycharm.sh; exit'
alias scrape_uni='conda activate main; cd ~/Cloud/Informatik/Python/UniScraper; python uni_scraper.py'
alias connect_four='conda activate connect_four && python /home/exe/Cloud/Informatik/Python/ConnectFour/connect_four.py'
alias main='conda activate main'

# utility
alias wlan='wicd-curses'
alias ranger='python ~/Gits/ranger/ranger.py ~'
alias r='python ~/Gits/ranger/ranger.py ~'
alias sr='sudo python ~/Gits/ranger/ranger.py ~'
alias openf='xdg-open '
alias download='aria2c'
alias list_devices='sudo fdisk -l | grep -A 2 Device'
alias v='nvr ~/d'
alias ccat='highlight --out-format=ansi' # color cat - print file with syntax highlighting

# stuff
alias startP='pdfpc -g ~/pCloud/LatexDocs/BA_slides/BA_slides.pdf'
alias starwars='telnet towel.blinkenlights.nl' # watch Star Wars A New Hope in ASCII Art
alias gs='git st'
alias mount_group_drive='sudo sshfs lbinn@linux.zdv.uni-mainz.de:/uni-mainz.de/groups/08/AGBoeser/IceCube/ /media/GroupDrive/'
alias umount_group_drive='sudo fusermount -u /media/GroupDrive'
alias screens_one='~/.screenlayout/screens_one.sh'
alias screens_two='~/.screenlayout/screens_two.sh'
