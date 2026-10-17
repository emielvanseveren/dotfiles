#!/bin/sh
# Idle management for sway.
#
# This lives in a script rather than inline in the sway config because sway's
# command parser splits on ';', so `exec_always pkill -x swayidle; swayidle ...`
# is read as two *sway* commands. The pkill runs, and the swayidle invocation is
# silently discarded as an unknown command, leaving no idle daemon at all.
#
# Called as: exec_always "$HOME/.config/sway/scripts/idle.sh" "$Locker"

LOCKER="${1:-swaylock -f}"

# exec_always re-runs this on every config reload, so clear the previous one.
pkill -x swayidle
# Give the old instance a moment to release the idle-notify handle.
sleep 0.2

exec swayidle -w \
    timeout 300 "$LOCKER" \
    timeout 600 'swaymsg "output * power off"' \
        resume 'swaymsg "output * power on"' \
    before-sleep "$LOCKER"
