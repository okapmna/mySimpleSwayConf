#!/bin/bash

PORTAL_WLR=""
PORTAL=""

for p in /usr/libexec/xdg-desktop-portal-wlr /usr/lib/xdg-desktop-portal-wlr; do
    if [ -x "$p" ]; then
        PORTAL_WLR="$p"
        break
    fi
done

for p in /usr/libexec/xdg-desktop-portal /usr/lib/xdg-desktop-portal; do
    if [ -x "$p" ]; then
        PORTAL="$p"
        break
    fi
done

if [ -n "$PORTAL_WLR" ]; then
    "$PORTAL_WLR" &
    sleep 1
fi

if [ -n "$PORTAL" ]; then
    "$PORTAL" &
fi
