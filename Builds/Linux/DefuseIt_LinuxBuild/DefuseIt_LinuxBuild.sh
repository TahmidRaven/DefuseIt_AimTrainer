#!/bin/sh
printf '\033c\033]0;%s\a' Defuse_It
base_path="$(dirname "$(realpath "$0")")"
"$base_path/DefuseIt_LinuxBuild.x86_64" "$@"
