#!/bin/bash

quiet=0
execute=1
intf=""

while [[ $# -gt 0 ]] ; do
    case "$1" in
        -n) execute=0 ;;
        -q) quiet=1 ;;
        -h) echo "Usage: $0 [-n] [-q] [-h] [interface]"; 
            exit ;;
         *) intf="$1" ;;
    esac
     
    shift
done

if [ $(uname) == "Darwin" ]; then
    default='default'
else
    default='0\.0\.0\.0'
fi

gw=$(netstat -nr | grep "^${default} .*${intf}" | head -1 | awk '{ print $2 }')

if [ -z "$gw" ]; then
    echo "Unable to find gateway for interface ${intf}"
    exit 1
else
    cmd="ssh root@$gw -p 22"
    if [ $quiet == 0 ]; then echo $cmd; fi
    if [ $execute == 1 ]; then exec $cmd; fi
fi
