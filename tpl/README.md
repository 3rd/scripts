# tpl

This is a stupid-simple script that helps initializing projects / scratchpads,
based on templates. Templates are directories and files, stored in `~/.config/template`.

## Demo

[![asciicast](https://asciinema.org/a/WLHBaxbwqGQsVIvRZ2p5CDEHK.svg)](https://asciinema.org/a/WLHBaxbwqGQsVIvRZ2p5CDEHK)

## Usage

It's probably easier to read the source, but here you go.

```sh
# list the templates
tpl ls
tpl --ls
tpl --list
tpl -list
tpl --l
tpl -l

# apply a template to cwd
tpl template_name

# apply a template to a different path
tpl template_name destination
```

## Use with fzf

Make your own script to use **tpl** with fzf, here's a sample.

```
#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
  # get template
  TEMPLATE=$(/change/this/needs/tpl.sh ls | fzf)
  # get destination
  echo -n 'Enter destination: '
  read -i "$(pwd)" -e -r DEST
  # hand it over
  /change/this/tpl/tpl.sh "$TEMPLATE" "$DEST"
fi
```
