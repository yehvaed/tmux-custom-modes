#!/usr/bin/env bash

set -x
# globals
export CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

namespace="@TMUX_CUSTOM_MODES"
tmux set -g "${namespace}_PLUGIN_DIR" "${CURRENT_DIR}"

scripts_dir="${CURRENT_DIR}/scripts"
tmux set -g "${namespace}_SCRIPTS_DIR" "${scripts_dir}"

# helpers
option() { tmux show -gv "$@"; }

# setup
for mode in "normal" "<leader>"; do
    for key in {a..z} {A..Z} C-{a..z} C-{A..Z} \" \' ; do
        if [[ -z "$(tmux list-keys -T "${mode}" ${key} 2> /dev/null)" ]]; then
            tmux bind-key -T "${mode}" ${key} switch-client -T "${mode}"
        fi
    done
done


# first start from normal mode
${scripts_dir}/switch-mode.sh "normal"
