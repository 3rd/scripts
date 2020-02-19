#!/usr/bin/env bash
set -euf -o pipefail
IFS=$'\n\t'

source "${BASH_SOURCE%/*}/lib.sh"

trim() {
  local var="$*"
  var="${var#"${var%%[![:space:]]*}"}"
  var="${var%"${var##*[![:space:]]}"}"
  echo -n "$var"
}

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
  if [ "$#" -ne 0 ]; then
    BRANCH=$1
    git checkout -b "$BRANCH"
  else
    BRANCH=$(trim "$(git branch --all | rg -v "^\*" | sed "s/remotes\/origin\///g" | sort | uniq | grep -v HEAD | fzf)")
    if [[ -n "$BRANCH" ]]; then
      echo "Switching to $BRANCH"
      git checkout "$BRANCH"
    fi
  fi
fi
