#!/bin/bash

for p in \
    /usr/lib/polkit-gnome-authentication-agent-1 \
    /usr/libexec/polkit-gnome-authentication-agent-1 \
    /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1; do
    if [ -x "$p" ]; then
        exec "$p"
    fi
done
