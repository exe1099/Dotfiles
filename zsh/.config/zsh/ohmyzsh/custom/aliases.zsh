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
# alias connect_four='conda activate main && python /home/exe/Cloud/Info/Python/ConnectFour/connect_four.py'
alias jn='conda activate main; export BROWSER=/usr/bin/google-chrome-stable; screen -d -m jupyter notebook; exit'
alias jn2='tmux new-session -d -s "jn" /home/exe/.config/scripts/jupyter_notebook'
# alias jnlab='conda activate lab; export BROWSER=/usr/bin/google-chrome-stable; screen -d -m jupyter lab; exit'
# alias jnroot='conda activate ROOT; export BROWSER=/usr/bin/google-chrome-stable; screen -d -m jupyter notebook; exit'
# alias jnc='export BROWSER=/usr/bin/google-chrome-stable; screen -d -m jupyter notebook; exit'
# alias jndlp='conda activate dlp; export BROWSER=/usr/bin/google-chrome-stable; screen -d -m jupyter notebook; exit'
# alias jnroot='conda activate ROOT; export BROWSER=/usr/bin/google-chrome-stable; screen -d -m jupyter notebook; exit'
# alias jtd='jt -t monokai -f hack -fs 10 -tfs 10 -nfs 115 -cursc g -T -tf fira -cellw 70%'
# alias jtl='jt -f hack -fs 10 -tfs 10 -nfs 115 -cursc g -T -tf fira -cellw 70%'
alias main='conda activate main'
# alias uni_scrape='conda activate uni_scraper && cd ~/Info/Python/UniScraper && python uni_scraper.py'

# utility
alias sizes="du -had 1"
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias ccat='highlight --out-format=ansi' # color cat - print file with syntax highlighting
alias cpu='auto-cpufreq --stats'
alias download='aria2c'
alias list_devices='sudo fdisk -l | grep -A 2 Device'
alias openf='xdg-open '
alias root='root -l'
alias sr='sudo ranger'
alias v='nvr ~/d'
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
# function fyre() {
#     yay -Qq | fzf -q "$1" -m --preview 'yay -Qi {1}' | xargs -ro yay -Rns
# }
# find installed packages sizes
# function pkgsize(){
#     pacman -Ss $@ | awk '{if(NR%2) {system("pacman -Si "$1" | grep Ins | cut -d\":\" -f 2 | tr -d \" \n\" "" "); printf " "$1"$";} else print $0}' | sort -h | tr "$" "\n"
# }

# trash
alias rm='echo "Are you sure? Use tp (trash-put) or escape with /."; false'
alias tp='trash-put'

# bluetooth
alias exe_bt_airpods='bluetoothctl connect 7C:C1:80:00:24:15'
alias exe_bt_home='bluetoothctl connect EC:81:93:E0:01:72'

# Raspberry Pi
alias exe_pi-home-meshnet='ssh pi@exe1099-altai.nord'
alias exe_pi-home='ssh pi@pi-home'
alias exe_pi-ha='ssh exe@192.168.178.48'
# alias pi-lab-uni='ssh pi@pi-lab-uni'
# alias pi-office-uni='ssh pi@pi-office-uni'

# stuff
alias starwars='telnet towel.blinkenlights.nl' # watch Star Wars A New Hope in ASCII Art
# install swh-plugins
# alias exe_audio_norm='pacmd load-module module-ladspa-sink sink_name=compressor-stereo plugin=sc4_1882 label=sc4 control=1,1.5,401,-30,20,5,17'

# unused stuff
# alias sh='sudo htop'
# alias pycharm='screen -d -m ./PyCharm/bin/pycharm.sh; exit'
# alias startP='pdfpc -g ~/pCloud/LatexDocs/BA_slides/BA_slides.pdf'
# alias pomeron='sshpass -p "vminusa19" ssh -XYv psi2019@pomeron.physi.uni-heidelberg.de'
# alias group_drive_mount='sudo sshfs lbinn@linux.zdv.uni-mainz.de:/uni-mainz.de/groups/08/AGBoeser/IceCube/ /mnt/GroupDrive/'
# alias GPU13_mount='sshfs labor@129.129.144.97:/mnt/data/PSI2019/ ~/Devices/GPU13/'
# alias GPU13_umount='sudo fusermount -u ~/Devices/GPU13'
# alias group_drive_umount='sudo fusermount -u /mnt/GroupDrive'
