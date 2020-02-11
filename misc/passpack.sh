#!/usr/bin/env bash
set -euf -o pipefail
IFS=$'\n\t'

# this is just for exploring the idea of a master password, don't use this
if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
  SALT_START="super"
  SALT_END="secret"

  printf "> "
  read -sr INPUT
  echo ""
  echo "$SALT_START$INPUT$SALT_END" | md5sum | tac | base64 | cut -c -16 | tac
fi
