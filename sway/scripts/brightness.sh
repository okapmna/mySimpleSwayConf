#!/bin/bash

ACTION=$1
STEP=5

if [ "$ACTION" == "up" ]; then
    brightnessctl set +${STEP}%
elif [ "$ACTION" == "down" ]; then
    brightnessctl set ${STEP}%-
fi

BRIGHTNESS=$(brightnessctl -m | awk -F, '{print $4}' | tr -d '%')
dunstify "Brightness" -h int:value:"$BRIGHTNESS" -r 2593 -i display-brightness-high-symbolic
