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

# alias diff='icdiff'  # color diff

# programming
alias connect_four='conda activate main && python /home/exe/Cloud/Info/Python/ConnectFour/connect_four.py'
alias jn='conda activate main; export BROWSER=/usr/bin/google-chrome-stable; screen -d -m jupyter notebook; exit'
alias jnlab='conda activate lab; export BROWSER=/usr/bin/google-chrome-stable; screen -d -m jupyter lab; exit'
alias jnroot='conda activate ROOT; export BROWSER=/usr/bin/google-chrome-stable; screen -d -m jupyter notebook; exit'
alias jnc='export BROWSER=/usr/bin/google-chrome-stable; screen -d -m jupyter notebook; exit'
alias jndlp='conda activate dlp; export BROWSER=/usr/bin/google-chrome-stable; screen -d -m jupyter notebook; exit'
# alias jnroot='conda activate ROOT; export BROWSER=/usr/bin/google-chrome-stable; screen -d -m jupyter notebook; exit'
alias jtd='jt -t monokai -f hack -fs 10 -tfs 10 -nfs 115 -cursc g -T -tf fira -cellw 70%'
alias jtl='jt -f hack -fs 10 -tfs 10 -nfs 115 -cursc g -T -tf fira -cellw 70%'
alias main='conda activate main'
alias uni_scrape='conda activate uni_scraper && cd ~/Info/Python/UniScraper && python uni_scraper.py'

# utility
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias ccat='highlight --out-format=ansi' # color cat - print file with syntax highlighting
alias download='aria2c'
# alias sh='sudo htop'
alias list_devices='sudo fdisk -l | grep -A 2 Device'
alias openf='xdg-open '
# alias r='python ~/Gits/ranger/ranger.py ~'
# alias ranger='python ~/Gits/ranger/ranger.py ~'
alias root='root -l'
alias sr='sudo ranger'
alias v='nvr ~/d'
alias vim='nvim'
alias wlan='wicd-curses'

# stuff
alias screens_one='~/.screenlayout/screens_one.sh'
alias screens_two='~/.screenlayout/screens_two.sh'
alias group_drive_mount='sudo sshfs lbinn@linux.zdv.uni-mainz.de:/uni-mainz.de/groups/08/AGBoeser/IceCube/ /mnt/GroupDrive/'
alias GPU13_mount='sshfs labor@129.129.144.97:/mnt/data/PSI2019/ ~/Devices/GPU13/'
alias GPU13_umount='sudo fusermount -u ~/Devices/GPU13'
alias group_drive_umount='sudo fusermount -u /mnt/GroupDrive'
alias gs='git st'
alias startP='pdfpc -g ~/pCloud/LatexDocs/BA_slides/BA_slides.pdf'
alias starwars='telnet towel.blinkenlights.nl' # watch Star Wars A New Hope in ASCII Art

# unused stuff
# alias pycharm='screen -d -m ./PyCharm/bin/pycharm.sh; exit'
