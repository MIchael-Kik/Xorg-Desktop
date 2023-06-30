#!/bin/sh

# A dwm_bar function that shows the current artist, track, position, duration, and status from cmus
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Modifiyed to work with slstatus
# Michael Kik <git@MIchael-Kik>

# Dependencies: cmus

if ps -C cmus > /dev/null; then
    ARTIST=$(cmus-remote -Q | grep -a '^tag artist' | head -1 | awk '{gsub("tag artist ", "");print}')
    TRACK=$(cmus-remote -Q | grep -a '^tag title' | head -1 | awk '{gsub("tag title ", "");print}')
    POSITION=$(cmus-remote -Q | grep -a '^position' | head -1 | awk '{gsub("position ", "");print}')
    DURATION=$(cmus-remote -Q | grep -a '^duration' | head -1 | awk '{gsub("duration ", "");print}')
    STATUS=$(cmus-remote -Q | grep -a '^status' | head -1 | awk '{gsub("status ", "");print}')
    SHUFFLE=$(cmus-remote -Q | grep -a '^set shuffle' | head -1 | awk '{gsub("set shuffle ", "");print}')

    if [ "$STATUS" = "playing" ]; then
        STATUS="󰐊"
    else
        STATUS="󰏤"
    fi

    if [ "$SHUFFLE" = "tracks" ]; then
        SHUFFLE=" 󰒟"
    else
        SHUFFLE=""
    fi
    
    printf "%s %s - %s " "$STATUS" "$ARTIST" "$TRACK"
    printf "%0d:%02d/" $((POSITION%3600/60)) $((POSITION%60))
    printf "%0d:%02d" $((DURATION%3600/60)) $((DURATION%60))
    printf "%s%s | \n" "$SHUFFLE" "$SEP2"
fi
