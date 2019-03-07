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

alias diff='icdiff'  # color diff

# programming
alias connect_four='conda activate connect_four && python /home/exe/Cloud/Info/Python/ConnectFour/connect_four.py'
alias jn='conda activate main; screen -d -m jupyter notebook; exit'
alias main='conda activate main'
alias uni_scrape='conda activate uni_scraper && cd ~/Info/Python/UniScraper && python uni_scraper.py'

# utility
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias ccat='highlight --out-format=ansi' # color cat - print file with syntax highlighting
alias download='aria2c'
alias sh='sudo htop'
alias list_devices='sudo fdisk -l | grep -A 2 Device'
alias openf='xdg-open '
alias r='python ~/Gits/ranger/ranger.py ~'
alias ranger='python ~/Gits/ranger/ranger.py ~'
alias sr='sudo python ~/Gits/ranger/ranger.py ~'
alias v='nvr ~/d'
alias vim='nvim'
alias wlan='wicd-curses'

# stuff
alias screens_one='~/.screenlayout/screens_one.sh'
alias screens_two='~/.screenlayout/screens_two.sh'
alias group_drive_mount='sudo sshfs lbinn@linux.zdv.uni-mainz.de:/uni-mainz.de/groups/08/AGBoeser/IceCube/ /mnt/GroupDrive/'
alias group_drive_umount='sudo fusermount -u /mnt/GroupDrive'
alias gs='git st'
alias startP='pdfpc -g ~/pCloud/LatexDocs/BA_slides/BA_slides.pdf'
alias starwars='telnet towel.blinkenlights.nl' # watch Star Wars A New Hope in ASCII Art

# unused stuff
# alias pycharm='screen -d -m ./PyCharm/bin/pycharm.sh; exit'
