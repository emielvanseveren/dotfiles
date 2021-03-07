#!/bin/sh


export DISPLAY=:0
export XAUTHORITY=/home/emiel/.Xauthority
echo 'export DBUS_SESSION_BUS_ADDRESS' >> $HOME/.dbus/Xdbus

echo $DISPLAY
echo $XAUTHORITY

touch $HOME/.dbus/Xdbus
chmod 600 $HOME/.dbus/Xdbus
env | grep DBUS_SESSION_BUS_ADDRESS > $HOME/.dbus/Xdbus
echo 'export DBUS_SESSION_BUS_ADDRESS' >> $HOME/.dbus/Xdbus

BAT_PATH=/sys/class/power_supply/BAT0
BAT_CAPACITY_PATH=$BAT_PATH/capacity
BAT_CAPACITY=$(cat $BAT_CAPACITY_PATH)

if [ "$BAT_CAPACITY" -lt 95 ];
then
  echo "test hier"
  echo "test hier hier"
  /usr/bin/notify-send "low battery!"
else
  echo "test hier ook"
  /usr/bin/notify-send "this shit aint working dude"
fi

