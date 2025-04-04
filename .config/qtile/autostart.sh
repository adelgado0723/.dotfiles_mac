#!/usr/bin/env bash 
#
# function run {
#   if ! pgrep -x $(basename $1 | head -c 15) 1>/dev/null;
#   then
#     $@&
#   fi
# }

nm-applet &
blueman-applet &
radiotray-ng &
xfce4-power-manager &


# MPD daemon start (if no other user instance exists)
# [ ! -s ~/.config/mpd/pid ] && mpd

# run xfce4-power-manager & -- using qtile battery icon
numlockx on &
picom --config $HOME/.config/qtile/scripts/picom.conf &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
#/usr/lib/xfce4/notifyd/xfce4-notifyd &

# allows for setting scroll speed
imwheel -b "4 5" &

# makes lock service hook into suspend work... idk why
xhost + local:

# Set Random Wallpaper on start
setRandomWallpaper

# faster key repeat
xset r rate 200 25

# Remap Caps Lock and Esc
setxkbmap -option caps:escape

# Restore sound settings
alsactl --file ~/.config/alsa/state restore

# play login sound -- remove for faster login
mpc clear
mpc add sound_effects/loginSound.wav
mpc play

# xrandr --output eDP1 --mode 1920x1080
# xrandr --output DP2 --scale 1.3x1.3
