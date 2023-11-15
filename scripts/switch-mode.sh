#!/usr/bin/env bash
set -x
tmux set -g prefix None
tmux set -g key-table $1
tmux refresh-client -S
