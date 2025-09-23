#!/bin/bash

# Argumen: up | down
ACTION=$1

# Langkah perubahan (misal: 5%)
STEP=5

# Ubah kecerahan
if [ "$ACTION" == "up" ]; then
    brightnessctl set +${STEP}%
elif [ "$ACTION" == "down" ]; then
    brightnessctl set ${STEP}%-
fi

# Dapatkan nilai kecerahan saat ini dalam persen
BRIGHTNESS=$(brightnessctl -m | awk -F, '{print $4}' | tr -d '%')

# Kirim notifikasi dengan progress bar
dunstify "Brightness" -h int:value:"$BRIGHTNESS" -r 2593 -i display-brightness-high-symbolic
