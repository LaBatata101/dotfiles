#!/usr/bin/env sh

killall -q polybar

while pgrep -x polybar >/dev/null; do sleep 1; done

polybar -c $HOME/.config/polybar/config1 top &
#polybar example &
