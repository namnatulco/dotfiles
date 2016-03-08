#!/bin/sh
#note; for some reason this cannot be done in one command (for xrandr 1.4.3/1.4)
#disable all but large monitor
xrandr --output VIRTUAL1 --off --output DP3 --mode 2560x1440 --pos 0x0 --rotate normal --output DP2 --off --output DP1 --off --output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output LVDS1 --off --output VGA1 --off
#enable laptop screen in correct resolution
xrandr --output VIRTUAL1 --off --output DP3 --off --output DP2 --off --output DP1 --off --output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output LVDS1 --mode 1366x768 --pos 0x0 --rotate normal --output VGA1 --off
#add nodeadkeys option to keyboard settings
setxkbmap -layout us -variant altgr-intl -option nodeadkeys
