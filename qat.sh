#!/bin/sh

RUNTIME="${XDG_RUNTIME_DIR:-/tmp}"
SOCK="unix:$RUNTIME/kitty-qat.sock"
QAT_CONF="$HOME/.config/kitty/qat.conf"

if kitten @ --to "$SOCK" ls >/dev/null 2>&1; then
    kitten @ --to "$SOCK" resize-os-window --action=toggle-visibility --match all
else
    # first run
    kitty --listen-on="$SOCK" --class=qat --title=qat --config "$QAT_CONF" &
    # wait for socket
    for _ in $(seq 1 30); do
        kitten @ --to "$SOCK" ls >/dev/null 2>&1 && break
        sleep 0.1
    done
fi
