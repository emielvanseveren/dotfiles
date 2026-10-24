#!/bin/sh
# Big swaynag bar when the battery runs low while discharging.
# Shown once per discharge, closed automatically when the charger goes in.
# UPower hybrid-sleeps at 2% (/etc/UPower/UPower.conf), this warns before that.
# Optional arg: threshold in percent (default 5).
#
# Called as: exec "$HOME/.config/sway/scripts/battery-warn.sh"

THRESHOLD="${1:-5}"
BAT=/sys/class/power_supply/BAT0
nag=

while true; do
    capacity=$(cat "$BAT/capacity")
    status=$(cat "$BAT/status")

    if [ "$status" = "Discharging" ] && [ "$capacity" -le "$THRESHOLD" ]; then
        if [ -z "$nag" ]; then
            # overlay layer so it also shows over fullscreen windows.
            # Colours: dunst critical red, waybar pill dark; dismiss is a bare close icon.
            swaynag -y overlay -f "0xProto Nerd Font 12" \
                -m "󰂃  Battery at ${capacity}%  ·  plug in the charger now" -s "󰅖" \
                --message-padding 8 --border-bottom-size 0 \
                --background fe6c5a --text 141414 --border fe6c5a \
                --button-background fe6c5a --button-text 141414 \
                --button-border-size 0 --button-padding 8 --button-margin-right 6 &
            nag=$!
        fi
    elif [ "$status" != "Discharging" ] && [ -n "$nag" ]; then
        # Only kill it if the PID is still our swaynag (not dismissed and reused).
        [ "$(cat /proc/$nag/comm 2>/dev/null)" = swaynag ] && kill "$nag"
        nag=
    fi

    sleep 30
done
