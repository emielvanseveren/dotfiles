#!/bin/sh
# Toggle "keep awake" (no idle lock / screen-off) for the focused window.
# sway has no `inhibit_idle toggle`, so read the current state from the tree:
# idle_inhibitors.user is "none" or the mode we set ("open").
# Bound to $mod+i in the sway config.

state=$(swaymsg -t get_tree | python3 -c '
import json, sys
def focused(n):
    if n.get("focused"):
        return n
    for c in n.get("nodes", []) + n.get("floating_nodes", []):
        f = focused(c)
        if f:
            return f
print(focused(json.load(sys.stdin)).get("idle_inhibitors", {}).get("user", "none"))
')

if [ "$state" = "none" ]; then
    swaymsg '[con_id=__focused__] inhibit_idle open'
    notify-send -t 2000 "Keep awake: on"
else
    swaymsg '[con_id=__focused__] inhibit_idle none'
    notify-send -t 2000 "Keep awake: off"
fi
