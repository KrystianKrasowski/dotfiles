#!/usr/bin/env bash

alias ls='ls --color=auto'
alias ll='ls -la'
alias disk-usage='df --type=vfat --type=ext4 --block-size=M -T -h'
alias toner-lvl='snmpwalk -v2c -c public 192.168.0.25 .1.3.6.1.2.1.43.11.1.1.9.1.1'
alias printer-data='snmpwalk -v2c -c public 192.168.0.25 .1.3.6.1.2.1.43'
