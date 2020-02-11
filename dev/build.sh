#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
  # Makefiles
  if [ -f "Makefile" ]; then
    if grep -q "build:" "Makefile"; then
      make build
    else
      make
    fi
    exit 0
  fi

  # Cargo
  if [ -f "Cargo.toml" ]; then
    cargo build --release
    exit 0
  fi

  # JS
  if [ -f "package.json" ]; then
    if [ -f "yarn.lock" ]; then
      yarn build
    else
      npm run build
    fi
    exit 0
  fi

  echo "Can't figure out how to build $(pwd)"
fi
