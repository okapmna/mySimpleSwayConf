#!/bin/bash

ACTION=$1
STEP=5
NOTIF_ID=2594

send_notification() {
    IS_MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

    if [ "$IS_MUTED" == "yes" ]; then
        dunstify "Volume: Muted" -h int:value:"0" -r $NOTIF_ID -i audio-volume-muted-symbolic
    else
        VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep 'Volume:' | awk '{print $5}' | tr -d '%')
        dunstify "Volume" -h int:value:"$VOLUME" -r $NOTIF_ID -i audio-volume-high-symbolic
    fi
}

case "$ACTION" in
    up)
        pactl set-sink-volume @DEFAULT_SINK@ +${STEP}%
        send_notification
        ;;
    down)
        pactl set-sink-volume @DEFAULT_SINK@ -${STEP}%
        send_notification
        ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        send_notification
        ;;
esac
