# Source global definitions - remove this if using on a mac ( or update accordingly )
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi
 
# Path to where the scripts being included below live.  Update this to reflect your own paths..
# In this example, we will assume there is a tools folder in your $HOME folder...
# Note that you'll also want to either define HOME, or update it to be full path if $HOME doesn't already exist in your ENV...
TOOLS_PATH=$HOME/tools
 
# Force vi to be vim
alias vi='/usr/bin/vim'
 
# Helper to just do a yum update on the remi repo ( CentOS only - Assumes you have the remi repo added to yum)
alias yumremi='/usr/bin/yum --enablerepo=remi update';
 
##
# Tar/unTar Shortcut (creates a tar.gz file.  
# Ex:   minitar example.tar.gz /path/to/folder
# Ex:   miniuntar example.tar.gz
##
alias minitar='tar cvpzf'
alias miniuntar='tar -xvpzf'

function ulist {
  sudo awk -F":" '{ print "username: " $1 "\t\tuid:" $3 }' /etc/passwd
}


##
# OS Distribution and Version Information
# Update this to match your package manager ( i.e., rpm, yum, apt, etc. )
#
##
alias distro='cat /etc/*-release'
alias kernelver='uname -a'
alias kernelgccver='cat /proc/version'

alias pkglist='yum list installed'



shopt -s checkwinsize
 
###  FILE SYSTEM
source $TOOLS_PATH/filesystem.sh
 
### TERMINALS
source $TOOLS_PATH/terms.sh
 
### IPTABLES
source $TOOLS_PATH/iptables.sh
