#!/usr/bin/env bash
set -euf -o pipefail
IFS=$'\n\t'

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
  if [ "$#" -ne 1 ]; then
    echom "tgshare file.ext"
  fi
  file=$(readlink -f "$1")
  telegram-desktop -sendpath "$file"
  wmctrl -x -a Telegram.TelegramDesktop
fi
