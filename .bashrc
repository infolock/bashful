# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi
 
# Path to where the scripts being included below live.  Update this to reflect your own paths..
# In this example, we will assume there is a tools folder in your $HOME folder...
TOOLS_PATH=$HOME/tools
 
# Force vi to be vim
alias vi='/usr/bin/vim'
 
# Helper to just do a yum update on the remi repo ( CentOS only - Assumes you have the remi repo added to yum)
alias yumremi='/usr/bin/yum --enablerepo=remi update';
 
shopt -s checkwinsize
 
###  FILE SYSTEM
source $TOOLS_PATH/filesystem.sh
 
### TERMINALS
source $TOOLS_PATH/terms.sh
 
### IPTABLES
source $TOOLS_PATH/iptables.sh
