#!/usr/bin/env bash
set -euf -o pipefail
IFS=$'\n\t'

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
  if [ "$#" -ne 2 ]; then
    echo "avi2gif source.mp4 destination.gif"
    exit 1
  fi
  ffmpeg -i "$1" -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=6 > "$2"
fi
