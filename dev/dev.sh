#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
  # Makefiles
  if [ -f "Makefile" ]; then
    if grep -q "dev:" "Makefile"; then
      make dev
    elif grep -q "watch:" "Makefile"; then
      make watch
    else
      echo "Neither 'dev' or 'watch' were tasks in the Makefile"
      exit 1
    fi
  fi

  # Cargo
  if [ -f "Cargo.toml" ]; then
    echo "$*"
    cargo watch -x "run -- $*"
    exit 0
  fi

  # JS
  if [ -f "package.json" ]; then
    if [ -f "yarn.lock" ]; then
      yarn dev
    else
      npm run dev
    fi
    exit 0
  fi

  echo "Can't figure out how to start dev mode on $(pwd)"
fi
