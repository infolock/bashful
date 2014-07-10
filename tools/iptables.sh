#!/bin/bash
 
IPTABLES=/sbin/iptables
 
# Path to where the iptables backups will live.  Update this to reflect your own paths..
# In this example, we will assume there is a backups folder in your $HOME folder...
BACKUPS_PATH=$HOME/backups
 
# Change me!
MY_REMOTE_STATIC_IP="123.123.123.123"
 
 
function iptables-backup {
 
    mkdir -p $BACKUPS_PATH
 
    # Backup the existing rules...
    CURRENTTIMESTAMP=`date +%s`
    /sbin/iptables-save > $BACKUPS_PATH/iptables-safe_$CURRENTTIMESTAMP
}
 
function iptables-restore-from-backup {
  if [ $# -ne 1 ]
  then
    echo "      Usage: $0 <iptables-safe_TIMESTAMPHERE>"
    echo "       ie. $0 ssh\n"
    exit
  fi
 
    iptables-restore < $BACKUPS_PATH/$1
}
 
function iptables-blockip {
    $IPTABLES -N spamlist
    $IPTABLES -A spamlist -s $1 -j LOG --log-prefix "SPAM LIST DROP"
    $IPTABLES -A spamlist -s $1 -j DROP
    $IPTABLES -I INPUT -j spamlist
    $IPTABLES -I OUTPUT -j spamlist
    $IPTABLES -I FORWARD -j spamlist
}
 
function iptables-reset {
    # Flush
    $IPTABLES -P INPUT   ACCEPT
    $IPTABLES -P FORWARD ACCEPT
    $IPTABLES -P OUTPUT  ACCEPT
    $IPTABLES -F
    $IPTABLES -X
 
    # Accept ssh
#    $IPTABLES -A INPUT -p tcp --dport 22 -j ACCEPT
    iptables-me
 
    # Accept port 80 shit
    $IPTABLES -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT 
    $IPTABLES -A INPUT -m state --state NEW -p tcp --dport 80 -j ACCEPT
 
    # Accept port 443 shit
    $IPTABLES -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT 
    $IPTABLES -A INPUT -m state --state NEW -p tcp --dport 443 -j ACCEPT
 
    # Accept packets belonging to established and related connections
    $IPTABLES -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
 
    # Default Policies
    $IPTABLES -P INPUT DROP
    $IPTABLES -P FORWARD DROP
    $IPTABLES -P OUTPUT ACCEPT
 
    # Localhost 
    $IPTABLES -A INPUT -i lo -j ACCEPT
 
    # Accept established and related connection packets
    $IPTABLES -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
 
    # Log Remote SSH Login Attempts that are not mine...
    $IPTABLES -N LOG_AND_DROP
}
 
function iptables-me {
 
    $IPTABLES -A INPUT -i eth0 -p tcp -s $MY_REMOTE_STATIC_IP --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
    $IPTABLES -A OUTPUT -o eth0 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
}
 
# Add CloudFlare's ip ranges to the acceptance list
function iptables-cloudpages {
    $IPTABLES -I INPUT -p tcp -m multiport --dports http,https -s 204.93.240.0/24 -j ACCEPT
    $IPTABLES -I INPUT -p tcp -m multiport --dports http,https -s 204.93.177.0/24 -j ACCEPT
    $IPTABLES -I INPUT -p tcp -m multiport --dports http,https -s 199.27.128.0/21 -j ACCEPT
    $IPTABLES -I INPUT -p tcp -m multiport --dports http,https -s 173.245.48.0/20 -j ACCEPT
    $IPTABLES -I INPUT -p tcp -m multiport --dports http,https -s 103.21.244.0/22 -j ACCEPT
    $IPTABLES -I INPUT -p tcp -m multiport --dports http,https -s 103.22.200.0/22 -j ACCEPT
    $IPTABLES -I INPUT -p tcp -m multiport --dports http,https -s 103.31.4.0/22 -j ACCEPT
    $IPTABLES -I INPUT -p tcp -m multiport --dports http,https -s 141.101.64.0/18 -j ACCEPT
    $IPTABLES -I INPUT -p tcp -m multiport --dports http,https -s 108.162.192.0/18 -j ACCEPT
    $IPTABLES -I INPUT -p tcp -m multiport --dports http,https -s 190.93.240.0/20 -j ACCEPT
    $IPTABLES -I INPUT -p tcp -m multiport --dports http,https -s 188.114.96.0/20 -j ACCEPT
    $IPTABLES -I INPUT -p tcp -m multiport --dports http,https -s 197.234.240.0/22 -j ACCEPT
    $IPTABLES -I INPUT -p tcp -m multiport --dports http,https -s 198.41.128.0/17 -j ACCEPT
    $IPTABLES -I INPUT -p tcp -m multiport --dports http,https -s 162.158.0.0/15 -j ACCEPT
}
 
function iptables-icmp-rules {
    $IPTABLES -A INPUT -p icmp -j ACCEPT 
    $IPTABLES -A INPUT -j REJECT --reject-with icmp-host-prohibited 
    $IPTABLES -A FORWARD -j REJECT --reject-with icmp-host-prohibited 
}
 
function iptables-spamhaus {
    CURRENT_PWD=`pwd`
 
    # WHERE we will download drop.lasso to...
    DropList="/var/lib/drop.lasso"
 
    cd /var/lib/
    wget http://www.spamhaus.org/drop/drop.lasso
 
    if [ ! -s "$DropList" ]; then
        echo "Unable to find drop list file $DropList .  Perhaps do:" >&2
        echo "wget http://www.spamhaus.org/drop/drop.lasso -O $DropList"
        echo "exiting." >&2
        exit 1
    fi
 
    if [ ! -x /sbin/iptables ]; then
        echo "Missing iptables command line tool, exiting." >&2
        exit 1
    fi
 
    cat "$DropList" | sed -e 's/;.*//' | grep -v '^ *$' | while read OneNetBlock ; do
        /sbin/iptables -I INPUT -s "$OneNetBlock" -j DROP
        /sbin/iptables -I OUTPUT -d "$OneNetBlock" -j DROP
        /sbin/iptables -I FORWARD -s "$OneNetBlock" -j DROP
        /sbin/iptables -I FORWARD -d "$OneNetBlock" -j DROP
    done
 
    /bin/rm -f $DropList
 
   cd $CURRENT_PWD
}
 
function iptables-block-woot {
     $IPTABLES -A INPUT -p tcp -m recent --name w00tlist --update --seconds 21600 -j DROP
     $IPTABLES -N w00tchain
     $IPTABLES -A w00tchain -m recent --set --name w00tlist -p tcp -j REJECT --reject-with tcp-reset
     $IPTABLES -N w00t
     $IPTABLES -A INPUT -p tcp -j w00t
     $IPTABLES -A w00t -m recent -p tcp --syn --dport 80 --set
     $IPTABLES -A w00t -m recent -p tcp --tcp-flags PSH,SYN,ACK SYN,ACK --sport 80 --update
     $IPTABLES -A w00t -m recent -p tcp --tcp-flags PSH,SYN,ACK ACK --dport 80 --update
     $IPTABLES -A w00t -m recent -p tcp --tcp-flags PSH,ACK PSH,ACK --dport 80 --remove -m string --to 80 --algo bm --hex-string '|485454502f312e310d0a0d0a|' -j w00tchain
}
 
# This is to block people immediately that have been trying to access the server - in annoying ways.
function iptables-static-blocked-ip-list {
    # EXAMPLE
    iptables-blockip "999.999.999.999/16"
}
 
 
function iptables-save-rules {
    /sbin/service iptables save
}
 
function iptables-cron {
    iptables-backup
    iptables-reset
    iptables-icmp-rules
    iptables-spamhaus
    iptables-block-woot
    iptables-static-blocked-ip-list
    iptables-cloudpages
 
    iptables-save-rules
}
 
 
function iptables-help {
    echo 
    echo "List of Custom \"iptables-\" Commands"
    echo "-------------------------------------"
    echo "iptables-backup                   Backup the current iptables rules"
    echo "iptables-blockip                  Block an IP"
    echo "iptables-cloudpages               Add cloudpages' ip ranges to the ACCEPT rules for iptables"
    echo "iptables-cron                     Runs all the custom iptables commands for managing iptables"
    echo "iptables-help                     This help message..."
    echo "iptables-me                       ...duh."
    echo "iptables-reset                    Reset iptables back to the default rules"
    echo "iptables-restore-from-backup      Restore iptables from a previous backup"
    echo "iptables-save-rules               Save the current iptables rules"
    echo "iptables-spamhaus                 Add spamhaus DROP ip ranges to the DROP rules for iptables"
    echo 
    echo 
}
