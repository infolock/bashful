#!/bin/bash
 
function termcolors {
  T='gYw'   # The test text
 
  echo -e "\n                 40m     41m     42m     43m\
     44m     45m     46m     47m";
 
  for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
             '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
             '  36m' '1;36m' '  37m' '1;37m';
  do FG=${FGs// /}
    echo -en " $FGs \033[$FG  $T  "
    for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
      do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
    done
    echo;
  done
  echo
}
 
 
# Ubuntu Terminal
function uterm {
  resetbashrc
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] '
}
 
 
# Centos Term
function cterm {
  resetbashrc
  PS1='\[\033[02;32m\]\u@\H:\[\033[02;34m\]\w\$\[\033[00m\] '
}
 
 
##
# Custom Term
##
function customterm {
  # resetbashrc
  local BLACK="\[\033[0;30m\]"
  local RED="\[\033[0;31m\]"
  local LIGHT_RED="\[\033[1;31m\]"
  local LIGHT_GRAY="\[\033[0;37m\]"
  local LIGHT_CYAN="\[\033[1;36m\]"
 
  local temp=$(tty)
  local GRAD1=${temp:5}
  PS1="$LIGHT_CYAN(${LIGHT_RED}${GRAD1}$LIGHT_CYAN)$RED@\h\n\
$BLACK\u$LIGHT_CYAN: $LIGHT_RED\w$LIGHT_CYAN\$ $BLACK"
}
 
 
# Help with Term Switching
function termhelp {
  echo 
  echo '.: Terminal Themes :.'
  echo 'The Following Terms are available: [ cterm, customterm, uterm ]'
  echo
  echo '.: Helpful Reminder(s) :.'
  echo 'You can run the command "resetbashrc" to restart the bashrc source at any time...'
  echo 
}
 
# restart bashrc
function resetbashrc {
  source $HOME/.bashrc
}
 
 
# Startup the default terminal to be the customterm.
customterm
