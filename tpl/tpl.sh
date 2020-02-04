#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

CFGDIR=~/.config/template/

# --- colors
cnorm() {
  tput sgr0
}
cred() {
  tput setaf 1
}
cgreen() {
  tput setaf 2
}
cyellow() {
  tput setaf 3
}

# ---

# finds and lists the templates (directories) in the configuration directory
template_list() {
  find $CFGDIR -maxdepth 1 ! -path $CFGDIR ! -path "$CFGDIR.git" -type d -print0 | xargs -0 -n 1 basename | sort
}

# applies a template, optionally to a different directory than CWD
# arguments:
#   $1: template name
#   $2: (optional) destination (CWD by default)
template_apply() {
  # get source and destination
  SRC=$(realpath "$CFGDIR$1")
  DEST=$(pwd)
  if [ "$#" -gt 1 ]; then
    DEST=$(realpath "$2")
  fi

  # check that source exists
  if [[ ! -f $SRC ]] && [[ ! -d $SRC ]]; then
    echo "$(cred)ERROR$(cnorm): $(cyellow)Template does not exist: $(cnorm)$SRC"
    exit 1
  fi

  # if source is a directory, and destination is cwd, modify source to /*
  if [[ -d $SRC ]] && [ "$DEST" == "$(pwd)" ]; then
    SRC="$SRC/."
  fi

  # user feedback & confirmation
  echo "$(cgreen)Source$(cnorm): $SRC"
  echo "$(cgreen)Destination$(cnorm): $DEST"
  read -p "Apply template? (y/n)" -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    cp -pvra "$SRC" "$DEST"
  fi
}

# ---

# print help information
help() {
  printf "tpl --list\ntpl name\ntpl name destination\n"
}

# check that at least one argument has been provided
if [ "$#" -lt 1 ]; then
  help
  exit 1
fi

# parse args, decide if we're listing or attempting to apply a template
arg1=$1
case "$arg1" in
  ls | --list | -list | -ls | --ls | -l | --l)
    template_list
    ;;
  *)
    template_apply "$@"
    ;;
esac
