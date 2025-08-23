#!/bin/bash

# Dapatkan volume saat ini menggunakan wpctl
volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
volume=$(echo "($volume * 100) / 1" | bc)

# Kirim notifikasi volume
notify-send -t 1000 -a 'volume' -h int:value:$volume "Volume: $volume%"

# ---

# Dapatkan kecerahan saat ini menggunakan brightnessctl
brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)

# Hitung kecerahan dalam persentase
brightness_percent=$(echo "($brightness * 100) / $max_brightness" | bc)

# Kirim notifikasi kecerahan
notify-send -t 1000 -a 'brightness' -h int:value:$brightness_percent "Kecerahan: $brightness_percent%"
