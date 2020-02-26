BAT_PATH=/sys/class/power_supply/BAT0

BAT_CAPACITY_PATH=$BAT_PATH/capacity
BAT_CAPACITY=$(cat $BAT_CAPACITY_PATH)

if [ $BAT_CAPACITY -lt 25 ];
then
  notify-send "low battery!"
fi

