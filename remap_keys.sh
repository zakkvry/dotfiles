#!/bin/zsh

setxkbmap -option caps:ctrl_modifier -option grp:shifts_toggle

# Remove previously running instances
killall xcape
xcape  -e 'Caps_Lock=Escape'
