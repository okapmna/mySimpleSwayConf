#!/bin/bash

# Argumen: up | down | mute
ACTION=$1

# Langkah perubahan (misal: 5%)
STEP=5

# ID notifikasi unik untuk volume
NOTIF_ID=2594

# Fungsi untuk mengirim notifikasi
send_notification() {
    # Cek status mute
    IS_MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

    if [ "$IS_MUTED" == "yes" ]; then
        # Gunakan ikon mute
        dunstify "Volume: Muted" -h int:value:"0" -r $NOTIF_ID -i audio-volume-muted-symbolic
    else
        # Dapatkan nilai volume saat ini
        VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep 'Volume:' | awk '{print $5}' | tr -d '%')

        # Gunakan satu ikon umum untuk semua level volume
        dunstify "Volume" -h int:value:"$VOLUME" -r $NOTIF_ID -i audio-volume-high-symbolic
    fi
}

# Eksekusi perintah berdasarkan argumen
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
